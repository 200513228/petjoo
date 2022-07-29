import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petjoo/core/extensions/x_file_extension.dart';
import 'package:petjoo/product/constants/images.dart';

class PickerX extends StatelessWidget {
  final double size;
  final dynamic image;
  final String? errorAsset;
  final Function(File image)? onImagePicked;
  const PickerX(this.image, {Key? key, this.errorAsset, this.size = 50, this.onImagePicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size,
      width: size,
      child: GestureDetector(
        onTap: onTap,
        child: AspectRatio(
            aspectRatio: 1,
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: image is File
                    ? Image.file(image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) => Image.asset(
                              errorAsset ?? Images.noImage,
                              fit: BoxFit.cover,
                            ))
                    : Image.network(image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, _, __) => Image.asset(
                              errorAsset ?? Images.noImage,
                              fit: BoxFit.cover,
                            )))),
      ),
    );
  }

  Future<void> onTap() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final result = await image.compress();
      if (result != null) {
        onImagePicked?.call(result);
      }
    }
  }
}
