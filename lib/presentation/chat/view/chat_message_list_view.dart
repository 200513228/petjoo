import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/presentation/chat/view_model/chat_message_list_view_model.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/models/chat_model.dart';
import 'package:petjoo/product/ui/tiles/message_tile.dart';
import 'package:petjoo/product/ui/widgets/nothing_to_see_here_widget.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

class ChatMessageListView extends ConsumerStatefulWidget {
  final ChatModel data;
  const ChatMessageListView(this.data, {Key? key}) : super(key: key);

  @override
  ConsumerStateX<ChatMessageListView> createState() => _ChatMessageListViewState();
}

class _ChatMessageListViewState extends ConsumerStateX<ChatMessageListView> {
  late final chatMessageListViewModel =
      ChangeNotifierProvider.autoDispose((ref) => ChatMessageListViewModel(context, widget.data, ref.read(chatProvider)));
  late final viewModel = ref.read(chatMessageListViewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(builder: (context, ref, _) {
          var user = ref.watch(chatMessageListViewModel.select((value) => value.chat.user));
          user ??= viewModel.chat.user = ref.read(userProvider).userInfos.firstOrNullWhere((x) => x.id == viewModel.targetUserId);
          if (user == null) viewModel.getUser();
          return Text(user?.fullname ?? "");
        }),
        actions: [
          Consumer(builder: (context, ref, _) {
            final block = ref.watch(userProvider.select((value) => value.blocks.firstOrNullWhere((block) => viewModel.targetUserId == block.id)));
            if (block?.users.any((x) => x == viewModel.userId) != true) {
              return PopupMenuButton(
                color: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(borderRadius: Dimens.radiusSmall.toBorderRadius()),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'block',
                    child: Text(
                      localization.block,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  )
                ],
                onSelected: (value) {
                  switch (value) {
                    case 'block':
                      viewModel.block();
                      break;
                    case 'unblock':
                      viewModel.unblock();
                      break;
                    default:
                  }
                },
              );
            }

            return const SizedBox();
          })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: listview(),
          ),
          bottom()
        ],
      ),
    );
  }

  Widget listview() => Consumer(builder: (context, ref, _) {
        ref.watch(chatMessageListViewModel);
        final messages = ref.watch(chatProvider).chats.firstOrNullWhere((x) => x.id == viewModel.chat.id)?.messages ?? [];
        return messages.isEmpty
            ? const NothingToSeeHereWidget()
            : ListView.separated(
                controller: viewModel.scrollController,
                padding: const EdgeInsets.all(Dimens.padding),
                itemCount: messages.length,
                separatorBuilder: (context, index) => const Separator(),
                reverse: true,
                itemBuilder: (context, index) => MessageTile(
                  viewModel.userId,
                  messages[index],
                ),
              );
      });

  Widget bottom() => Consumer(builder: (context, ref, _) {
        final block = ref.watch(userProvider.select((value) => value.blocks.firstOrNullWhere((block) => viewModel.targetUserId == block.id)));
        if (block == null) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingSmall, vertical: Dimens.paddingSmallX),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: viewModel.messageController,
                  maxLength: 255,
                  maxLines: 3,
                  minLines: 1,
                  decoration: InputDecoration(hintText: localization.message, counterText: ""),
                )),
                const SizedBox(width: Dimens.paddingSmall),
                Material(
                    shape: const CircleBorder(),
                    color: theme.colorScheme.secondary,
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: InkWell(
                        onTap: viewModel.sendMessage,
                        child: Icon(
                          Icons.send_rounded,
                          color: theme.scaffoldBackgroundColor,
                        ),
                      ),
                    ))
              ],
            ),
          );
        } else if (block.users.any((x) => x == viewModel.userId) == true) {
          return ButtonX(
            width: double.maxFinite,
            color: theme.colorScheme.secondary,
            borderRadius: Dimens.radiusSmall.toBorderRadius(),
            margin: const EdgeInsets.symmetric(vertical: Dimens.paddingSmallX, horizontal: Dimens.paddingSmall),
            padding: const EdgeInsets.all(Dimens.paddingSmall),
            onTap: viewModel.unblock,
            child: Text(localization.unblock),
          );
        } else {
          return Container(
            width: double.maxFinite,
            color: Colors.redAccent,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge, vertical: Dimens.padding),
            child: Text(
              localization.youAreBlockedTip,
              style: theme.textTheme.subtitle2?.copyWith(color: Colors.white),
            ),
          );
        }
      });
}
