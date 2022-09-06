import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_settings/app_settings.dart';
import 'package:mockito/mockito.dart';

class MockLoadAppSettings extends Mock implements LoadAppSettingsPort {}

class MockHasAppSettings extends Mock implements HasAppSettingsPort {}

class GetAppLocalityTest {
  static late LoadAppSettingsPort _loadAppSettingsPort;
  static late HasAppSettingsPort _hasAppSettingsPort;
  static late GetAppLocalityService _getAppSettingsUseCase;

  static void testGetAppLocality() {
    _loadAppSettingsPort = MockLoadAppSettings();
    _hasAppSettingsPort = MockHasAppSettings();

    _getAppSettingsUseCase = GetAppLocalityService(
        loadAppSettingsPort: _loadAppSettingsPort,
        hasAppSettingsPort: _hasAppSettingsPort);

    group("Testing: GetStoredAppLocality", () {
      _testIfNotStoredMocked();
      _testIfStoredMocked();
    });
  }

  static void _testIfNotStoredMocked() {
    test("-- with mocked ports - not stored--", () async {
      when(_hasAppSettingsPort.hasStored()).thenAnswer((_) => false);
      var value = _getAppSettingsUseCase.currentLocality;
      expect(value, const Locale('en', ''));
    });
  }

  static void _testIfStoredMocked() {
    test("-- with mocked ports - stored--", () async {
      when(_loadAppSettingsPort.loadAppSettings())
          .thenAnswer((_) => AppSettings(locale: const Locale('ar', '')));
      when(_hasAppSettingsPort.hasStored()).thenAnswer((_) => true);

      var value = _getAppSettingsUseCase.currentLocality;

      verify(_loadAppSettingsPort.loadAppSettings());
      expect(value, const Locale('ar', ''));
    });
  }
}
