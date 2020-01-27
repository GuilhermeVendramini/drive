import 'package:drive/src/modules/pick/pick_controller.dart';
import 'package:drive/src/modules/pick/widgets/pick_buttons_box.dart';
import 'package:drive/src/modules/pick/widgets/pick_enable_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PickPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<PickController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Drive'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Observer(
            builder: (_) {
              if(!_controller.isLocationEnabled) {
                return PickEnableLocation();
              }

              if (_controller.targetLocation == null) {
                return CircularProgressIndicator();
              } else {
                return Stack(
                  children: <Widget>[
                    GoogleMap(
                      markers: _controller.getMarkers,
                      polylines: _controller.polylines != null
                          ? Set<Polyline>.of(_controller.polylines)
                          : null,
                      initialCameraPosition: CameraPosition(
                        target: _controller.targetLocation,
                        zoom: 15,
                      ),
                      trafficEnabled: true,
                      onMapCreated: _controller. onMapCreated,
                      //myLocationEnabled: true,
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
      ),
      floatingActionButton: PickButtonsBox(),
    );
  }
}
