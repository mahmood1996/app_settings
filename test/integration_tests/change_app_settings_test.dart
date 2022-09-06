import 'package:app_settings/application/services/change_app_settings_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_settings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeAppSettingsTest {
  static late ChangeAppSettingsUseCase _changeAppSettingsUseCase;

  static void testChangeAppSettings() {
    group("Testing: ChangeAppSettings", () {
      test("-- with ports impl--", () async {
        var _value = AppSettings();

        SharedPreferences.setMockInitialValues({});

        var _sharedPrefInstance = await SharedPreferences.getInstance();

        AppSettingsRepository _appSettingsRepository =
            AppSettingsRepository(sharedPreferences: _sharedPrefInstance);

        _changeAppSettingsUseCase = ChangeAppSettingsService(
          updateAppSettingsStatePort: _appSettingsRepository,
        );

        await _changeAppSettingsUseCase.changeAppSettings(_value);
      });
    });
  }
}
