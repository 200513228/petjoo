import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/infrastructure/repositories/advert_repository_impl.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/ui/tiles/advert_tile.dart';
import 'package:petjoo/product/ui/widgets/nothing_to_see_here_widget.dart';
import 'package:petjoo/product/ui/widgets/search_bar.dart';
import '../view_model/advert_search_view_model.dart';

class AdvertSearchView extends ConsumerStatefulWidget {
  const AdvertSearchView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<AdvertSearchView> createState() => _AdvertSearchViewState();
}

class _AdvertSearchViewState extends ConsumerStateX<AdvertSearchView> {
  late final advertSearchViewProvider = ChangeNotifierProvider.autoDispose((ref) => AdvertSearchViewModel(context, AdvertRepositoryImpl()));
  late AdvertSearchViewModel viewProvider = ref.read(advertSearchViewProvider);

  @override
  void initState() {
    viewProvider.getAdverts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toAll(theme.scaffoldBackgroundColor, Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.searchAdvert),
        ),
        floatingActionButton: FloatingActionButton(onPressed: viewProvider.showFilter, child: const Icon(Icons.filter_alt_rounded)),
        body: Column(
          children: [
            SearchBar(
              hint: localization.searchAdvert,
              margin: const EdgeInsets.symmetric(vertical: Dimens.paddingSmallX, horizontal: Dimens.padding),
              onQueryChanged: viewProvider.onQueryChanged,
            ),
            Expanded(
              child: gridview(),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridview() => Consumer(
        builder: (context, ref, _) {
          final adverts = ref.watch(advertSearchViewProvider.select((value) => value.adverts));
          return adverts.isEmpty
              ? const NothingToSeeHereWidget()
              : GridView.builder(
                  controller: viewProvider.scrollController,
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
                      onTap: () => viewProvider.advertDetail(data),
                    );
                  });
        },
      );
}
