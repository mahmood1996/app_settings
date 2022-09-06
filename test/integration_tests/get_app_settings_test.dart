import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAppSettingsTest {
  static late GetAppSettingsUseCase _getAppSettingsUseCase;

  static void testGetAppSettings() {
    group("Testing: GetStoredSettings", () {
      test("-- with ports impl -- not-stored", () async {
        SharedPreferences.setMockInitialValues({});

        var _sharedPrefInstance = await SharedPreferences.getInstance();

        AppSettingsRepository _appSettingsRepository =
            AppSettingsRepository(sharedPreferences: _sharedPrefInstance);

        _getAppSettingsUseCase = GetAppSettingsService(
            loadAppSettingsPort: _appSettingsRepository,
            hasAppSettingsPort: _appSettingsRepository);

        var value = _getAppSettingsUseCase.getAppSettings();
        expect(value, AppSettings());
      });
      test("-- with ports impl -- stored", () async {
        var appSettingsMapper = AppSettingsMapperImpl();

        SharedPreferences.setMockInitialValues({
          AppSettingsRepository.appSettingsStorageKey: json.encode(
              appSettingsMapper.encode(AppSettings(locale: const Locale('ar', ''))))
        });

        var _sharedPrefInstance = await SharedPreferences.getInstance();

        AppSettingsRepository _appSettingsRepository =
            AppSettingsRepository(sharedPreferences: _sharedPrefInstance);

        _getAppSettingsUseCase = GetAppSettingsService(
            loadAppSettingsPort: _appSettingsRepository,
            hasAppSettingsPort: _appSettingsRepository);

        var value = _getAppSettingsUseCase.getAppSettings();
        expect(value, AppSettings(locale: const Locale('ar', '')));
      });
    });
  }
}
