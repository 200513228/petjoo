import 'package:mobx/mobx.dart';
import 'package:petjoo/modules/base/string_converters.dart';
import 'package:petjoo/modules/transport/model/transport_shift_model.dart';
import 'package:petjoo/modules/transport/view/transport_create_view.dart';
part 'transport_shift_tile_viewmodel.g.dart';

class TransportShiftTileViewModel = TransportShiftTileViewModelBase
    with _$TransportShiftTileViewModel;

abstract class TransportShiftTileViewModelBase with Store {
  @observable
  String start = '00:00';
  @observable
  String end = '00:00';
  @observable
  bool isActive = false;
  @observable
  int day = 0;

  @action
  void activity() {
    isActive = !isActive;
    TransportCreateView.vm.advert!.shifts[day]['isActive'] = isActive;
  }

  @action
  void starthourChange(String hour) {
    start = hour;
    TransportCreateView.vm.advert!.shifts[day]['start'] = start;
  }

  @action
  void endHourChange(String hour) {
    end = hour;
    TransportCreateView.vm.advert!.shifts[day]['end'] = end;
  }

  @action
  void setShift(TransportShiftModel model) {
    start = hourToString(model.start);
    end = hourToString(model.end);
    isActive = model.isActive;
    day = model.day;
  }
}
