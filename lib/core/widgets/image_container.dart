import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final Widget image;
  final double? width;
  final double? height;
  final BoxShape shape;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final Color? background;
  final void Function()? onTap;
  const ImageContainer(
      {Key? key,
      required this.image,
      this.width,
      this.height,
      this.borderRadius,
      this.background,
      this.margin,
      this.shape = BoxShape.rectangle,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: margin,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: borderRadius,shape: shape),
        child: Material(
          color: background,
          child: InkWell(onTap: onTap, child: AspectRatio(aspectRatio: 1, child: image)),
        ));
  }
}
