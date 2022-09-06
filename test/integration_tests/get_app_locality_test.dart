import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAppLocalityTest {

  static late GetAppLocalityService _getAppSettingsUseCase;

  static void testGetAppLocality() {

    group("Testing: GetStoredAppLocality", () {
      _testIfNotStoredWithImpl();
      _testIfStoredWithImplAndLangCode('en');
      _testIfStoredWithImplAndLangCode('ar');
    });
  }

  static void _testIfNotStoredWithImpl() {
    test("-- with ports impl -- not-stored", () async {
      SharedPreferences.setMockInitialValues({});

      var _sharedPrefInstance = await SharedPreferences.getInstance();

      AppSettingsRepository _appSettingsRepository =
          AppSettingsRepository(sharedPreferences: _sharedPrefInstance);

      _getAppSettingsUseCase = GetAppLocalityService(
          loadAppSettingsPort: _appSettingsRepository,
          hasAppSettingsPort: _appSettingsRepository);

      var value = _getAppSettingsUseCase.currentLocality;
      expect(value, const Locale('en', ''));
    });
  }

  static void _testIfStoredWithImplAndLangCode(String languageCode) {
    test("-- with ports impl -- stored - $languageCode", () async {
      var appSettingsMapper = AppSettingsMapperImpl();

      SharedPreferences.setMockInitialValues({
        AppSettingsRepository.appSettingsStorageKey: json.encode(
            appSettingsMapper.encode(AppSettings(locale: Locale(languageCode, ''))))
      });

      var _sharedPrefInstance = await SharedPreferences.getInstance();

      AppSettingsRepository _appSettingsRepository =
          AppSettingsRepository(sharedPreferences: _sharedPrefInstance);

      _getAppSettingsUseCase = GetAppLocalityService(
          loadAppSettingsPort: _appSettingsRepository,
          hasAppSettingsPort: _appSettingsRepository);

      var value = _getAppSettingsUseCase.currentLocality;
      expect(value, Locale(languageCode, ''));
    });
  }
}
