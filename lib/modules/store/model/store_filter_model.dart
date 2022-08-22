class StoreFilterModel {
  int advertType = 0;
  int advertStatus = 0;
  int advertDelivery = 0;

  StoreFilterModel.filter({
    required this.advertType,
    required this.advertStatus,
    required this.advertDelivery,
  });
}
