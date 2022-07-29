import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/product/ui/widgets/image_x.dart';

class TransportTile extends StatelessWidget {
  final TransportAdvertModel data;
  final void Function()? onTap;
  final void Function()? onCallTap;
  final void Function()? onMessageTap;

  const TransportTile(this.data, {Key? key, this.onTap, this.onCallTap, this.onMessageTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;
    const height = 90.0;
    final isAnonymous = FirebaseAuth.instance.currentUser?.isAnonymous == true;
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
                child: Row(children: [
                  ImageX(
                    data.images.firstOrNull ?? "",
                    aspectRatio: 1,
                    errorAsset: Images.noImage,
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
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
                        data.title,
                        style: context.theme.textTheme.bodyText1,
                        maxLines: 1,
                      ),
                      Text(
                        "${localization.turkishCurrency}${data.pricePerKm}/${localization.km}",
                        style: context.theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurface),
                        maxLines: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _featureIcon(context, FontAwesomeIcons.earthAmericas, data.isIntercity),
                          _featureIcon(context, FontAwesomeIcons.shieldDog, data.hasCage),
                          _featureIcon(context, Icons.circle_outlined, data.hasCollar),
                          _featureIcon(context, FontAwesomeIcons.personRunning, data.canCatch),
                        ],
                      )
                    ],
                  )),
                  const SizedBox(
                    width: Dimens.paddingSmallX,
                  ),
                  _actionButton(
                      context,
                      const Icon(
                        Icons.call_rounded,
                        color: Colors.greenAccent,
                        size: 16,
                      ),
                      onCallTap),
                  Visibility(
                    visible: !isAnonymous,
                    child: _actionButton(
                        context,
                        const Icon(
                          Icons.message_rounded,
                          color: Colors.orangeAccent,
                          size: 16,
                        ),
                        onMessageTap),
                  ),
                ]),
              ))),
    );
  }

  Widget _featureIcon(BuildContext context, IconData icon, bool active) => Icon(
        icon,
        size: 16,
        color: active ? null : context.theme.colorScheme.onSurface.withOpacity(.3),
      );

  Widget _actionButton(BuildContext context, Icon icon, void Function()? onTap) => MaterialButton(
      color: context.theme.colorScheme.onBackground,
      minWidth: 40,
      height: 40,
      elevation: 0,
      shape: const CircleBorder(),
      onPressed: onTap,
      child: icon);
}
