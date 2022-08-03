import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/product/ui/widgets/image_x.dart';
import 'package:petjoo/teska/pet/pet_advert_model.dart';

import '../../product/constants/dimens.dart';
import '../../product/constants/images.dart';

class PetAdvertTile extends StatelessWidget {
  final PetAdvertModel data;
  final void Function()? onTap;
  const PetAdvertTile(this.data, {Key? key, this.onTap}) : super(key: key);

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
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(data.title,
                                maxLines: 1,
                                style: theme.textTheme.bodyText1,
                                overflow: TextOverflow.clip,
                                softWrap: false),
                            const SizedBox(height: 5),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                        // data.animalType.toLocalizedString(context),
                                        data.animalType.toString(),
                                        maxLines: 1,
                                        style: theme.textTheme.caption),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    // data.animalType.toIconData(),
                                    Icons.abc,
                                    size: 12,
                                    color: Colors.orangeAccent,
                                  ),
                                ]),
                            const SizedBox(height: 5),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    // data.date.toDateString(),
                                    data.date.toDate().day.toString() +
                                        '.' +
                                        data.date.toDate().month.toString() +
                                        '.' +
                                        data.date.toDate().year.toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.caption,
                                  ),
                                  Expanded(
                                    child: Text(
                                      // data.type.toLocalizedString(context),
                                      data.type.toString(),
                                      style: theme.textTheme.caption?.copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red
                                          //  data.type.toColor(),
                                          ),
                                      textAlign: TextAlign.end,
                                      maxLines: 1,
                                    ),
                                  ),
                                ]),
                          ])))
            ])));
  }
}
