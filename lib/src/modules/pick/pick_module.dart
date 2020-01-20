import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pick_controller.dart';
import 'pick_page.dart';

class PickModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PickController>(create: (_) => PickController()),
      ],
      child: PickPage(),
    );
  }
}