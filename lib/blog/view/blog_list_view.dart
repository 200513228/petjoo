import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/blog/viewmodel/blog_list_viewmodel.dart';

class BlogListView extends StatelessWidget {
  final BlogListViewModel vm = BlogListViewModel();
  BlogListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Container(
          child: Text('blog home'),
        );
      },
    );
  }
}
