import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petjoo/base/num_extension.dart';
import 'package:petjoo/blog/model/blog_topics_types.dart';
import 'package:petjoo/blog/viewmodel/blog_filter_viewmodel.dart';
import 'package:petjoo/constants/dimens.dart';
import 'package:petjoo/ui/dropdown_x.dart';

class BlogFilterView extends StatelessWidget {
  final BlogFilterViewModel vm = BlogFilterViewModel();
  BlogFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    vm.setCurrent();
    return Observer(
      builder: (context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownX<int>(
              value: vm.type,
              hint: 'category'.tr(),
              label: 'category'.tr(),
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              items: blogFilterTypes.keys
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(blogFilterTypes[e]!),
                      ))
                  .toList(),
              onChanged: (value) => vm.type = value,
            ),
            buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => vm.resetFilter(context),
            child: Text('reset'.tr(),
                style: const TextStyle(color: Colors.redAccent)),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            onPressed: () => vm.setFilter(context),
            child: Text('apply'.tr()),
          ),
        )
      ],
    );
  }
}
