import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/widgets/stream_builder_x.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_detail_view.dart';
import 'package:petjoo/presentation/animal_advert/view_model/advert_user_list_view_model.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/infrastructure/repositories/advert_repository_impl.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/ui/tiles/advert_tile.dart';
import 'package:petjoo/product/ui/widgets/nothing_to_see_here_widget.dart';
import '../../../product/constants/overlay_styles.dart';

class AdvertUserListView extends ConsumerStatefulWidget {
  const AdvertUserListView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<AdvertUserListView> createState() => _AdvertUserListViewState();
}

class _AdvertUserListViewState extends ConsumerStateX<AdvertUserListView> with AutomaticKeepAliveClientMixin {
  late final advertUserListViewModel = ChangeNotifierProvider.autoDispose((ref) => AdvertUserListViewModel(context, AdvertRepositoryImpl()));
  late final viewModel = ref.read(advertUserListViewModel);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toNavigationBar(theme.colorScheme.background, Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.myAdverts),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.pushNamed(Routes.advertInput),
          child: const Icon(Icons.add_rounded),
        ),
        body: StreamBuilderX<AdvertModelList>(
          stream: viewModel.getAdverts(),
          builder: (context, data) => gridview(data),
        ),
      ),
    );
  }

  Widget gridview(AdvertModelList adverts) => adverts.isEmpty
      ? const NothingToSeeHereWidget()
      : GridView.builder(
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
            return AdvertTile(data, onTap: () => context.push(AdvertDetailView(data)));
          });

  @override
  bool get wantKeepAlive => true;
}
