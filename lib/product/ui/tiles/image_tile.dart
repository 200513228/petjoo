import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';

class ImageTile extends StatelessWidget {
  final String image;
  final Function()? onTap;

  const ImageTile(this.image, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Material(
      color: theme.colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: Dimens.radius.toBorderRadius(),
      ),
      child: image.isEmpty
          ? const Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator())
          : Stack(fit: StackFit.expand, children: [
              Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, __) => Image.asset(Images.noImage),
                    ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimens.radius),
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    onPressed: onTap,
                  ),
                ),
              )
            ]),
    );
  }
}
