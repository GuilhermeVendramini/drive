import 'package:drive/src/modules/i18n/i18n_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_app.dart';
import 'core_controller.dart';

class CoreModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CoreController>(create: (_) => CoreController()),
        Provider<I18nController>(create: (_) => I18nController()),
      ],
      child: CoreApp(),
    );
  }
}
