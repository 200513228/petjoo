import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/ui/widgets/nothing_to_see_here_widget.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';
import '../../../infrastructure/repositories/transport_reservation_repository_impl.dart';
import '../../../product/constants/overlay_styles.dart';
import '../../../product/ui/tiles/transport_reservation_tile.dart';
import '../view_model/transport_reservation_list_view_model.dart';

class TransportReservationListView extends ConsumerStatefulWidget {
  const TransportReservationListView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<TransportReservationListView> createState() =>
      _TransportReservationListViewState();
}

class _TransportReservationListViewState
    extends ConsumerStateX<TransportReservationListView> {
  late final transportReservationListViewModel =
      ChangeNotifierProvider.autoDispose((ref) =>
          TransportReservationListViewModel(
              context, TransportReservationRepositoryImpl()));
  late final viewModel = ref.read(transportReservationListViewModel);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: viewModel.refreshReservations, child: listview());
  }

  Widget listview() => AnnotatedRegion<SystemUiOverlayStyle>(
        value:
            OverlayStyles.toAll(theme.scaffoldBackgroundColor, Brightness.dark),
        child: Consumer(builder: (context, ref, _) {
          final reservationListLength = ref.watch(
              transportReservationListViewModel
                  .select((provider) => provider.reservationList.length));
          return Scaffold(
            body: reservationListLength == 0
                ? const NothingToSeeHereWidget()
                : ListView.separated(
                    controller: viewModel.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(Dimens.padding),
                    itemCount: reservationListLength,
                    separatorBuilder: (context, index) => const Separator(),
                    itemBuilder: (context, index) {
                      final data = viewModel.reservationList[index];
                      return TransportReservationTile(
                        data,
                        onTap: () => context.pushNamed(Routes.reservationDetail,
                            arguments: data),
                      );
                    }),
          );
        }),
      );
}
