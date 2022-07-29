import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/images.dart';
import 'separator.dart';

class NothingToSeeHereWidget extends StatelessWidget {
  const NothingToSeeHereWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final theme = context.theme;
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.emptyBox),
              const Separator(),
              Text(
                localization.nothingToSeeHere,
                style: theme.textTheme.caption?.copyWith(fontSize: 14, color: theme.colorScheme.onBackground),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
