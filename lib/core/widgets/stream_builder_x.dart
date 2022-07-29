import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/widgets/loading.dart';

class StreamBuilderX<T> extends StatelessWidget {
  final Stream<T>? stream;
  final Widget Function(BuildContext context, T data) builder;
  const StreamBuilderX({Key? key,required this.stream, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    return StreamBuilder<T>(
        stream: stream,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) return const Loading();
          if (snapshot.hasData) {
            return builder(context, snapshot.data as T);
          } else if (snapshot.hasError) {
            return Text(snapshot.error?.toString() ?? localization.somethingWentWrong);
          } else {
            return const SizedBox();
          }
        });
  }
}