import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HasAppSettingsTest {
  static late HasStoredAppSettingsUseCase _hasAppSettingsUseCase;

  static void testHasAppSettings() {
    group("Testing: HasStoredSettings", () {
      test("--with ports impl --not-stored", () async {
        SharedPreferences.setMockInitialValues({});

        var _sharedPrefInstance = await SharedPreferences.getInstance();

        AppSettingsRepository _appSettingsRepository =
        AppSettingsRepository(sharedPreferences: _sharedPrefInstance);

        _hasAppSettingsUseCase = HasAppSettingsService(
          hasAppSettingsPort: _appSettingsRepository
        );

        var value = await _hasAppSettingsUseCase.hasStoredAppSettings()!;
        expect(value, false);
      });
      test("-- with ports impl --stored", () async {
        var appSettingsMapper = AppSettingsMapperImpl();

        SharedPreferences.setMockInitialValues({
          AppSettingsRepository.appSettingsStorageKey: json.encode(
              appSettingsMapper.encode(AppSettings()))
        });

        var _sharedPrefInstance = await SharedPreferences.getInstance();

        AppSettingsRepository _appSettingsRepository =
        AppSettingsRepository(sharedPreferences: _sharedPrefInstance);

        _hasAppSettingsUseCase = HasAppSettingsService(
          hasAppSettingsPort: _appSettingsRepository
        );

        var value = await _hasAppSettingsUseCase.hasStoredAppSettings()!;
        expect(value, true);
      });
    });
  }
}
