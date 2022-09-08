class TransportShiftModel {
  int day = 0;
  String start = '00:00';
  String end = '23:30';
  bool isActive = false;

  TransportShiftModel.fromMap(Map map) {
    day = map['day'] as int;
    isActive = map['isActive'] as bool;
    start = map['start'] as String;
    end = map['end'] as String;
  }

  TransportShiftModel.empty(int day) {
    day = day;
    isActive = false;
    start = '00:00';
    end = '23:30';
  }
}
