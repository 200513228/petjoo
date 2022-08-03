import 'package:flutter/material.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/teska/pet/pet_viewmodel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PetView extends StatelessWidget {
  final PetViewModel vm = PetViewModel();
  PetView({super.key});

  @override
  Widget build(BuildContext context) {
    vm.getAdverts();
    return buildList();
  }

  Widget buildList() {
    return Observer(builder: (_) {
      return grid();
    });
  }

  Widget grid() {
    return GridView.builder(
        // controller: viewModel.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: vm.adverts.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: .65,
          crossAxisSpacing: Dimens.paddingSmall,
          mainAxisSpacing: Dimens.paddingSmall,
        ),
        itemBuilder: (context, index) {
          final data = vm.adverts[index];
          return Text(data.id);
        });
  }
}
