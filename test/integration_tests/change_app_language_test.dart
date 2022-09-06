import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeAppLanguageTest {
  static late ChangeAppLanguageUseCase _changeLanguageUseCase;

  static void testChangeAppLanguage() {
    group("Testing: ChangeAppLanguage", () {
      test("-- with ports impl--", () async {
        Locale _value = const Locale('ar', '');

        SharedPreferences.setMockInitialValues({});

        var _sharedPrefInstance = await SharedPreferences.getInstance();

        AppSettingsRepository _appSettingsRepository =
            AppSettingsRepository(sharedPreferences: _sharedPrefInstance);

        _changeLanguageUseCase = ChangeAppLanguageService(
          updateAppSettingsStatePort: _appSettingsRepository,
          loadAppSettingsPort: _appSettingsRepository,
        );

        await _changeLanguageUseCase.changeLanguage(_value);
      });
    });
  }
}
