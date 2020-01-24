import 'package:drive/src/modules/pick/widgets/pick_origin_destination.dart';
import 'package:flutter/material.dart';

class PickButtonSheet extends StatelessWidget {
  final Function action;

  PickButtonSheet({@required this.action});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.map),
      onPressed: () {
        var bottomSheetController = showBottomSheet(
          context: context,
          builder: (context) => PickOriginDestination(),
        );
        action(false);
        bottomSheetController.closed.then((value) {
          action(true);
        });
      },
    );
  }
}
