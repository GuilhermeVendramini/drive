//import 'package:background_location/background_location.dart';
import 'package:drive/src/repositories/google_map_polyline/google_map_polyline_repository.dart';
import 'package:drive/src/repositories/google_maps/google_maps_key.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';

part 'pick_controller.g.dart';

enum PolylineStatus { IDLE, LOADING, ERROR, DONE }

class PickController = _PickController with _$PickController;

abstract class _PickController with Store {
  _PickController() {
    //BackgroundLocation.startLocationService();
    //startLocationUpdates();
    setCurrentPosition();
  }

  GoogleMapPolylineRepository _googleMapPolylineRepository =
      GoogleMapPolylineRepository();

  GoogleMapsPlaces _googleMapsPlaces = GoogleMapsPlaces(apiKey: googleMapKey);

  //double _currentLatitude = 0.0;

  //double _currentLongitude = 0.0;

  @observable
  LatLng initialLocation;

  @observable
  String originAddress = '';

  @observable
  String destinationAddress = '';

  @observable
  Iterable<Polyline> polylines;

  @observable
  PolylineStatus polylineStatus = PolylineStatus.IDLE;

  @observable
  Position currentPosition;

  @observable
  PlacesDetailsResponse placesDetails;

  @action
  setDetailsByPlaceId(String placeId) async {
    placesDetails = await _googleMapsPlaces.getDetailsByPlaceId(placeId);
  }

  String get getPlaceFormattedAddress {
    if(placesDetails.result != null && placesDetails.result.formattedAddress.isNotEmpty) {
      return placesDetails.result.formattedAddress;
    }
    return '';
  }

  @action
  setCurrentPosition() async {
    currentPosition = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (initialLocation == null) {
      initialLocation =
          LatLng(currentPosition.latitude, currentPosition.longitude);
      setAddressByLocation();
    }
  }

  @action
  setAddressByLocation() async {
    List<Placemark> placeMarkList = await Geolocator().placemarkFromCoordinates(
        initialLocation.latitude, initialLocation.longitude);

    if (placeMarkList.length > 0) {
      Placemark placeMark = placeMarkList.first;
      originAddress =
          '${placeMark.thoroughfare}, ${placeMark.name} - ${placeMark.subLocality}, ${placeMark.subAdministrativeArea} - ${placeMark.administrativeArea}, ${placeMark.postalCode}';
    }
  }

  @action
  setOriginAddress(String origin) {
    originAddress = origin;
  }

  @action
  setDestinationAddress(String destination) {
    destinationAddress = destination;
  }

/*  @action
  startLocationUpdates() {
    BackgroundLocation.getLocationUpdates((location) {
      _currentLatitude = location.latitude;
      _currentLongitude = location.longitude;

      if (initialLocation == null) {
        initialLocation = LatLng(_currentLatitude, _currentLongitude);
      }

      if (originAddress.isEmpty) {}
    });
  }*/

/*  @action
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
  }*/

  @action
  setPolylinesWithAddress({@required String origin, @required String destination}) async {
    try {
      polylineStatus = PolylineStatus.LOADING;
      await _googleMapPolylineRepository.setPolylinesWithAddress(
        origin: origin,
        destination: destination,
      );

      polylines = _googleMapPolylineRepository.getPolylines.values;
      polylineStatus = PolylineStatus.DONE;
    } catch (_) {
      polylineStatus = PolylineStatus.ERROR;
    }
  }

  void dispose() {
    //BackgroundLocation.stopLocationService();
  }
}
