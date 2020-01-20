import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickPage extends StatefulWidget {
  @override
  _PickPageState createState() => _PickPageState();
}

class _PickPageState extends State<PickPage> {

  //Get Current location
  String latitude = "waiting...";
  String longitude = "waiting...";
  String altitude = "waiting...";
  String accuracy = "waiting...";
  String bearing = "waiting...";
  String speed = "waiting...";

  static double lat = -21.7263055;
  static double long = -51.0134177;

  @override
  void initState() {
    super.initState();

    BackgroundLocation.startLocationService();
    BackgroundLocation.getLocationUpdates((location) {
      setState(() {
        lat = location.latitude;
        long = location.longitude;

        this.latitude = location.latitude.toString();
        this.longitude = location.longitude.toString();
        this.accuracy = location.accuracy.toString();
        this.altitude = location.altitude.toString();
        this.bearing = location.bearing.toString();
        this.speed = location.speed.toString();
      });

      print("""\n
      Latitude:  $latitude
      Longitude: $longitude
      Altitude: $altitude
      Accuracy: $accuracy
      Bearing:  $bearing
      Speed: $speed
      """);
    });
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }

  getCurrentLocation() async {
    BackgroundLocation().getCurrentLocation().then((location) {
      print("This is current Location" + location.longitude.toString());
    });
  }

  GoogleMapPolyline _googleMapPolyline =
  GoogleMapPolyline(apiKey: '<API-KEY>');

  LatLng _mapInitLocation = LatLng(-21.7263055, -51.0134177);

  Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};

  int _polyLineCount = 1;

  LatLng _originLocation = LatLng(lat, long);
  LatLng _destinationLocation = LatLng(-21.718700, -51.026070);

  //Get polyline with Location (latitude and longitude)
  _getPolyLinesWithLocation() async {
    List<LatLng> _coordinates =
    await _googleMapPolyline.getCoordinatesWithLocation(
        origin: _originLocation,
        destination: _destinationLocation,
        mode: RouteMode.driving);

    setState(() {
      _polyLines.clear();
    });
    _addPolyline(_coordinates);
  }

  //Get polyline with Address
  _getPolyLinesWithAddress() async {
    List<LatLng> _coordinates =
    await _googleMapPolyline.getPolylineCoordinatesWithAddress(
        origin: '55 Kingston Ave, Brooklyn, NY 11213, USA',
        destination: '8007 Cypress Ave, Glendale, NY 11385, USA',
        mode: RouteMode.driving);

    setState(() {
      _polyLines.clear();
    });
    _addPolyline(_coordinates);
  }

  //Polyline patterns
  List<List<PatternItem>> _patterns = <List<PatternItem>>[
    <PatternItem>[],
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)],
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)],
    <PatternItem>[
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  _addPolyline(List<LatLng> _coordinates) {
    PolylineId id = PolylineId("poly$_polyLineCount");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: _patterns[0],
        color: Colors.blueAccent,
        points: _coordinates,
        width: 10,
        onTap: () {});

    setState(() {
      _polyLines[id] = polyline;
      _polyLineCount++;
    });
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("marker_origin"),
        position: _originLocation,
      ),
      Marker(
        markerId: MarkerId("marker_destination"),
        position: _destinationLocation,
      ),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Map Polyline'),
          ),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                polylines: Set<Polyline>.of(_polyLines.values),
                markers: _createMarker(),
                initialCameraPosition: CameraPosition(
                  target: _mapInitLocation,
                  zoom: 15,
                ),
              ),
              Container(
                color: Colors.grey.withOpacity(0.4),
                height: 200.0,
                child: ListView(
                  children: <Widget>[
                    locationData("Latitude: " + latitude),
                    locationData("Longitude: " + longitude),
                    locationData("Altitude: " + altitude),
                    locationData("Accuracy: " + accuracy),
                    locationData("Bearing: " + bearing),
                    locationData("Speed: " + speed),
                    RaisedButton(
                        onPressed: () {
                          BackgroundLocation.startLocationService();
                        },
                        child: Text("Start Location Service")),
                    RaisedButton(
                        onPressed: () {
                          BackgroundLocation.stopLocationService();
                        },
                        child: Text("Stop Location Service")),
                    RaisedButton(
                        onPressed: () {
                          getCurrentLocation();
                        },
                        child: Text("Get Current Location")),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.map),
            onPressed: _getPolyLinesWithLocation,
          ),
      ),
    );
  }

  @override
  void dispose() {
    BackgroundLocation.stopLocationService();
    super.dispose();
  }
}
