import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/modules/base/images.dart';

class NothingToSeeHereWidget extends StatelessWidget {
  const NothingToSeeHereWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Text(
                'toseehere'.tr(),
                style: const TextStyle(fontSize: 14, color: Colors.black),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
