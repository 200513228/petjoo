import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/repositories/advert_repository.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/product/constants/routes.dart';

import '../view/advert_detail_view.dart';

class AdvertUserListViewModel extends PageNotifier {
  AdvertUserListViewModel(super.context, this._repository) {
    refreshAdverts();
  }

  final AdvertRepository _repository;
  AdvertModelList adverts = [];

  late final scrollController = ScrollController()..addListener(_scrollListener);

  Future<void> refreshAdverts() async {
    adverts = await _repository.getAdverts();
    notifyListeners();
  }

  Future<void> getMoreAdverts() async {
    adverts.addAll(await _repository.getAdverts(adverts.lastOrNull?.document));
    notifyListeners();
  }

  void advertDetail(AdvertModel data) => context.push(AdvertDetailView(data));

  void search() => context.pushNamed(Routes.advertSearch);

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      getMoreAdverts();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  getAdverts() => _repository.getUserAdverts(FirebaseAuth.instance.currentUser!.uid);
}
