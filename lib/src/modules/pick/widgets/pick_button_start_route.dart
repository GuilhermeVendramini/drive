import 'package:drive/src/modules/pick/pick_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickButtonStartRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<PickController>(context);

    return _controller.hasOriginAndDestination
        ? FloatingActionButton(
            child: Icon(Icons.navigation),
            onPressed: _controller.startCurrentLocationUpdates,
          )
        : Container();
  }
}
