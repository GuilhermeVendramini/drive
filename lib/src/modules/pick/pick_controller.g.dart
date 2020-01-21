// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PickController on _PickController, Store {
  final _$initialLocationAtom = Atom(name: '_PickController.initialLocation');

  @override
  LatLng get initialLocation {
    _$initialLocationAtom.context.enforceReadPolicy(_$initialLocationAtom);
    _$initialLocationAtom.reportObserved();
    return super.initialLocation;
  }

  @override
  set initialLocation(LatLng value) {
    _$initialLocationAtom.context.conditionallyRunInAction(() {
      super.initialLocation = value;
      _$initialLocationAtom.reportChanged();
    }, _$initialLocationAtom, name: '${_$initialLocationAtom.name}_set');
  }

  final _$originAddressAtom = Atom(name: '_PickController.originAddress');

  @override
  String get originAddress {
    _$originAddressAtom.context.enforceReadPolicy(_$originAddressAtom);
    _$originAddressAtom.reportObserved();
    return super.originAddress;
  }

  @override
  set originAddress(String value) {
    _$originAddressAtom.context.conditionallyRunInAction(() {
      super.originAddress = value;
      _$originAddressAtom.reportChanged();
    }, _$originAddressAtom, name: '${_$originAddressAtom.name}_set');
  }

  final _$destinationAddressAtom =
      Atom(name: '_PickController.destinationAddress');

  @override
  String get destinationAddress {
    _$destinationAddressAtom.context
        .enforceReadPolicy(_$destinationAddressAtom);
    _$destinationAddressAtom.reportObserved();
    return super.destinationAddress;
  }

  @override
  set destinationAddress(String value) {
    _$destinationAddressAtom.context.conditionallyRunInAction(() {
      super.destinationAddress = value;
      _$destinationAddressAtom.reportChanged();
    }, _$destinationAddressAtom, name: '${_$destinationAddressAtom.name}_set');
  }

  final _$polylinesAtom = Atom(name: '_PickController.polylines');

  @override
  Iterable<Polyline> get polylines {
    _$polylinesAtom.context.enforceReadPolicy(_$polylinesAtom);
    _$polylinesAtom.reportObserved();
    return super.polylines;
  }

  @override
  set polylines(Iterable<Polyline> value) {
    _$polylinesAtom.context.conditionallyRunInAction(() {
      super.polylines = value;
      _$polylinesAtom.reportChanged();
    }, _$polylinesAtom, name: '${_$polylinesAtom.name}_set');
  }

  final _$polylineStatusAtom = Atom(name: '_PickController.polylineStatus');

  @override
  PolylineStatus get polylineStatus {
    _$polylineStatusAtom.context.enforceReadPolicy(_$polylineStatusAtom);
    _$polylineStatusAtom.reportObserved();
    return super.polylineStatus;
  }

  @override
  set polylineStatus(PolylineStatus value) {
    _$polylineStatusAtom.context.conditionallyRunInAction(() {
      super.polylineStatus = value;
      _$polylineStatusAtom.reportChanged();
    }, _$polylineStatusAtom, name: '${_$polylineStatusAtom.name}_set');
  }

  final _$currentPositionAtom = Atom(name: '_PickController.currentPosition');

  @override
  Position get currentPosition {
    _$currentPositionAtom.context.enforceReadPolicy(_$currentPositionAtom);
    _$currentPositionAtom.reportObserved();
    return super.currentPosition;
  }

  @override
  set currentPosition(Position value) {
    _$currentPositionAtom.context.conditionallyRunInAction(() {
      super.currentPosition = value;
      _$currentPositionAtom.reportChanged();
    }, _$currentPositionAtom, name: '${_$currentPositionAtom.name}_set');
  }

  final _$placesDetailsAtom = Atom(name: '_PickController.placesDetails');

  @override
  PlacesDetailsResponse get placesDetails {
    _$placesDetailsAtom.context.enforceReadPolicy(_$placesDetailsAtom);
    _$placesDetailsAtom.reportObserved();
    return super.placesDetails;
  }

  @override
  set placesDetails(PlacesDetailsResponse value) {
    _$placesDetailsAtom.context.conditionallyRunInAction(() {
      super.placesDetails = value;
      _$placesDetailsAtom.reportChanged();
    }, _$placesDetailsAtom, name: '${_$placesDetailsAtom.name}_set');
  }

  final _$setDetailsByPlaceIdAsyncAction = AsyncAction('setDetailsByPlaceId');

  @override
  Future setDetailsByPlaceId(String placeId) {
    return _$setDetailsByPlaceIdAsyncAction
        .run(() => super.setDetailsByPlaceId(placeId));
  }

  final _$setCurrentPositionAsyncAction = AsyncAction('setCurrentPosition');

  @override
  Future setCurrentPosition() {
    return _$setCurrentPositionAsyncAction
        .run(() => super.setCurrentPosition());
  }

  final _$setAddressByLocationAsyncAction = AsyncAction('setAddressByLocation');

  @override
  Future setAddressByLocation() {
    return _$setAddressByLocationAsyncAction
        .run(() => super.setAddressByLocation());
  }

  final _$setPolylinesWithAddressAsyncAction =
      AsyncAction('setPolylinesWithAddress');

  @override
  Future setPolylinesWithAddress(
      {@required String origin, @required String destination}) {
    return _$setPolylinesWithAddressAsyncAction.run(() => super
        .setPolylinesWithAddress(origin: origin, destination: destination));
  }

  final _$_PickControllerActionController =
      ActionController(name: '_PickController');

  @override
  dynamic setOriginAddress(String origin) {
    final _$actionInfo = _$_PickControllerActionController.startAction();
    try {
      return super.setOriginAddress(origin);
    } finally {
      _$_PickControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDestinationAddress(String destination) {
    final _$actionInfo = _$_PickControllerActionController.startAction();
    try {
      return super.setDestinationAddress(destination);
    } finally {
      _$_PickControllerActionController.endAction(_$actionInfo);
    }
  }
}
