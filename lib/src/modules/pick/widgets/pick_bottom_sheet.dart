import 'package:drive/src/modules/pick/widgets/pick_origin_destination.dart';
import 'package:flutter/material.dart';

class PickBottomSheet extends StatefulWidget {
  @override
  _PickBottomSheetState createState() => _PickBottomSheetState();
}

class _PickBottomSheetState extends State<PickBottomSheet> {
  bool _showButton = true;

  @override
  Widget build(BuildContext context) {
    return _showButton
        ? FloatingActionButton(
            child: Icon(Icons.map),
            onPressed: () {
              var bottomSheetController = showBottomSheet(
                  context: context,
                  builder: (context) => PickOriginDestination());
              _showFloatingActionButton(false);
              bottomSheetController.closed.then((value) {
                _showFloatingActionButton(true);
              });
            },
          )
        : Container();
  }

  void _showFloatingActionButton(bool value) {
    setState(() {
      _showButton = value;
    });
  }
}
