import 'package:flutter/material.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/models/chat_model.dart';

class ChatListViewModel extends PageNotifier {
  ChatListViewModel(BuildContext context) : super(context);

  void messages(ChatModel data) => context.pushNamed(Routes.messages, arguments: data);

  // sureForDelete(String id) {
  //   showDialog(
  //       context: context,
  //       builder: (context) => DeleteDialog(
  //             onDeleteTap: () => deleteImage(id),
  //           ));
  // }

  // deleteImage(String id) {
  //   context.pop();
  //   Requests.deleteChat(id).onError((error, stackTrace) {
  //     context.showSnackBar(context.localization.somethingWentWrong);
  //   });
  // }
}
