import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/repositories/advert_repository.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_detail_view.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_filter_view.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/product/models/advert_filter_model.dart';

class AdvertSearchViewModel extends PageNotifier {
  AdvertSearchViewModel(super.context, this._repository);

  final AdvertRepository _repository;

  AdvertFilterModel _filter = const AdvertFilterModel();

  AdvertModelList adverts = [];

  AdvertModelList filteredAdverts = [];

  String queryText = "";

  late final scrollController = ScrollController()..addListener(_scrollListener);

  void advertDetail(AdvertModel data) => context.push(AdvertDetailView(data));

  void showFilter() async {
    final result = await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: context.mediaQuery.size.height - context.mediaQuery.padding.top),
        context: context,
        builder: (context) => AdvertFilterView(data: _filter));
    if (result != null) {
      _filter = result;
      getAdverts();
    }
  }

  Future<AdvertModelList> getAdverts() async {
    adverts = await _repository.searchAdvert(filter: _filter);
    onQueryChanged(queryText);
    return filteredAdverts;
  }

  Future<AdvertModelList> getMoreAdverts() async {
    adverts.addAll(await _repository.searchAdvert(filter: _filter, lastDocument: adverts.lastOrNull?.document));
    onQueryChanged(queryText);
    return filteredAdverts;
  }

  void onQueryChanged(String value) {
    queryText = value;
    if (adverts.isEmpty || value.isEmpty) {
      filteredAdverts = adverts;
    } else {
      filteredAdverts = adverts.where((x) => x.title.toLowerCase().contains(value.toLowerCase())).toList();
    }
    notifyListeners();
  }

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
}
