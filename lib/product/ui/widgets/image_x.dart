import 'package:flutter/material.dart';
import 'package:petjoo/product/constants/images.dart';

class ImageX extends StatelessWidget {
  final String image;
  final double? aspectRatio;
  final double? height;
  final double? width;
  final String? errorAsset;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final BoxShape shape;

  const ImageX(this.image,
      {Key? key, this.errorAsset, this.aspectRatio, this.width, this.height, this.borderRadius, this.margin, this.shape = BoxShape.rectangle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return aspectRatio == null
        ? _container()
        : AspectRatio(
            aspectRatio: aspectRatio!,
            child: _container(),
          );
  }

  Widget _container() => Container(
        margin: margin,
        height: height,
        width: width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: borderRadius, shape: shape),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          errorBuilder: (context, _, __) => Image.asset(
            errorAsset ?? Images.noImage,
            fit: BoxFit.cover,
          ),
        ),
      );
}
