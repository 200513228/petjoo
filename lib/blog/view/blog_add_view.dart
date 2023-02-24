import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/base/num_extension.dart';
import 'package:petjoo/blog/model/blog_topic_model.dart';
import 'package:petjoo/blog/model/blog_topics_types.dart';
import 'package:petjoo/blog/view/blog_detail_view.dart';
import 'package:petjoo/blog/viewmodel/blog_add_viewmodel.dart';
import 'package:petjoo/constants/dimens.dart';
import 'package:petjoo/ui/dropdown_x.dart';

class BlogAddView extends StatelessWidget {
  final BlogAddViewModel vm = BlogAddViewModel();
  BlogAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.canPop(context),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Yeni Blog'),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
          ),
          body: form(context)),
    );
  }

  Widget form(BuildContext context) {
    TextEditingController topicCont = TextEditingController();
    TextEditingController msgCont = TextEditingController();
    return Form(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: topicCont,
                decoration: const InputDecoration(labelText: 'Başlık'),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: msgCont,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Mesaj'),
              ),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DropdownX<int>(
                      value: vm.type,
                      hint: 'Blog Konusu'.tr(),
                      borderRadius: Dimens.radiusSmall.toBorderRadius(),
                      items: blogTopicTypes.keys
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(blogTopicTypes[e]!),
                              ))
                          .toList(),
                      onChanged: (value) => vm.type = value,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () async {
                      vm.newBlog(topicCont.text, msgCont.text).then((value) {
                        if (value != 'ERROR') {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BlogDetailView(value as BlogTopicModel)));
                        }
                      });
                    },
                    child: const Text('Yeni Konu Başlat')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
