import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_settings/app_settings.dart';
import 'package:mockito/mockito.dart';

class MockLoadAppSettings extends Mock implements LoadAppSettingsPort {}

class MockUpdateAppSettings extends Mock implements UpdateAppSettingsStatePort {}

class ChangeAppLanguageTest {
  static late LoadAppSettingsPort _loadAppSettingsPort;
  static late UpdateAppSettingsStatePort _updateAppSettingsStatePort;
  static late ChangeAppLanguageUseCase _changeLanguageUseCase;

  static void testChangeAppLanguage() {
    _loadAppSettingsPort = MockLoadAppSettings();
    _updateAppSettingsStatePort = MockUpdateAppSettings();

    _changeLanguageUseCase = ChangeAppLanguageService(
      loadAppSettingsPort: _loadAppSettingsPort,
      updateAppSettingsStatePort: _updateAppSettingsStatePort,
    );

    group("Testing: ChangeAppLanguage", () {
      test("-- with mocked ports--", () async {
        Locale _value = const Locale('ar', '');

        when(_loadAppSettingsPort.loadAppSettings())
            .thenAnswer((_) => AppSettings());
        when(_updateAppSettingsStatePort
                .updateSettings(AppSettings(locale: _value)))
            .thenAnswer((_) => Future.value());

        await _changeLanguageUseCase.changeLanguage(_value);

        verify(_loadAppSettingsPort.loadAppSettings());
        verify(_updateAppSettingsStatePort
            .updateSettings(AppSettings(locale: _value)));
      });
    });
  }
}
