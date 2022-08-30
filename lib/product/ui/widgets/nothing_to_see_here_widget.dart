import 'package:flutter/material.dart';
import 'package:petjoo/product/constants/images.dart';
import 'separator.dart';

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
              const Separator(),
              const Text(
                'Burada Görülecek Bir Şey Yok.',
                style: TextStyle(fontSize: 14, color: Colors.black),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
