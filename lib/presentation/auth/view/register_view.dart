import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/core/widgets/tip_text_button.dart';
import 'package:petjoo/product/constants/dial_codes.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/docs.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/constants/validators.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';
import '../../settings/view/document_detail_view.dart';
import '../view_model/register_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerStateX<RegisterView> {
  late final registerViewModel = ChangeNotifierProvider((ref) => RegisterViewModel(context));
  late final viewModel = ref.read(registerViewModel);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toAll(theme.colorScheme.background, Brightness.dark),
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.padding),
          children: [
            Image.asset(
              Images.logo,
            ),
            Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: viewModel.emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: Validators.email(localization.emailError),
                      decoration: InputDecoration(
                        label: Text(localization.email),
                      ),
                    ),
                    const Separator(),
                    TextFormField(
                      controller: viewModel.nameController,
                      keyboardType: TextInputType.name,
                      maxLength: 50,
                      textInputAction: TextInputAction.next,
                      validator: Validators.title(localization.nameError),
                      decoration: InputDecoration(
                        label: Text(localization.name),
                      ),
                    ),
                    const Separator(),
                    TextFormField(
                      controller: viewModel.surnameController,
                      keyboardType: TextInputType.name,
                      maxLength: 50,
                      textInputAction: TextInputAction.next,
                      validator: Validators.title(localization.surnameError),
                      decoration: InputDecoration(
                        label: Text(localization.surname),
                      ),
                    ),
                    const Separator(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ValueListenableBuilder<String>(
                            valueListenable: viewModel.dialCode,
                            builder: (context, value, _) => DropdownX<String>(
                              value: value,
                              borderRadius: Dimens.radiusSmall.toLeftBorderRadius(),
                              validator: (value) => value?.isEmpty == true ? "" : null,
                              items: dialCodes.values
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            controller: viewModel.phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            textInputAction: TextInputAction.next,
                            validator: Validators.phone(localization.phoneError),
                            decoration: InputDecoration(
                                label: Text(localization.phone),
                                hintText: localization.phoneFormat,
                                border: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                                focusedBorder: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                                errorBorder: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius()),
                                focusedErrorBorder: UnderlineInputBorder(borderRadius: Dimens.radiusSmall.toRightBorderRadius())),
                          ),
                        ),
                      ],
                    ),
                    const Separator(),
                    TextFormField(
                      controller: viewModel.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: Validators.password(localization.passwordError),
                      obscureText: true,
                      decoration: InputDecoration(label: Text(localization.password)),
                    ),
                    const Separator(),
                    const Separator(),
                    Text(localization.registerAgreementDescription),
                    const Separator(
                      size: Dimens.paddingSmallX,
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: localization.termOfUse,
                          style: theme.textTheme.subtitle2,
                          recognizer: TapGestureRecognizer()..onTap = () => context.push(DocumentDetailView(Docs.termsOfUse))),
                      TextSpan(text: " ${localization.and} "),
                      TextSpan(
                          text: localization.privacyPolicy,
                          style: theme.textTheme.subtitle2,
                          recognizer: TapGestureRecognizer()..onTap = () => context.push(DocumentDetailView(Docs.privacyPolicy)))
                    ])),
                    const Separator(),
                    const Separator(),
                    ButtonX(
                      width: double.maxFinite,
                      color: theme.colorScheme.secondary,
                      borderRadius: Dimens.radiusSmall.toBorderRadius(),
                      onTap: viewModel.register,
                      child: Text(
                        localization.register,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Separator(),
                    TipTextButton(
                      tip: Text(
                        localization.alreadyHaveAnAccount,
                        style: TextStyle(color: theme.colorScheme.secondary),
                      ),
                      text: Text(
                        localization.login,
                        style: TextStyle(color: theme.colorScheme.secondary),
                      ),
                      onTap: viewModel.login,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
