import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/images.dart';
import 'package:petjoo/core/extensions/datetime_extension.dart';
import 'package:petjoo/product/ui/widgets/image_x.dart';

class AdvertTile extends StatelessWidget {
  final AdvertModel data;
  final void Function()? onTap;

  const AdvertTile(this.data, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
        color: theme.colorScheme.surface,
        clipBehavior: Clip.antiAlias,
        borderRadius: Dimens.radiusSmall.toBorderRadius(),
        child: InkWell(
            onTap: onTap,
            child: Column(children: [
              ImageX(
                data.images.firstOrNull ?? "",
                aspectRatio: 1,
                errorAsset: Images.noImage,
                borderRadius: Dimens.radiusSmall.toBottomBorderRadius(),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        Text(data.title, maxLines: 1, style: theme.textTheme.bodyText1, overflow: TextOverflow.clip, softWrap: false),
                        const SizedBox(height: 5),
                        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Flexible(child: Text(data.animalType.toLocalizedString(context), maxLines: 1, style: theme.textTheme.caption)),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            data.animalType.toIconData(),
                            size: 12,
                            color: Colors.orangeAccent,
                          ),
                        ]),
                        const SizedBox(height: 5),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Text(
                            data.date.toDateString(),
                            maxLines: 1,
                            style: theme.textTheme.caption,
                          ),
                          Expanded(
                            child: Text(
                              data.type.toLocalizedString(context),
                              style: theme.textTheme.caption?.copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: data.type.toColor()),
                              textAlign: TextAlign.end,
                              maxLines: 1,
                            ),
                          ),
                        ]),
                      ])))
            ])));
  }
}
