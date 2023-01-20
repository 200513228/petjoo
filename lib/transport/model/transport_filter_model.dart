class TransportFilterModel {
  int hasIntercity = 0;
  int hasCage = 0;
  int hasCollar = 0;
  int hasCatch = 0;
  int is24 = 0;

  TransportFilterModel.filter(
      {required this.hasIntercity,
      required this.hasCage,
      required this.hasCollar,
      required this.hasCatch,
      required this.is24});
}
