import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

import '../../constants/routes.dart';

class NeedToLoginWidget extends StatelessWidget {
  const NeedToLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final theme = context.theme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
              constraints: BoxConstraints(minWidth: context.mediaQuery.size.width * .25),
              child: Image.asset(
                Images.signIn,
                fit: BoxFit.cover,
              )),
          const Separator(),
          Text(
            localization.youNeedToLogin,
            style: theme.textTheme.caption?.copyWith(fontSize: 14, color: theme.colorScheme.onBackground),
            textAlign: TextAlign.center,
          ),
          const Separator(
            size: 50,
          ),
          ConstrainedBox(
              constraints: BoxConstraints(minWidth: context.mediaQuery.size.width * .5),
              child: ButtonX(
                color: theme.colorScheme.onBackground,
                borderRadius: Dimens.radiusSmall.toBorderRadius(),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  context.pushReplacementNamed(Routes.login);
                },
                child: Text(localization.login),
              ))
        ],
      ),
    );
  }
}
