import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/core/widgets/tip_text_button.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/constants/validators.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';
import '../view_model/login_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerStateX<LoginView> {
  late final loginViewModel = ChangeNotifierProvider.autoDispose((ref) => LoginViewModel(context, ref.read(userProvider)));
  late final viewModel = ref.read(loginViewModel);

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loginViewModel.select((value) => value.isLoading));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toAll(theme.colorScheme.background, Brightness.dark),
      child: isLoading
          ? Loading(
              background: theme.colorScheme.background,
            )
          : Scaffold(
              appBar: AppBar(),
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.padding),
                children: [
                  Image.asset(
                    Images.logo,
                    height: mediaQuery.size.width * .7,
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
                        ValueListenableBuilder<bool>(
                            valueListenable: viewModel.isPasswordVisible,
                            builder: (context, value, _) {
                              return TextFormField(
                                controller: viewModel.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                validator: Validators.password(localization.passwordError),
                                obscureText: !value,
                                decoration: InputDecoration(
                                    label: Text(localization.password),
                                    suffixIcon: GestureDetector(
                                      onTap: viewModel.changePasswordVisibility,
                                      child: Icon(
                                        value ? Icons.remove_red_eye_rounded : Icons.password_rounded,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    )),
                              );
                            }),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: viewModel.forgotPassword,
                                child: Text(
                                  localization.forgotPassword,
                                  style: TextStyle(color: theme.colorScheme.secondary),
                                ))),
                        const Separator(),
                        ButtonX(
                          width: double.maxFinite,
                          color: theme.colorScheme.secondary,
                          borderRadius: Dimens.radiusSmall.toBorderRadius(),
                          onTap: viewModel.signIn,
                          child: Text(
                            localization.login,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Separator(),
                        TipTextButton(
                          tip: Text(
                            localization.dontHaveAnAccount,
                            style: TextStyle(color: theme.colorScheme.secondary),
                          ),
                          text: Text(
                            localization.register,
                            style: TextStyle(color: theme.colorScheme.secondary),
                          ),
                          onTap: viewModel.register,
                        ),
                        const Separator(),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
