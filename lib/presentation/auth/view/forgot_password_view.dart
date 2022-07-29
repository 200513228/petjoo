import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/presentation/auth/view_model/forgot_password_view_model.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/constants/validators.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  final String email;
  const ForgotPasswordView(this.email, {Key? key}) : super(key: key);

  @override
  ConsumerStateX<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerStateX<ForgotPasswordView> {
  late final forgotPasswordViewModel = ChangeNotifierProvider.autoDispose((ref) => ForgotPasswordViewModel(context, widget.email));
  late final viewProvider = ref.read(forgotPasswordViewModel);
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(forgotPasswordViewModel.select((value) => value.isLoading));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toAll(theme.colorScheme.background, Brightness.dark),
      child: isLoading
          ? Loading(
              background: theme.scaffoldBackgroundColor,
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(localization.forgotPassword),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localization.enterYourEmail,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.caption?.copyWith(fontSize: 18, color: theme.colorScheme.onBackground),
                          ),
                          const Separator(),
                          Flexible(
                            child: TextFormField(
                              controller: viewProvider.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: Validators.email(localization.emailError),
                              decoration: InputDecoration(
                                label: Text(localization.email),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ButtonX(
                      padding: const EdgeInsets.all(Dimens.paddingSmall),
                      margin: const EdgeInsets.all(Dimens.padding),
                      color: theme.colorScheme.secondary,
                      borderRadius: Dimens.radiusSmall.toBorderRadius(),
                      onTap: viewProvider.sendEmail,
                      child: Text(localization.sendEmail, textAlign: TextAlign.center)),
                ],
              ),
            ),
    );
  }
}
