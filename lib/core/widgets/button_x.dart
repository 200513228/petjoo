import 'package:flutter/material.dart';

class ButtonX extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onTap;

  const ButtonX(
      {Key? key,
      required this.child,
      this.width,
      this.height,
      this.color,
      this.margin = EdgeInsets.zero,
      this.padding = const EdgeInsets.all(12),
      this.borderRadius,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: margin,
        child: Material(
          color: color,
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
                padding: padding,
                child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.button ?? const TextStyle(),
                    softWrap: false,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    child: child)),
          ),
        ));
  }
}
