import 'dart:developer';
import 'package:async/async.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petjoo/core/base/service/page_notifier.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/domain/repositories/advert_repository.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/services/location_service.dart';
import 'package:petjoo/core/extensions/geo_point_extension.dart';
import 'package:petjoo/core/extensions/lat_lng_extension.dart';

class AdvertMapInputViewModel extends PageNotifier {
  AdvertMapInputViewModel(super.context, this._repository, this.data);

  final AdvertRepository _repository;
  final AdvertModel data;
  late GoogleMapController _mapController;

  late LatLng currentLocation = data.geoPoint?.toLatLng() ?? const LatLng(34, 34);

  CancelableOperation? cancelableOperation;

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (data.geoPoint == null) {
      cancelableOperation = CancelableOperation.fromFuture(
        LocationService.determineLocation(
            onPermissionDenied: context.pop,
            onPermissionDeniedForever: context.pop,
            onServiceDisabled: context.pop,
            onLocationDetermined: (pos) => _mapController.animateCamera(CameraUpdate.newLatLng(pos))),
        onCancel: () => log("Location Request Cancelled", name: "Future"),
      );
    }
  }

  save([bool hasLocation = true]) async {
    changeLoading();
    try {
      if (hasLocation) data.geoPoint = currentLocation.toGeoPoint();
      if (data.id != null) {
        await _repository.updateAdvert(data).then((value) => context.pushNamed(Routes.advertImageInput, arguments: data));
      } else {
        await _repository.createAdvert(data).then((value) {
          context.pushNamed(Routes.advertImageInput, arguments: data);
          data.id = value.id;
        });
      }
      changeLoading();
    } catch (e) {
      context.showSnackBar(context.localization.somethingWentWrong);
      changeLoading();
    }
  }

  void skip() => save(false);

  void onCameraMove(CameraPosition position) => currentLocation = position.target;

  @override
  void dispose() {
    cancelableOperation?.cancel();
    super.dispose();
  }
}
