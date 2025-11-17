import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalizationController extends GetxController{
  final FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  final Rx<Locale> currectLocale = Rx(Locale("en"));
  static const String _localeKey = "selected_locale";

  @override
  void onInit() {
    super.onInit();
    _loadLocale();
  }
  void _loadLocale() async{
    final langCode = await _flutterSecureStorage.read(key: _localeKey);
    Get.updateLocale(Locale(langCode ?? "en"));
    currectLocale.value = Locale(langCode ?? "en");
  }

  void switchLanguage(Locale locale){
    currectLocale.value = locale;
    currectLocale.refresh();
    Get.updateLocale(locale);
    _flutterSecureStorage.write(key: _localeKey, value: locale.languageCode);
    Get.back();
  }
}