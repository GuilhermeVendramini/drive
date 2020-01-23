import 'package:drive/src/modules/pick/widgets/pick_button_sheet.dart';
import 'package:drive/src/modules/pick/widgets/pick_button_start_route.dart';
import 'package:flutter/material.dart';

class PickButtonsBox extends StatefulWidget {
  @override
  _PickButtonsBoxState createState() => _PickButtonsBoxState();
}

class _PickButtonsBoxState extends State<PickButtonsBox> {
  bool _showButton = true;

  @override
  Widget build(BuildContext context) {
    return _showButton
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              PickButtonStartRoute(),
              SizedBox(
                height: 10.0,
              ),
              PickButtonSheet(
                action: _showFloatingActionButton,
              ),
            ],
          )
        : Container();
  }

  void _showFloatingActionButton(bool value) {
    setState(() {
      _showButton = value;
    });
  }
}
