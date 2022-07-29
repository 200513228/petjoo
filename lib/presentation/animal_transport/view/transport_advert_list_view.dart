import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/presentation/animal_transport/view_model/transport_advert_list_view_model.dart';
import 'package:petjoo/infrastructure/repositories/transport_repository_impl.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/ui/tiles/transport_tile.dart';
import 'package:petjoo/product/ui/widgets/nothing_to_see_here_widget.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

class TransportAdvertListView extends ConsumerStatefulWidget {
  const TransportAdvertListView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<TransportAdvertListView> createState() => _TransportAdvertListViewState();
}

class _TransportAdvertListViewState extends ConsumerStateX<TransportAdvertListView> with AutomaticKeepAliveClientMixin {
  late final transportAdvertListViewModel = ChangeNotifierProvider.autoDispose((ref) => TransportAdvertListViewModel(context, TransportRepositoryImpl(), ref.read(chatProvider)));
  late final viewModel = ref.read(transportAdvertListViewModel);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // SearchBar(
        //   hint: localization.searchAdvert,
        //   margin: const EdgeInsets.symmetric(vertical: Dimens.paddingSmallX, horizontal: Dimens.padding),
        //   onTap: viewModel.search,
        // ),
        Expanded(
          child: RefreshIndicator(onRefresh: viewModel.refreshTransports, child: listview()),
        ),
      ],
    );
  }

  Widget listview() => Consumer(builder: (context, ref, _) {
        final transportList = ref.watch(transportAdvertListViewModel.select((provider) => provider.advertList));
        return transportList.isEmpty
            ? const NothingToSeeHereWidget()
            : ListView.separated(
                controller: viewModel.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(Dimens.padding),
                itemCount: transportList.length,
                separatorBuilder: (context, index) => const Separator(),
                itemBuilder: (context, index) {
                  final data = transportList[index];
                  return TransportTile(
                    data,
                    onTap: () => viewModel.transportDetail(data),
                    onCallTap: () => viewModel.call(data),
                    onMessageTap: () => viewModel.message(data),
                  );
                });
      });

  @override
  bool get wantKeepAlive => true;
}
