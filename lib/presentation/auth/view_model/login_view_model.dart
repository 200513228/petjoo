import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/network/requests.dart';
import 'package:petjoo/product/providers/user_provider.dart';

class LoginViewModel extends PageNotifier {
  final UserProvider userProvider;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginViewModel(BuildContext context, this.userProvider) : super(context);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void forgotPassword() => context.pushNamed(Routes.forgotPassword, arguments: emailController.text);

  void register() => context.pushReplacementNamed(Routes.register);

  void signIn() async {
    if (!formKey.currentState!.validate()) return;
    changeLoading();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      await createUser(credential);
      return;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          context.showSnackBar(context.localization.invalidEmail);
          break;
        case 'user-not-found':
          context.showSnackBar(context.localization.wrongEmail);
          break;
        case 'wrong-password':
          context.showSnackBar(context.localization.wrongEmailOrPassword);
          break;
        default:
          log(e.toString());
          context.showSnackBar(context.localization.somethingWentWrong);
          break;
      }
    } catch (e) {
      log(e.toString());
      context.showSnackBar(context.localization.somethingWentWrong);
    }
    changeLoading();
  }

  void signInWith(Future<UserCredential> Function() func) async {
    changeLoading();
    try {
      await createUser(await func.call());
      return;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          context.showSnackBar(context.localization.invalidEmail);
          break;
        case 'user-not-found':
        case 'wrong-password':
          context.showSnackBar(context.localization.wrongEmailOrPassword);
          break;
        default:
          context.showSnackBar(context.localization.somethingWentWrong);
          break;
      }
    } catch (e) {
      log(e.toString());
      context.showSnackBar(context.localization.somethingWentWrong);
    }
    changeLoading();
  }

  Future<void> createUser(UserCredential credential) async {
    if (credential.user == null) return;

    await Requests.createUserIfNotExist(credential.user!.uid, credential.user!.email!).then((value) {
      if (value == null) {
        //pushReplacementNamed(Routes.registerProfile, arguments: user);
      } else {
        userProvider.user = value;
        context.pushNamedAndRemoveUntil(Routes.navigation, predicate: (_) => false);
      }
    }, onError: (e) {
      log(e.toString());
      //pushReplacementNamed(Routes.registerProfile, arguments: UserModel(id: credential.user!.uid, email: credential.user!.email!));
    });
  }

  void changePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;
}
