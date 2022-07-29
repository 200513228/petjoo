import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/dropdown_x.dart';
import 'package:petjoo/domain/entities/shift.dart';
import '../../../domain/enums/shift/hours.dart';
import '../../constants/dimens.dart';

class ShiftInputTile extends StatelessWidget {
  const ShiftInputTile(this.data, {Key? key, this.onStatusChanged, this.onStartChanged, this.onFinishChanged}) : super(key: key);

  final Shift data;
  final Function(bool)? onStatusChanged;
  final Function(Hours?)? onStartChanged;
  final Function(Hours?)? onFinishChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Material(
      borderRadius: Dimens.radiusSmall.toBorderRadius(),
      color: theme.colorScheme.onBackground,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.paddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    data.day.toLocalizedString(context),
                    style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onSurface),
                  ),
                ),
                Switch(value: data.isActive, onChanged: onStatusChanged),
              ],
            ),
            const SizedBox(
              height: Dimens.paddingSmallX,
            ),
            Row(
              children: [
                Expanded(
                    child: DropdownX(
                  contentPadding: const EdgeInsets.all(10),
                  value: Hours.one,
                  items: Hours.values.map((e) => DropdownMenuItem(value: e, child: Text(e.toTimeString(context)))).toList(),
                  onChanged: onStartChanged,
                )),
                const SizedBox(
                  width: Dimens.paddingSmallX,
                ),
                const Text('-'),
                const SizedBox(
                  width: Dimens.paddingSmallX,
                ),
                Expanded(
                    child: DropdownX(
                  contentPadding: const EdgeInsets.all(10),
                  value: Hours.one,
                  items: Hours.values.map((e) => DropdownMenuItem(value: e, child: Text(e.toTimeString(context)))).toList(),
                  onChanged: onFinishChanged,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
