import 'dart:async';

import 'package:drive/src/repositories/google_map_polyline/google_map_polyline_repository.dart';
import 'package:drive/src/repositories/google_maps/google_maps_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';

part 'pick_controller.g.dart';

enum PolylineStatus { IDLE, LOADING, ERROR, DONE }

class PickController = _PickController with _$PickController;

abstract class _PickController with Store {
  _PickController() {
    setCurrentPosition();

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/images/pin.png',
    ).then((onValue) {
      _bitmapIcon = onValue;
    });
  }

  GoogleMapPolylineRepository _googleMapPolylineRepository =
      GoogleMapPolylineRepository();

  GoogleMapsPlaces _googleMapsPlaces = GoogleMapsPlaces(apiKey: googleMapKey);

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
  Position destinationPosition;

  @observable
  PlacesDetailsResponse placesDetails;

  Geolocator geolocator = Geolocator();

  StreamSubscription<Position> positionStream;

  @observable
  List<Marker> _markers = [];

  BitmapDescriptor _bitmapIcon;

  @computed
  bool get hasOriginAndDestination =>
      originAddress.isNotEmpty && destinationAddress.isNotEmpty;

  @action
  startCurrentLocationUpdates() async {
    await setDestinationPosition();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    if (destinationPosition != null) {
      positionStream = geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) {
        if (position != null) {
          currentPosition = position;
          print(position);
          setPolylinesCurrentToDestination(
            color: Color(0xFF000000),
            currentLocation: LatLng(position.latitude, position.longitude),
            destination: LatLng(
                destinationPosition.latitude, destinationPosition.longitude),
          );

          setMarker(
            position: LatLng(
              position.latitude,
              position.longitude,
            ),
            id: 'currentLocation',
            icon: _bitmapIcon,
          );
        }
      });
    }
  }

  @action
  setDetailsByPlaceId(String placeId) async {
    placesDetails = await _googleMapsPlaces.getDetailsByPlaceId(placeId);
  }

  String get getPlaceFormattedAddress {
    if (placesDetails != null &&
        placesDetails.result != null &&
        placesDetails.result.formattedAddress.isNotEmpty) {
      return placesDetails.result.formattedAddress;
    }
    return '';
  }

  @action
  setCurrentPosition() async {
    currentPosition = await geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (initialLocation == null) {
      initialLocation =
          LatLng(currentPosition.latitude, currentPosition.longitude);
      setAddressByCurrentLocation();
    }
  }

  @action
  setAddressByCurrentLocation() async {
    List<Placemark> placeMarkList = await geolocator.placemarkFromCoordinates(
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

  @action
  setDestinationPosition() async {
    if (destinationAddress.isNotEmpty) {
      List<Placemark> placeMarkList =
          await geolocator.placemarkFromAddress(destinationAddress);

      if (placeMarkList.length > 0) {
        Placemark placeMark = placeMarkList.first;
        destinationPosition = placeMark.position;

        setMarker(
          position: LatLng(
            placeMark.position.latitude,
            placeMark.position.longitude,
          ),
          id: 'destinationPosition',
          icon: BitmapDescriptor.defaultMarkerWithHue(270.0),
        );
      }
    }
  }

  @action
  setPolylinesCurrentToDestination(
      {@required LatLng currentLocation,
      @required LatLng destination,
      @required Color color}) async {
    if (initialLocation != null) {
      try {
        polylineStatus = PolylineStatus.LOADING;
        await _googleMapPolylineRepository.setPolylinesWithLocation(
          origin: currentLocation,
          destination: destination,
          polylineId: 'currentToDestination',
          color: color,
        );

        polylines = _googleMapPolylineRepository.getPolylines.values;
        polylineStatus = PolylineStatus.DONE;
      } catch (_) {
        polylineStatus = PolylineStatus.ERROR;
      }
    }
  }

  @action
  setPolylinesOriginToDestination({
    @required String origin,
    @required String destination,
    @required Color color,
  }) async {
    try {
      polylineStatus = PolylineStatus.LOADING;
      await _googleMapPolylineRepository.setPolylinesWithAddress(
        origin: origin,
        destination: destination,
        polylineId: 'originToDestination',
        color: color,
      );

      polylines = _googleMapPolylineRepository.getPolylines.values;
      polylineStatus = PolylineStatus.DONE;
    } catch (_) {
      polylineStatus = PolylineStatus.ERROR;
    }
  }

  @action
  void setMarker({
    @required LatLng position,
    @required String id,
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker,
  }) {
    _markers.add(Marker(
      markerId: MarkerId(id),
      position: position,
      icon: icon,
    ));
  }

  Set<Marker> get getMarkers {
    return _markers.toSet();
  }

  void dispose() {
    positionStream.cancel();
  }
}
