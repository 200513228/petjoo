import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/enums/shift/days.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import '../../../domain/enums/shift/hours.dart';
import '../../../domain/repositories/transport_repository.dart';

class TransportAdvertShiftInputViewModel extends PageNotifier {
  TransportAdvertShiftInputViewModel(super.context, this._repository);

  final TransportRepository _repository;
  late final TransportAdvertModel data;

  changeStartHour(Days day, Hours? value) {
    data.shifts.firstWhere((x) => x.day == day).start = value!.time;
    notifyListeners();
  }

  changeFinishHour(Days day, Hours? value) {
    data.shifts.firstWhere((x) => x.day == day).end = value!.time;
    notifyListeners();
  }

  changeDayStatus(Days day, bool value) {
    data.shifts.firstWhere((x) => x.day == day).isActive = value;
    notifyListeners();
  }

  void save() {
    changeLoading();
    _repository.updateTransportAdvertShifts(data.id!, data.shifts).then((value) {
      context.pop();
    }, onError: (e) {
      changeLoading();
      context.showSnackBar(context.localization.somethingWentWrong);
    });
  }
}
