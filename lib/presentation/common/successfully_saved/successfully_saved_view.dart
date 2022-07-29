import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

class SuccessfullySaved extends StatefulWidget {
  const SuccessfullySaved({Key? key, required this.onTap}) : super(key: key);

  final Function(BuildContext context) onTap;

  @override
  State<SuccessfullySaved> createState() => _SuccessfullySavedState();
}

class _SuccessfullySavedState extends State<SuccessfullySaved> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Images.checked,
                fit: BoxFit.contain,
                width: context.mediaQuery.size.width * .5,
              ),
              const Separator(
                size: 50,
              ),
              Text(
                localization.successfullySaved,
                style: theme.textTheme.caption?.copyWith(fontSize: 20, color: theme.colorScheme.onBackground),
                textAlign: TextAlign.center,
              )
            ],
          )),
          ButtonX(
              width: double.maxFinite,
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              margin: const EdgeInsets.all(Dimens.padding),
              padding: const EdgeInsets.all(Dimens.paddingSmall),
              color: theme.colorScheme.secondary,
              onTap: () => widget.onTap(context),
              child: Text(
                localization.backToHome,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
