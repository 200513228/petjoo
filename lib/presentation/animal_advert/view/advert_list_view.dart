import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/infrastructure/repositories/advert_repository_impl.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/ui/tiles/advert_tile.dart';
import 'package:petjoo/product/ui/widgets/nothing_to_see_here_widget.dart';
import 'package:petjoo/product/ui/widgets/search_bar.dart';
import '../view_model/advert_list_view_model.dart';

class AdvertListView extends ConsumerStatefulWidget {
  const AdvertListView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<AdvertListView> createState() => _AdvertsViewState();
}

class _AdvertsViewState extends ConsumerStateX<AdvertListView> with AutomaticKeepAliveClientMixin {
  late final advertListViewModel = ChangeNotifierProvider.autoDispose((ref) => AdvertListViewModel(context, AdvertRepositoryImpl()));
  late final viewModel = ref.read(advertListViewModel);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        SearchBar(
          hint: localization.searchAdvert,
          margin: const EdgeInsets.symmetric(vertical: Dimens.paddingSmallX, horizontal: Dimens.padding),
          onTap: viewModel.search,
        ),
        Expanded(
          child: RefreshIndicator(onRefresh: viewModel.refreshAdverts, child: gridview()),
        ),
      ],
    );
  }

  Widget gridview() => Consumer(builder: (context, ref, _) {
        final adverts = ref.watch(advertListViewModel.select((provider) => provider.adverts));
        return adverts.isEmpty
            ? const NothingToSeeHereWidget()
            : GridView.builder(
                controller: viewModel.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: adverts.length,
                padding: const EdgeInsets.all(Dimens.padding),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: .65,
                  crossAxisSpacing: Dimens.paddingSmall,
                  mainAxisSpacing: Dimens.paddingSmall,
                ),
                itemBuilder: (context, index) {
                  final data = adverts[index];
                  return AdvertTile(
                    data,
                    onTap: () => viewModel.advertDetail(data),
                  );
                });
      });

  @override
  bool get wantKeepAlive => true;
}
