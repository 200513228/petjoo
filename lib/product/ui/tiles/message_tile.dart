import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/core/extensions/datetime_extension.dart';
import 'package:petjoo/product/models/message_model.dart';

class MessageTile extends StatelessWidget {
  final String userId;
  final MessageModel data;

  const MessageTile(this.userId, this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;
    final isUser = userId == data.senderId;
    const cornerRadius = Radius.circular(Dimens.radiusSmall);
    return Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: isUser ? Colors.white : theme.colorScheme.surface,
            borderRadius: BorderRadius.only(
                topLeft: cornerRadius,
                topRight: cornerRadius,
                bottomLeft: isUser ? cornerRadius : Radius.zero,
                bottomRight: isUser ? Radius.zero : cornerRadius),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
            Flexible(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                    child: Text(
                      data.content,
                      style: theme.textTheme.bodyText2?.copyWith(fontSize: 15, color: isUser ? Colors.black : theme.colorScheme.onSurface),
                    ))),
            Text(
              data.id == null ? localization.sending : (data.id!.isEmpty ? localization.failed : data.date.toTimeString()),
              style: theme.textTheme.caption?.copyWith(color: isUser ? Colors.black54 : null),
            )
          ]),
        ));
  }
}
