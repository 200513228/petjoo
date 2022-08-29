import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/modules/chat/view/chat_tile_view.dart';
import 'package:petjoo/modules/chat/viewmodel/chat_list_viewmodel.dart';

class ChatListView extends StatelessWidget {
  final ChatListViewModel vm = ChatListViewModel();
  ChatListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.getChats();
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Observer(builder: (_) {
          return RefreshIndicator(
            onRefresh: () => vm.getChats(),
            child: ListView(
              children: [
                ...vm.chatList.map((e) => ChatTileView(model: e)),
              ],
            ),
          );
        }),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Gelen Kutusu'),
    );
  }
}
