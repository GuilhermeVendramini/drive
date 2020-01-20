import 'package:background_location/background_location.dart';
import 'package:drive/src/repositories/google_map_polyline/google_map_polyline_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'pick_controller.g.dart';

enum PolylineStatus { IDLE, LOADING, ERROR, DONE }

class PickController = _PickController with _$PickController;

abstract class _PickController with Store {
  _PickController() {
    BackgroundLocation.startLocationService();
    getLocationUpdates();
  }

  GoogleMapPolylineRepository _googleMapPolylineRepository =
      GoogleMapPolylineRepository();

  @observable
  double _currentLatitude = 0.0;

  @observable
  double _currentLongitude = 0.0;

  @observable
  LatLng initialLocation;

  @observable
  Iterable<Polyline> polylines;

  @observable
  PolylineStatus polylineStatus = PolylineStatus.IDLE;

  @action
  getLocationUpdates() {
    BackgroundLocation.getLocationUpdates((location) {
      _currentLatitude = location.latitude;
      _currentLongitude = location.longitude;

      if (initialLocation == null) {
        initialLocation = LatLng(_currentLatitude, _currentLongitude);
        print(initialLocation);
      }

      setPolylinesWithLocation(destination: LatLng(-21.718700, -51.026070)); // Test update line
    });
  }

  @action
  setPolylinesWithLocation({@required LatLng destination}) async {
    if (initialLocation != null) {
      try {
        polylineStatus = PolylineStatus.LOADING;
        await _googleMapPolylineRepository.setPolylinesWithLocation(
          origin: initialLocation, //TODO- Get from field
          destination: destination,
        );

        polylines = _googleMapPolylineRepository.getPolylines.values;
        polylineStatus = PolylineStatus.DONE;
      } catch (_) {
        polylineStatus = PolylineStatus.ERROR;
      }
    }
  }

  void dispose() {
    BackgroundLocation.stopLocationService();
  }
}
