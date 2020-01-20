// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PickController on _PickController, Store {
  final _$_currentLatitudeAtom = Atom(name: '_PickController._currentLatitude');

  @override
  double get _currentLatitude {
    _$_currentLatitudeAtom.context.enforceReadPolicy(_$_currentLatitudeAtom);
    _$_currentLatitudeAtom.reportObserved();
    return super._currentLatitude;
  }

  @override
  set _currentLatitude(double value) {
    _$_currentLatitudeAtom.context.conditionallyRunInAction(() {
      super._currentLatitude = value;
      _$_currentLatitudeAtom.reportChanged();
    }, _$_currentLatitudeAtom, name: '${_$_currentLatitudeAtom.name}_set');
  }

  final _$_currentLongitudeAtom =
      Atom(name: '_PickController._currentLongitude');

  @override
  double get _currentLongitude {
    _$_currentLongitudeAtom.context.enforceReadPolicy(_$_currentLongitudeAtom);
    _$_currentLongitudeAtom.reportObserved();
    return super._currentLongitude;
  }

  @override
  set _currentLongitude(double value) {
    _$_currentLongitudeAtom.context.conditionallyRunInAction(() {
      super._currentLongitude = value;
      _$_currentLongitudeAtom.reportChanged();
    }, _$_currentLongitudeAtom, name: '${_$_currentLongitudeAtom.name}_set');
  }

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

  final _$setPolylinesWithLocationAsyncAction =
      AsyncAction('setPolylinesWithLocation');

  @override
  Future setPolylinesWithLocation({@required LatLng destination}) {
    return _$setPolylinesWithLocationAsyncAction
        .run(() => super.setPolylinesWithLocation(destination: destination));
  }

  final _$_PickControllerActionController =
      ActionController(name: '_PickController');

  @override
  dynamic getLocationUpdates() {
    final _$actionInfo = _$_PickControllerActionController.startAction();
    try {
      return super.getLocationUpdates();
    } finally {
      _$_PickControllerActionController.endAction(_$actionInfo);
    }
  }
}
