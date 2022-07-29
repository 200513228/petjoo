import 'package:badges/badges.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/future_builder_x.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/core/extensions/datetime_extension.dart';
import 'package:petjoo/product/models/chat_model.dart';
import 'package:petjoo/product/models/user_basic_model.dart';
import 'package:petjoo/product/network/requests.dart';
import 'package:petjoo/product/ui/widgets/image_x.dart';

class ChatTile extends StatelessWidget {
  final ChatModel data;
  final void Function()? onTap;

  const ChatTile(this.data, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Badge(
      showBadge: !data.isReaded,
      badgeColor: Colors.redAccent,
      position: BadgePosition.topEnd(end: -7, top: -7),
      child: SizedBox(
          height: 70,
          child: Material(
              color: theme.colorScheme.surface,
              clipBehavior: Clip.antiAlias,
              borderRadius: Dimens.radius.toBorderRadius(),
              child: Consumer(builder: (context, ref, _) {
                if (data.user != null) return _content(context);

                final userId = data.userIds.firstWhere((x) => x != FirebaseAuth.instance.currentUser?.uid);
                final user = ref.watch(userProvider.select((value) => value.userInfos.firstOrNullWhere((x) => x.id == userId)));
                if (user != null) {
                  data.user = user;
                  return _content(context);
                }
                return FutureBuilderX<UserBasicModel>(Requests.getUserInfo(userId), onDone: ((user) {
                  ref.read(userProvider).addUserInfo(user);
                  data.user = user;
                  return _content(context);
                }));
              }))),
    );
  }

  Widget _content(BuildContext context) {
    final theme = context.theme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          ImageX(
            data.user!.image,
            aspectRatio: 1,
            borderRadius: Dimens.radiusSmall.toBorderRadius(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text(data.user!.fullname, maxLines: 1, style: theme.textTheme.bodyText1, overflow: TextOverflow.clip, softWrap: false),
                const SizedBox(height: 5),
                Text(data.lastMessage.content,
                    maxLines: 1, style: theme.textTheme.caption?.copyWith(fontWeight: !data.isReaded ? FontWeight.bold : null)),
              ]),
            ),
          ),
          Text(
            data.lastMessage.date.toDifferenceString(context),
            style: theme.textTheme.caption,
          )
        ]),
      ),
    );
  }
}
