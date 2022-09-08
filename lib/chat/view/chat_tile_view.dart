import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/ui/loading.dart';
import 'package:petjoo/base/string_converters.dart';
import 'package:petjoo/chat/model/chat_model.dart';
import 'package:petjoo/chat/viewmodel/chat_tile_viewmodel.dart';
import 'package:petjoo/user/model/current_user.dart';
import 'package:petjoo/constants/images.dart';

class ChatTileView extends StatelessWidget {
  final ChatTileViewModel vm = ChatTileViewModel();
  final ChatModel model;
  ChatTileView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List findUser = model.userIds;
    findUser.remove(CurrentUser.id);
    vm.getUserInfo(findUser.first);
    vm.checkBlock(findUser.first);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Observer(builder: (_) {
        return vm.isLoading
            ? const ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Loading(),
                subtitle: Text(''),
              )
            : Badge(
                badgeContent: const Text(''),
                showBadge: (model.lastMessage.senderId != CurrentUser.id &&
                    !model.lastMessage.isReaded),
                child: ListTile(
                    onTap: () {
                      model.lastMessage.senderId != CurrentUser.id
                          ? vm.readChat(model.id)
                          : null;
                      vm.openChat(context, model);
                    },
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: image(),
                    title: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          vm.name,
                          style: const TextStyle(fontSize: 16),
                        )),
                    subtitle:
                        Text(vm.isBlocked ? '' : model.lastMessage.content),
                    trailing: Text(dateToString(model.lastMessage.date))),
              );
      }),
    );
  }

  Widget image() {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
          color: Colors.yellowAccent,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: vm.image == ''
            ? Image.asset(
                Images.noImage,
                fit: BoxFit.cover,
              )
            : Image.network(
                vm.image,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
