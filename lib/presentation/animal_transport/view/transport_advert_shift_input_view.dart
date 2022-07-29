import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/infrastructure/repositories/transport_repository_impl.dart';
import 'package:petjoo/presentation/animal_transport/view_model/transport_advert_shift_input_view_model.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/ui/tiles/shift_input_tile.dart';
import '../../../core/widgets/button_x.dart';
import '../../../product/constants/overlay_styles.dart';

class TransportAdvertShiftInputView extends ConsumerStatefulWidget {
  const TransportAdvertShiftInputView(this.data, {Key? key}) : super(key: key);

  final TransportAdvertModel data;

  @override
  ConsumerStateX<TransportAdvertShiftInputView> createState() => _TransportAdvertShiftInputViewState();
}

class _TransportAdvertShiftInputViewState extends ConsumerStateX<TransportAdvertShiftInputView> {
  late final transportAdvertShiftInputViewModel =
      ChangeNotifierProvider.autoDispose((ref) => TransportAdvertShiftInputViewModel(context, TransportRepositoryImpl()));
  late final viewModel = ref.read(transportAdvertShiftInputViewModel)..data = widget.data;
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(transportAdvertShiftInputViewModel.select((value) => value.isLoading));
    return isLoading
        ? Loading(
            background: theme.colorScheme.background,
          )
        : AnnotatedRegion<SystemUiOverlayStyle>(
            value: OverlayStyles.toNavigationBar(theme.colorScheme.background, Brightness.dark),
            child: Scaffold(
              appBar: AppBar(
                title: Text(localization.editShifts),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Consumer(builder: (context, ref, _) {
                      ref.watch(transportAdvertShiftInputViewModel);
                      return ListView.separated(
                          padding: const EdgeInsets.all(Dimens.padding),
                          itemBuilder: (context, index) {
                            final data = widget.data.shifts[index];
                            return ShiftInputTile(
                              data,
                              onStatusChanged: (value) => viewModel.changeDayStatus(data.day, value),
                              onStartChanged: (value) => viewModel.changeStartHour(data.day, value),
                              onFinishChanged: (value) => viewModel.changeFinishHour(data.day, value),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: Dimens.paddingSmall,
                              ),
                          itemCount: widget.data.shifts.length);
                    }),
                  ),
                  ButtonX(
                      width: double.maxFinite,
                      borderRadius: Dimens.radiusSmall.toBorderRadius(),
                      margin: const EdgeInsets.symmetric(horizontal: Dimens.padding, vertical: Dimens.paddingSmall),
                      padding: const EdgeInsets.all(Dimens.paddingSmall),
                      color: theme.colorScheme.secondary,
                      onTap: viewModel.save,
                      child: Text(
                        localization.save,
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
            ),
          );
  }
}
