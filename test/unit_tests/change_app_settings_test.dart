import 'package:app_settings/application/services/change_app_settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_settings/app_settings.dart';
import 'package:mockito/mockito.dart';

class MockUpdateAppSettings extends Mock implements UpdateAppSettingsStatePort {
}

class ChangeAppSettingsTest {
  static late UpdateAppSettingsStatePort _updateAppSettingsStatePort;
  static late ChangeAppSettingsUseCase _changeAppSettingsUseCase;

  static void testChangeAppSettings() {
    _updateAppSettingsStatePort = MockUpdateAppSettings();

    _changeAppSettingsUseCase = ChangeAppSettingsService(
      updateAppSettingsStatePort: _updateAppSettingsStatePort,
    );

    group("Testing: ChangeAppSettings", () {
      test("-- with mocked ports--", () async {
        var _value = AppSettings(locale: const Locale('ar', ''));

        when(_updateAppSettingsStatePort.updateSettings(_value))
            .thenAnswer((_) => Future.value());

        await _changeAppSettingsUseCase.changeAppSettings(_value);

        verify(_updateAppSettingsStatePort.updateSettings(_value));
      });
    });
  }
}
