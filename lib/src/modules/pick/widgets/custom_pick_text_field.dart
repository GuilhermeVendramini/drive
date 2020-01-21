import 'package:drive/src/modules/pick/pick_controller.dart';
import 'package:drive/src/repositories/google_maps/google_maps_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

enum PickType {ORIGIN, DESTINATION}

class CustomPickTextField extends StatelessWidget {

  final String label;
  final TextEditingController textController;
  final PickType pickType;

  CustomPickTextField({this.textController, @required this.label, @required this.pickType});

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

      if(prediction != null) {
        await _controller.setDetailsByPlaceId(prediction.placeId);
        textController.text =  _controller.getPlaceFormattedAddress;

        if (pickType == PickType.ORIGIN) {
          _controller.setOriginAddress(textController.text);
        } else {
          _controller.setDestinationAddress(textController.text);
        }
      }
    }

    return TextField(
      controller: textController,
      onTap: _onTap,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
