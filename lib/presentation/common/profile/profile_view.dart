import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/presentation/common/profile/profile_view_model.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/constants/dial_codes.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/constants/validators.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerStateX<ProfileView> {
  late final profileViewModel = ChangeNotifierProvider.autoDispose((ref) => ProfileViewModel(context, ref.read(userProvider)));
  late final viewModel = ref.read(profileViewModel);
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileViewModel.select((value) => value.isLoading));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toAll(theme.scaffoldBackgroundColor, Brightness.dark),
      child: isLoading
          ? Loading(
              background: theme.scaffoldBackgroundColor,
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(localization.profile),
              ),
              body: Form(
                key: viewModel.formKey,
                child: ListView(padding: const EdgeInsets.all(Dimens.paddingSmall), children: [
                  TextFormField(
                    controller: viewModel.nameController,
                    keyboardType: TextInputType.name,
                    maxLength: 50,
                    textInputAction: TextInputAction.next,
                    validator: Validators.title(localization.nameError),
                    decoration: InputDecoration(
                      counterText: '',
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
                      counterText: '',
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
                              counterText: '',
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
                  ButtonX(
                      borderRadius: Dimens.radiusSmall.toBorderRadius(),
                      margin: const EdgeInsets.only(top: Dimens.padding),
                      padding: const EdgeInsets.all(Dimens.paddingSmall),
                      color: theme.colorScheme.secondary,
                      onTap: viewModel.save,
                      child: Text(
                        localization.save,
                        textAlign: TextAlign.center,
                      ))
                ]),
              ),
            ),
    );
  }
}
