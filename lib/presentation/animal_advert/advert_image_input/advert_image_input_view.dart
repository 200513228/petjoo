import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/infrastructure/repositories/advert_repository_impl.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/ui/tiles/image_tile.dart';

import 'advert_image_input_view_model.dart';

class AdvertImageInputView extends ConsumerStatefulWidget {
  final AdvertModel advert;
  const AdvertImageInputView(this.advert, {Key? key}) : super(key: key);

  @override
  ConsumerStateX<AdvertImageInputView> createState() => _AdvertImageInputViewState();
}

class _AdvertImageInputViewState extends ConsumerStateX<AdvertImageInputView> {
  late final advertImageInputViewModel =
      ChangeNotifierProvider.autoDispose((ref) => AdvertImageInputViewModel(context, AdvertRepositoryImpl(), widget.advert));
  late final viewModel = ref.read(advertImageInputViewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.addImage),
      ),
      body: Column(
        children: [
          Expanded(child: Consumer(builder: (context, ref, _) {
            final imagesLength = ref.watch(advertImageInputViewModel.select((value) => value.data.images.length));
            return GridView.builder(
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15),
                itemCount: imagesLength + 1,
                itemBuilder: (context, index) {
                  if (index == imagesLength) return addImageTile();
                  return Consumer(builder: (context, ref, _) {
                    final data = ref.watch(advertImageInputViewModel.select((value) => value.data.images[index]));
                    return ImageTile(
                      data,
                      onTap: () => viewModel.sureForDelete(data),
                    );
                  });
                });
          })),
          ButtonX(
            width: double.maxFinite,
            color: theme.colorScheme.secondary,
            borderRadius: Dimens.radiusSmall.toBorderRadius(),
            margin: const EdgeInsets.all(15),
            onTap: viewModel.save,
            child: Text(localization.next),
          )
        ],
      ),
    );
  }

  Widget addImageTile() => viewModel.data.images.length < 2
      ? Material(
          clipBehavior: Clip.antiAlias,
          color: theme.colorScheme.surface,
          borderRadius: Dimens.radius.toBorderRadius(),
          child: InkWell(
            onTap: viewModel.selectImage,
            child: const Icon(Icons.add_a_photo_rounded),
          ),
        )
      : const SizedBox();
}
