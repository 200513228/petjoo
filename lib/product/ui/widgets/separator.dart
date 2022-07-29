import 'package:flutter/material.dart';
import 'package:petjoo/product/constants/dimens.dart';

class Separator extends StatelessWidget {
  final double size;
  const Separator({ Key? key, this.size = Dimens.paddingSmall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size
    );
  }
}