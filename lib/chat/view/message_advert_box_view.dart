import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/chat/model/chat_advert_model.dart';
import 'package:petjoo/chat/viewmodel/message_advert_box_viewmodel.dart';
import 'package:petjoo/constants/images.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/ui/loading.dart';

class MessageAdvertBoxView extends StatelessWidget {
  final ChatAdvertModel model;
  final MessageAdvertBoxViewModel vm = MessageAdvertBoxViewModel();
  MessageAdvertBoxView({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    vm.setModel(model);
    vm.getAdvertInfo();
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Align(alignment: Alignment.center, child: buildRow(context)),
      );
    });
  }

  Widget buildRow(BuildContext context) {
    return InkWell(
      onTap: () => vm.goAdvert(context),
      child: Container(
        decoration: BoxDecoration(
            color: colorPalette['secondary']!.withOpacity(.6),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          children: [
            vm.isLoading ? Container() : image(),
            const SizedBox(width: 10),
            Expanded(child: vm.isLoading ? const Loading() : Text(vm.title)),
            vm.isLoading
                ? Container()
                : const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }

  Widget image() {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: vm.image == ''
            ? Image.asset(
                Images.noImage,
                fit: BoxFit.fitWidth,
              )
            : Image.network(
                vm.image,
                fit: BoxFit.fitWidth,
              ),
      ),
    );
  }
}
