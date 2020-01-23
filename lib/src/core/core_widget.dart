import 'package:drive/src/modules/i18n/i18n_controller.dart';
import 'package:drive/src/modules/pick/pick_module.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _i18nController = Provider.of<I18nController>(context);
    Locale _locale = Localizations.localeOf(context);

    if (_locale.languageCode.isNotEmpty) {
      _i18nController.setLocale(_locale.toLanguageTag());
      _i18nController.setTranslate();
    } else {
      _i18nController.setTranslate();
    }

    // TODO - Needs verify auth first
    return PickModule();
  }
}
