import 'package:flutter/material.dart';
import 'loading.dart';

class FutureBuilderX<T> extends StatelessWidget {
  final Widget Function(T data) onDone;
  final Widget? loading;
  final Widget? empty;
  final Widget? error;
  final Future<T> future;
  const FutureBuilderX(this.future,
      {Key? key,
      this.loading,
      this.error,
      this.empty,
      required this.onDone})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, AsyncSnapshot<T> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loading ?? LayoutBuilder(builder: (context, constraints) => const Loading());
          } else if (snapshot.connectionState == ConnectionState.none && !snapshot.hasData) {
            return error ?? const SizedBox();
          } else if (!snapshot.hasData) {
            return error ?? const SizedBox();
          } else if (snapshot.data is List && (snapshot.data as List).isEmpty) {
            return empty ?? const SizedBox();
          } else {
            return onDone(snapshot.data as T);
          }
        });
  }
}
