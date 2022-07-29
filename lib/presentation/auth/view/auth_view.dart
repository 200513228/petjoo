import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/presentation/auth/view_model/auth_view_model.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/docs.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

import '../../settings/view/document_detail_view.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerStateX<AuthView> {
  late final authViewModel = ChangeNotifierProvider.autoDispose((ref) => AuthViewModel(context));
  late final viewModel = ref.read(authViewModel);

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModel.select((value) => value.isLoading));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toAll(theme.colorScheme.background, Brightness.dark),
      child: Scaffold(
        body: isLoading
            ? const Loading()
            : Padding(
                padding: const EdgeInsets.all(Dimens.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(Images.logo),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(child: authButton(Images.login, localization.login, viewModel.signIn)),
                            const Separator(),
                            Expanded(child: authButton(Images.login, localization.register, viewModel.register)),
                          ],
                        ),
                        const Separator(),
                        authButton(Images.anonymous, localization.continueWithoutLogin, viewModel.signInAnonymously),
                      ],
                    )),
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
                  ],
                ),
              ),
      ),
    );
  }

  Widget authButton(String asset, String text, Function() onTap) => SizedBox(
        height: 70,
        child: Material(
          color: theme.colorScheme.secondary,
          clipBehavior: Clip.antiAlias,
          borderRadius: Dimens.radiusSmall.toBorderRadius(),
          child: InkWell(
            onTap: onTap,
            child: Padding(
                padding: const EdgeInsets.all(Dimens.paddingSmall),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      asset,
                      fit: BoxFit.contain,
                    ),
                    const Separator(),
                    Flexible(
                        child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.button,
                      maxLines: 1,
                    ))
                  ],
                )),
          ),
        ),
      );
}
