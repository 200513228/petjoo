import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/datetime_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/domain/enums/reservation/reservation_status.dart';
import 'package:petjoo/product/constants/dimens.dart';
import '../../../infrastructure/model/transport_reservation_model.dart';

class TransportReservationRequestTile extends StatelessWidget {
  final TransportReservationModel data;
  final void Function()? onTap;
  final void Function()? onApprovedTap;
  final void Function()? onDeniedTap;

  const TransportReservationRequestTile(this.data, {Key? key, this.onTap, this.onApprovedTap, this.onDeniedTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    const height = 80.0;
    return SizedBox(
      height: height,
      child: Material(
          color: theme.colorScheme.surface,
          clipBehavior: Clip.antiAlias,
          borderRadius: Dimens.radiusSmall.toBorderRadius(),
          child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.paddingSmall),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(Icons.fire_truck_rounded),
                          Text(
                            context.localization.transport,
                            style: context.theme.textTheme.caption?.copyWith(fontSize: 10),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: Dimens.paddingSmall,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.fullName,
                            style: context.theme.textTheme.bodyText1,
                            maxLines: 1,
                          ),
                          Text(
                            data.status.toLocalizedString(context),
                            style: context.theme.textTheme.labelSmall?.copyWith(color: data.status.toColor(), fontSize: 10),
                            maxLines: 1,
                          ),
                          Text(
                            data.date.toDateTimeString(),
                            style: context.theme.textTheme.caption?.copyWith(fontSize: 10),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    ...data.status == ReservationStatus.waiting
                        ? [
                            _actionButton(
                                context,
                                const Icon(
                                  Icons.close_rounded,
                                  color: Colors.redAccent,
                                  size: 16,
                                ),
                                onDeniedTap),
                            _actionButton(
                                context,
                                const Icon(
                                  Icons.check_rounded,
                                  color: Colors.greenAccent,
                                  size: 16,
                                ),
                                onApprovedTap),
                          ]
                        : [],
                  ],
                ),
              ))),
    );
  }

  Widget _actionButton(BuildContext context, Icon icon, void Function()? onTap) => MaterialButton(
      color: context.theme.colorScheme.onBackground,
      minWidth: 40,
      height: 40,
      elevation: 0,
      shape: const CircleBorder(),
      onPressed: onTap,
      child: icon);
}
