import 'package:drive/src/modules/pick/pick_controller.dart';
import 'package:drive/src/modules/pick/widgets/pick_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class PickOriginDestination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<PickController>(context);
    TextEditingController _originController = TextEditingController();
    TextEditingController _destinationController = TextEditingController();

    _originController.text = _controller.originAddress;
    _destinationController.text = _controller.destinationAddress;

    void _setPolylinesWithAddress() {
      _controller.setPolylinesOriginToDestination(
        origin: _originController.text,
        destination: _destinationController.text,
        color: Colors.blue,
      );
      Navigator.pop(context);
    }

    return Container(
      padding: EdgeInsets.all(10.0),
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          PickTextField(
            textController: _originController,
            label: 'Origin',
            pickType: PickType.ORIGIN,
          ),
          PickTextField(
            textController: _destinationController,
            label: 'Destination',
            pickType: PickType.DESTINATION,
          ),
          Observer(builder: (_) {
            Function _action = _controller.originAddress.isNotEmpty &&
                    _controller.destinationAddress.isNotEmpty
                ? _setPolylinesWithAddress
                : null;

            return RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
              onPressed: _action,
              child: Text(
                'FIND ROUTE',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
