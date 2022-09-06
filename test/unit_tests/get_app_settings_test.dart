import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_settings/app_settings.dart';
import 'package:mockito/mockito.dart';

class MockLoadAppSettings extends Mock implements LoadAppSettingsPort {}

class MockHasAppSettings extends Mock implements HasAppSettingsPort {}

class GetAppSettingsTest {
  static late LoadAppSettingsPort _loadAppSettingsPort;
  static late HasAppSettingsPort _hasAppSettingsPort;
  static late GetAppSettingsUseCase _getAppSettingsUseCase;

  static void testGetAppSettings() {
    _loadAppSettingsPort = MockLoadAppSettings();
    _hasAppSettingsPort = MockHasAppSettings();

    _getAppSettingsUseCase = GetAppSettingsService(
        loadAppSettingsPort: _loadAppSettingsPort,
        hasAppSettingsPort: _hasAppSettingsPort);

    group("Testing: GetStoredSettings", () {
      test("-- with mocked ports - not stored--", () async {
        when(_hasAppSettingsPort.hasStored()).thenAnswer((_) => false);
        var value = _getAppSettingsUseCase.getAppSettings();
        expect(value, AppSettings());
      });
      test("-- with mocked ports - stored--", () async {
        when(_loadAppSettingsPort.loadAppSettings())
            .thenAnswer((_) => AppSettings(locale: const Locale('ar', '')));
        when(_hasAppSettingsPort.hasStored()).thenAnswer((_) => true);

        var value = _getAppSettingsUseCase.getAppSettings();

        verify(_loadAppSettingsPort.loadAppSettings());
        expect(value, AppSettings(locale: const Locale('ar', '')));
      });
    });
  }
}
