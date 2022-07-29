import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry margin;

  const Subtitle(this.text, {Key? key, this.margin = EdgeInsets.zero, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: margin,
      child: Text(text, style: Theme.of(context).textTheme.subtitle2));
}
