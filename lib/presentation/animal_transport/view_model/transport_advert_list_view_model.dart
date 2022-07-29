import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/repositories/transport_repository.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../product/models/chat_model.dart';
import '../../../product/providers/chat_provider.dart';
import '../../chat/view/chat_message_list_view.dart';

class TransportAdvertListViewModel extends PageNotifier {
  TransportAdvertListViewModel(super.context, this._repository, this._chatProvider) {
    refreshTransports();
  }
  final TransportRepository _repository;
  final ChatProvider _chatProvider;

  TransportAdvertModelList advertList = [];

  late final scrollController = ScrollController()..addListener(_scrollListener);

  Future<void> refreshTransports() async {
    advertList = await _repository.getTransportAdverts();
    notifyListeners();
  }

  Future<void> getMoreTransports() async {
    advertList.addAll(await _repository.getTransportAdverts(advertList.lastOrNull?.document));
    notifyListeners();
  }

  void transportDetail(TransportAdvertModel data) => context.pushNamed(Routes.transportAdvertDetail, arguments: data);

  void search() => context.pushNamed(Routes.advertSearch);

  void call(TransportAdvertModel data) => _launch('tel:${data.dialCode}${data.phone}');

  void message(TransportAdvertModel data) => context.push(ChatMessageListView(
      _chatProvider.chats.firstOrNullWhere((x) => x.userIds.containsAll([FirebaseAuth.instance.currentUser!.uid, data.id!])) ??
          ChatModel(userIds: [FirebaseAuth.instance.currentUser!.uid, data.id!])));

  Future<void> _launch(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      getMoreTransports();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
