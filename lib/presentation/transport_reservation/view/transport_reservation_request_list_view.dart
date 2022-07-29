import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/domain/enums/reservation/reservation_status.dart';
import 'package:petjoo/infrastructure/repositories/transport_reservation_repository_impl.dart';
import 'package:petjoo/presentation/transport_reservation/view_model/transport_reservation_request_list_view_model.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/ui/tiles/transport_reservation_request_tile.dart';
import 'package:petjoo/product/ui/widgets/nothing_to_see_here_widget.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';
import 'package:table_calendar/table_calendar.dart';

class TransportReservationRequestListView extends ConsumerStatefulWidget {
  const TransportReservationRequestListView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<TransportReservationRequestListView> createState() => _TransportReservationRequestListViewState();
}

class _TransportReservationRequestListViewState extends ConsumerStateX<TransportReservationRequestListView> {
  late final transportReservationRequestListViewModel =
      ChangeNotifierProvider.autoDispose((ref) => TransportReservationRequestListViewModel(context, TransportReservationRepositoryImpl()));
  late final viewModel = ref.read(transportReservationRequestListViewModel);

  @override
  Widget build(BuildContext context) {
    return listview();
  }

  Widget listview() => AnnotatedRegion<SystemUiOverlayStyle>(
        value: OverlayStyles.toAll(theme.scaffoldBackgroundColor, Brightness.dark),
        child: Consumer(builder: (context, ref, _) {
          final reservationListLength = ref.watch(transportReservationRequestListViewModel.select((provider) => provider.reservationList.length));
          ref.watch(transportReservationRequestListViewModel.select((provider) => provider.reservationListt));
          return Scaffold(
            appBar: AppBar(title: Text(localization.myReservationRequests)),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.padding),
                  padding: const EdgeInsets.all(Dimens.paddingSmallX),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: Dimens.radiusSmall.toBorderRadius(),
                  ),
                  child: Consumer(builder: (context, ref, _) {
                    final calendarFormat = ref.watch(transportReservationRequestListViewModel.select((provider) => provider.calendarFormat));
                    return TableCalendar(
                      locale: localization.languageCode,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      calendarFormat: calendarFormat,
                      availableCalendarFormats: {
                        CalendarFormat.month: localization.month,
                        CalendarFormat.twoWeeks: '2 ${localization.week}',
                        CalendarFormat.week: localization.week
                      },
                      focusedDay: viewModel.focusedDay,
                      onFormatChanged: viewModel.onFormatChanged,
                      onDaySelected: viewModel.onDaySelected,
                      selectedDayPredicate: (day) => isSameDay(viewModel.mySelectedDay, day),
                      eventLoader: viewModel.eventLoader,
                      calendarStyle: CalendarStyle(
                        weekendTextStyle: const TextStyle(color: Colors.white),
                        markerDecoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: viewModel.refreshReservations,
                    child: reservationListLength == 0
                        ? const NothingToSeeHereWidget()
                        : ListView.separated(
                            controller: viewModel.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(Dimens.padding),
                            itemCount: reservationListLength,
                            separatorBuilder: (context, index) => const Separator(),
                            itemBuilder: (context, index) {
                              final data = viewModel.reservationList[index];
                              return Consumer(builder: (context, ref, _) {
                                ref.watch(transportReservationRequestListViewModel.select((value) => value.reservationList[index].status));
                                return TransportReservationRequestTile(
                                  data,
                                  onTap: () => context.pushNamed(Routes.reservationDetail, arguments: data),
                                  onApprovedTap: () => viewModel.updateReservationStatus(data, ReservationStatus.approved),
                                  onDeniedTap: () => viewModel.updateReservationStatus(data, ReservationStatus.denied),
                                );
                              });
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        }),
      );
}
