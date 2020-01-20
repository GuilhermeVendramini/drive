import 'package:drive/src/modules/i18n/i18n_translate.dart';
import 'package:mobx/mobx.dart';

import 'locales/en-US.dart';
import 'locales/pt-BR.dart';

part 'i18n_controller.g.dart';

class I18nController = _I18nController with _$I18nController;

abstract class _I18nController with Store {
  @observable
  String _locale = 'en-US';
  Translate translate;

  @action
  setLocale(String locale) {
    _locale = locale;
  }

  @action
  void setTranslate() {
    switch (_locale) {
      case 'en-US':
        {
          translate = EnUS();
        }
        break;
      case 'pt-BR':
        {
          translate = PtBR();
        }
        break;
      default:
        {
          translate = EnUS();
        }
    }
  }
}
