import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/domain/entities/shift.dart';
import '../../constants/dimens.dart';

class ShiftTile extends StatelessWidget {
  const ShiftTile(this.data, {Key? key}) : super(key: key);

  final Shift data;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;
    return Material(
      borderRadius: Dimens.radiusSmall.toBorderRadius(),
      color: theme.colorScheme.onBackground,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.paddingSmall),
        child: Row(
          children: [
            Expanded(
                child: Text(
              data.day.toLocalizedString(context),
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface),
            )),
            Text(
              data.isActive ? "${data.start.format(context)} - ${data.end.format(context)}" : localization.close,
              style: theme.textTheme.labelSmall?.copyWith(color: data.isActive ? Colors.greenAccent : Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
