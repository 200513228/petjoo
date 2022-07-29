import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/models/chat_model.dart';
import 'package:petjoo/product/ui/tiles/chat_tile.dart';
import 'package:petjoo/product/ui/widgets/nothing_to_see_here_widget.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';
import '../view_model/chat_list_view_model.dart';

class ChatListView extends ConsumerStatefulWidget {
  const ChatListView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends ConsumerStateX<ChatListView> {
  late final chatListViewModel = ChangeNotifierProvider.autoDispose((ref) => ChatListViewModel(context));
  late final viewModel = ref.read(chatListViewModel);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toAll(theme.scaffoldBackgroundColor, Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.chats),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final chats = ref.watch(chatProvider).chats.toList();
            return listview(chats);
          },
        ),
      ),
    );
  }

  Widget listview(List<ChatModel> chats) => chats.isEmpty
      ? const NothingToSeeHereWidget()
      : ListView.separated(
          padding: const EdgeInsets.all(Dimens.padding),
          itemCount: chats.length,
          separatorBuilder: (context, index) => const Separator(),
          itemBuilder: (context, index) {
            final data = chats[index];
            return ChatTile(data, onTap: () => viewModel.messages(data));
          },
        );
}
