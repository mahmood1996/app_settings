import 'package:flutter_test/flutter_test.dart';
import 'package:app_settings/app_settings.dart';
import 'package:mockito/mockito.dart';

class MockLoadAppSettings extends Mock implements LoadAppSettingsPort {}

class MockHasAppSettings extends Mock implements HasAppSettingsPort {}

class HasAppSettingsTest {
  static late HasAppSettingsPort _hasAppSettingsPort;
  static late HasStoredAppSettingsUseCase _hasAppSettingsUseCase;

  static void testHasAppSettings() {
    _hasAppSettingsPort = MockHasAppSettings();

    _hasAppSettingsUseCase = HasAppSettingsService(
      hasAppSettingsPort: _hasAppSettingsPort
    );

    group("Testing: HasStoredSettings", () {
      test("-- with mocked ports -not stored--", () async {
        when(_hasAppSettingsPort.hasStored()).thenAnswer((_) => false);
        var value = await _hasAppSettingsUseCase.hasStoredAppSettings()!;
        expect(value, false);
      });
      test("--with mocked ports -stored--", () async {
        when(_hasAppSettingsPort.hasStored()).thenAnswer((_) => true);
        var value = await _hasAppSettingsUseCase.hasStoredAppSettings()!;
        expect(value, true);
      });
    });
  }
}
