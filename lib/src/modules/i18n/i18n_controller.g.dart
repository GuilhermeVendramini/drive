// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i18n_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$I18nController on _I18nController, Store {
  final _$_localeAtom = Atom(name: '_I18nController._locale');

  @override
  String get _locale {
    _$_localeAtom.context.enforceReadPolicy(_$_localeAtom);
    _$_localeAtom.reportObserved();
    return super._locale;
  }

  @override
  set _locale(String value) {
    _$_localeAtom.context.conditionallyRunInAction(() {
      super._locale = value;
      _$_localeAtom.reportChanged();
    }, _$_localeAtom, name: '${_$_localeAtom.name}_set');
  }

  final _$_I18nControllerActionController =
      ActionController(name: '_I18nController');

  @override
  dynamic setLocale(String locale) {
    final _$actionInfo = _$_I18nControllerActionController.startAction();
    try {
      return super.setLocale(locale);
    } finally {
      _$_I18nControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTranslate() {
    final _$actionInfo = _$_I18nControllerActionController.startAction();
    try {
      return super.setTranslate();
    } finally {
      _$_I18nControllerActionController.endAction(_$actionInfo);
    }
  }
}
