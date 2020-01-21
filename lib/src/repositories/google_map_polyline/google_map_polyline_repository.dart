import 'package:drive/src/repositories/google_maps/google_maps_key.dart';
import 'package:flutter/foundation.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPolylineRepository {
  GoogleMapPolyline _googleMapPolyline =
      GoogleMapPolyline(apiKey: googleMapKey);

  Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};

  Future<Map<PolylineId, Polyline>> setPolylinesWithLocation(
      {@required LatLng origin, @required LatLng destination}) async {
    try {
      List<LatLng> _coordinates =
          await _googleMapPolyline.getCoordinatesWithLocation(
        origin: origin,
        destination: destination,
        mode: RouteMode.driving,
      );

      _polyLines.clear();
      return _addPolyline(_coordinates);
    } catch (e) {
      throw e;
    }
  }

  Future<Map<PolylineId, Polyline>> setPolylinesWithAddress(
      {@required String origin, @required String destination}) async {
    try {
      List<LatLng> _coordinates =
      await _googleMapPolyline.getPolylineCoordinatesWithAddress(
          origin: origin, destination: destination, mode: RouteMode.driving);

      _polyLines.clear();
      return _addPolyline(_coordinates);
    } catch (e) {
      throw e;
    }
  }

  Map<PolylineId, Polyline> get getPolylines {
    return _polyLines;
  }

  Map<PolylineId, Polyline> _addPolyline(List<LatLng> _coordinates) {
    PolylineId id = PolylineId('polyline');
    Polyline polyline = Polyline(
      polylineId: PolylineId('polyline'),
      points: _coordinates,
    );

    _polyLines[id] = polyline;
    return _polyLines;
  }
}
