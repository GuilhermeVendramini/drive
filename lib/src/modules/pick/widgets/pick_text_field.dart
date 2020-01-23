import 'package:drive/src/modules/pick/pick_controller.dart';
import 'package:drive/src/repositories/google_maps/google_maps_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

enum PickType { ORIGIN, DESTINATION }

class PickTextField extends StatefulWidget {
  final String label;
  final TextEditingController textController;
  final PickType pickType;

  PickTextField(
      {this.textController, @required this.label, @required this.pickType});

  @override
  _PickTextFieldState createState() => _PickTextFieldState();
}

class _PickTextFieldState extends State<PickTextField> {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<PickController>(context);

    Future<void> _onTap() async {
      Prediction prediction = await PlacesAutocomplete.show(
        context: context,
        apiKey: googleMapKey,
        language: "pt-BR",
        mode: Mode.overlay,
        components: [Component(Component.country, "br")],
      );

      if (prediction != null) {
        await _controller.setDetailsByPlaceId(prediction.placeId);

        setState(() {
          widget.textController.text = _controller.getPlaceFormattedAddress;
        });

        if (widget.pickType == PickType.ORIGIN) {
          _controller.setOriginAddress(widget.textController.text);
        } else {
          _controller.setDestinationAddress(widget.textController.text);
        }
      }
    }

    return TextField(
      controller: widget.textController,
      onTap: _onTap,
      decoration: InputDecoration(
        labelText: widget.label,
      ),
    );
  }
}
