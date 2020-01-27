import 'package:drive/src/modules/pick/pick_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickEnableLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<PickController>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Enable your location'),
        RaisedButton(
          child: Text('Try again'),
          onPressed: _controller.verifyLocationService,
        ),
      ],
    );
  }
}
