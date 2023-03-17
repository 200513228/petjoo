import 'package:flutter/material.dart';
import 'package:petjoo/blog/service/blog_service.dart';

class BlogAlert extends StatelessWidget {
  const BlogAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Lütfen Dikkat'),
      content: const Text(
          'Blog Modülümüzde tartışma ortamı olmadan, anonim olarak can dostlarınızla ilgili tecrübelerinizi paylaşın. '),
      actions: [
        TextButton(
            onPressed: () {
              BlogService.prefsSet();
              Navigator.pop(context);
            },
            child: const Text('Anladım')),
      ],
    );
  }
}
