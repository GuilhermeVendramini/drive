import 'package:drive/src/repositories/google_maps/google_maps_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPolylineRepository {
  GoogleMapPolyline _googleMapPolyline =
      GoogleMapPolyline(apiKey: googleMapKey);

  Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};

  Future<Map<PolylineId, Polyline>> setPolylinesWithLocation({
    @required LatLng origin,
    @required LatLng destination,
    @required String polylineId,
    @required Color color,
  }) async {
    try {
      List<LatLng> coordinates =
          await _googleMapPolyline.getCoordinatesWithLocation(
        origin: origin,
        destination: destination,
        mode: RouteMode.driving,
      );

      _polyLines.remove(_polyLines[polylineId]);
      return _addPolyline(
        coordinates: coordinates,
        polylineId: polylineId,
        color: color,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<Map<PolylineId, Polyline>> setPolylinesWithAddress({
    @required String origin,
    @required String destination,
    @required String polylineId,
    @required Color color,
  }) async {
    try {
      List<LatLng> coordinates =
          await _googleMapPolyline.getPolylineCoordinatesWithAddress(
              origin: origin,
              destination: destination,
              mode: RouteMode.driving);

      _polyLines.remove(_polyLines[polylineId]);
      return _addPolyline(
          coordinates: coordinates, polylineId: polylineId, color: color);
    } catch (e) {
      throw e;
    }
  }

  Map<PolylineId, Polyline> get getPolylines {
    return _polyLines;
  }

  Map<PolylineId, Polyline> _addPolyline({
    @required List<LatLng> coordinates,
    @required String polylineId,
    @required Color color,
  }) {
    PolylineId id = PolylineId(polylineId);
    Polyline polyline = Polyline(
      polylineId: id,
      points: coordinates,
      color: color,
    );

    _polyLines[id] = polyline;
    return _polyLines;
  }
}
