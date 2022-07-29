import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/x_file_extension.dart';
import 'package:petjoo/domain/repositories/advert_repository.dart';
import 'package:petjoo/presentation/common/successfully_saved/successfully_saved_view.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/product/ui/dialogs/delete_dialog.dart';

import '../../../product/constants/routes.dart';

class AdvertImageInputViewModel extends PageNotifier {
  AdvertImageInputViewModel(super.context, this._repository, this.data);

  final AdvertRepository _repository;
  final AdvertModel data;

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final result = await image.compress();
        if (result != null) {
          data.images.add("");
          notifyListeners();
          _repository.addAdvertImage(data.id!, result).then((id) {
            data.images.last = id;
            notifyListeners();
          });
        }
      }
    } catch (e) {
      context.showSnackBar(context.localization.somethingWentWrong);
    }
  }

  save() => context.push(SuccessfullySaved(
        onTap: (context) => context.popUntil(predicate: (route) => route.settings.name == Routes.advertUserList || route.isFirst),
      ));

  sureForDelete(String image) {
    showDialog(
        context: context,
        builder: (context) => DeleteDialog(
              onDeleteTap: () => deleteImage(image),
            ));
  }

  deleteImage(String image) {
    context.pop();
    _repository.deleteAdvertImage(data.id!, image).then((value) {
      data.images.remove(image);
      notifyListeners();
    }).onError((error, stackTrace) {
      context.showSnackBar(context.localization.somethingWentWrong);
    });
  }
}
