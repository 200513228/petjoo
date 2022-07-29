import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/product/constants/dimens.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final EdgeInsetsGeometry margin;
  final bool showArrow;
  final void Function()? onTap;

  const SettingsTile({Key? key, required this.icon, required this.title, this.showArrow = true, this.margin = EdgeInsets.zero, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: margin,
      child: Material(
        color: theme.colorScheme.surface,
        clipBehavior: Clip.antiAlias,
        borderRadius: Dimens.radius.toBorderRadius(),
        child: ListTile(
            horizontalTitleGap: 3,
            contentPadding: const EdgeInsets.fromLTRB(3, 3, 13, 3),
            leading: AspectRatio(
              aspectRatio: 1,
              child: Icon(
                icon,
                size: 30,
                color: theme.iconTheme.color,
              ),
            ),
            trailing: showArrow
                ? Icon(
                    Icons.arrow_forward_rounded,
                    color: theme.iconTheme.color,
                  )
                : null,
            title: Text(
              title,
              maxLines: 1,
              style: theme.textTheme.bodyText1?.copyWith(color: theme.iconTheme.color),
            ),
            onTap: onTap),
      ),
    );
  }
}
