import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/network/requests.dart';
import 'picker_x.dart';
import 'separator.dart';

class ProfileContainer extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const ProfileContainer({Key? key, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;
    final mediaQuery = context.mediaQuery;
    return Container(
      margin: margin,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: Dimens.radius.toBorderRadius()),
      child: Consumer(builder: (context, ref, child) {
        final user = ref.watch(userProvider).user;
        return Column(
          children: [
            PickerX(
              user.image,
              size: mediaQuery.size.height * .2,
              errorAsset: Images.noImage,
              onImagePicked: (image) => pickImage(user.id, image, () => context.showSnackBar(localization.somethingWentWrong)),
            ),
            const Separator(),
            Text(
              user.fullname,
              style: theme.textTheme.subtitle1?.copyWith(color: theme.colorScheme.surface),
            ),
            const Separator(),
          ],
        );
      }),
    );
  }

  pickImage(String userId, File image, Function() onError) async {
    try {
      Requests.changeUserPhoto(userId, image);
    } catch (_) {
      onError.call();
    }
  }
}
