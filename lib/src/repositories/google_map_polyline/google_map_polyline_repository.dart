import 'package:flutter/foundation.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_map_key.dart';

class GoogleMapPolylineRepository {
  GoogleMapPolyline _googleMapPolyline =
      GoogleMapPolyline(apiKey: googleMapKey);

  Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};

  void setPolylinesWithLocation(
      {@required LatLng origin, @required LatLng destination}) async {
    List<LatLng> _coordinates =
        await _googleMapPolyline.getCoordinatesWithLocation(
            origin: origin, destination: destination, mode: RouteMode.driving);

    _polyLines.clear();
    _addPolyline(_coordinates);
  }

  void setPolylinesWithAddress({@required String origin, @required String destination}) async {
    List<LatLng> _coordinates =
    await _googleMapPolyline.getPolylineCoordinatesWithAddress(
        origin: origin,
        destination: destination,
        mode: RouteMode.driving);

    _polyLines.clear();
    _addPolyline(_coordinates);
  }

  Map<PolylineId, Polyline> get getPolylines {
    return _polyLines;
  }

  void _addPolyline(List<LatLng> _coordinates) {
    PolylineId id = PolylineId('polyline');
    Polyline polyline = Polyline(
        polylineId: PolylineId('polyline'),
        points: _coordinates,
    );

    _polyLines[id] = polyline;
  }
}
