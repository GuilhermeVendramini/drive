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
    verifyLocationService();
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
  LatLng targetLocation;

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

  @observable
  bool isLocationEnabled = false;

  Geolocator geolocator = Geolocator();

  StreamSubscription<Position> positionStream;

  @observable
  List<Marker> _markers = [];

  BitmapDescriptor _bitmapIcon;

  GoogleMapController mapController;

  @computed
  bool get hasOriginAndDestination =>
      originAddress.isNotEmpty && destinationAddress.isNotEmpty;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void cameraUpdate(LatLngBounds bounds) {
    CameraUpdate _cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 100);
    mapController.animateCamera(_cameraUpdate);
  }

  @action
  startCurrentLocationUpdates() async {
    await setDestinationPosition();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    if (destinationPosition != null) {
      LatLng _currentLocation =
          LatLng(currentPosition.latitude, currentPosition.longitude);

      setPolylinesCurrentToDestination(
        color: Color(0xFF000000),
        currentLocation: _currentLocation,
        destination:
            LatLng(destinationPosition.latitude, destinationPosition.longitude),
      );

      setMarker(
        position: _currentLocation,
        id: 'currentLocation',
        icon: _bitmapIcon,
      );

      positionStream = geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) {
        if (position != null) {
          currentPosition = position;
          _currentLocation = LatLng(position.latitude, position.longitude);
          setPolylinesCurrentToDestination(
            color: Color(0xFF000000),
            currentLocation: _currentLocation,
            destination: LatLng(
                destinationPosition.latitude, destinationPosition.longitude),
          );

          setMarker(
            position: _currentLocation,
            id: 'currentLocation',
            icon: _bitmapIcon,
          );

          targetLocation = _currentLocation;

          LatLngBounds _bounds = LatLngBounds(
              southwest: targetLocation, northeast: targetLocation);
          cameraUpdate(_bounds);
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
  verifyLocationService() async {
    isLocationEnabled = await geolocator.isLocationServiceEnabled();
  }

  @action
  setCurrentPosition() async {
    currentPosition = await geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (targetLocation == null) {
      targetLocation =
          LatLng(currentPosition.latitude, currentPosition.longitude);
      setAddressByCurrentLocation();
    }
  }

  @action
  setAddressByCurrentLocation() async {
    List<Placemark> placeMarkList = await geolocator.placemarkFromCoordinates(
        targetLocation.latitude, targetLocation.longitude);

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
        LatLngBounds _bounds =
            LatLngBounds(southwest: targetLocation, northeast: targetLocation);
        cameraUpdate(_bounds);
      }
    }
  }

  @action
  setPolylinesCurrentToDestination(
      {@required LatLng currentLocation,
      @required LatLng destination,
      @required Color color}) async {
    if (targetLocation != null) {
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
      _markers.clear();
      _googleMapPolylineRepository.removePolyline(
          polylineId: 'currentToDestination');
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
