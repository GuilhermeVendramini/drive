import 'package:drive/src/modules/pick/pick_controller.dart';
import 'package:drive/src/modules/pick/widgets/pick_buttons_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/*
class PickPage extends StatefulWidget {
  @override
  _PickPageState createState() => _PickPageState();
}

class _PickPageState extends State<PickPage> {

  LatLng _mapInitLocation = LatLng(-21.7263055, -51.0134177);


  LatLng _originLocation = LatLng(lat, long);
  LatLng _destinationLocation = LatLng(-21.718700, -51.026070);

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
                polylines: Set<Polyline>.of(_googleMapPolylineRepository.getPolylines.values),
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
            onPressed: () {
              _googleMapPolylineRepository.setPolylinesWithLocation(
                origin: _originLocation,
                destination: _destinationLocation,
              );
            },
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
*/

class PickPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<PickController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Drive'),
        centerTitle: true,
      ),
      body: Container(
        child: Observer(
          builder: (_) {
            if (_controller.initialLocation == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Stack(
                children: <Widget>[
                  GoogleMap(
                    markers: _controller.getMarkers,
                    polylines: _controller.polylines != null
                        ? Set<Polyline>.of(_controller.polylines)
                        : null,
                    initialCameraPosition: CameraPosition(
                      target: _controller.initialLocation,
                      zoom: 15,
                    ),
                  ),
                  _controller.polylineStatus == PolylineStatus.LOADING
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: PickButtonsBox(),
    );
  }
}
