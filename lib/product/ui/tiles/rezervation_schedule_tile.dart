import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';

import '../../constants/dimens.dart';

class RezervationScheduleTile extends StatelessWidget {
  const RezervationScheduleTile({
    Key? key,
    required this.start,
    required this.end,
    required this.isEmpty,
    this.onTap,
  }) : super(key: key);

  final TimeOfDay start;
  final TimeOfDay end;
  final bool? isEmpty;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;

    return SizedBox(
      height: 55,
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: theme.colorScheme.onBackground,
        borderRadius: Dimens.radiusSmall.toBorderRadius(),
        child: InkWell(
          onTap: isEmpty == true ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.paddingSmall),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            start.format(context),
                            style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(isEmpty != false ? 1.0 : .5)),
                          ),
                        ),
                        Text(
                          '-',
                          style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(isEmpty != false ? 1.0 : .5)),
                        ),
                        Expanded(
                          child: Text(
                            end.format(context),
                            textAlign: TextAlign.end,
                            style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(isEmpty != false ? 1.0 : .5)),
                          ),
                        ),
                      ],
                    )),
                Visibility(
                  visible: isEmpty != null,
                  child: Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: isEmpty == true
                          ? Icon(
                              Icons.arrow_forward_rounded,
                              color: theme.colorScheme.onSurface,
                              size: 22,
                            )
                          : Text(
                              localization.reserved,
                              style: theme.textTheme.labelSmall?.copyWith(color: Colors.redAccent),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
