import 'package:flutter_test/flutter_test.dart';
import 'change_app_settings_test.dart';
import 'get_app_locality_test.dart';
import 'get_app_settings_test.dart';
import 'has_app_settings_test.dart';
import 'change_app_language_test.dart';

void main() {
  group("--App Settings Unit Tests--", () {
    GetAppSettingsTest.testGetAppSettings();
    GetAppLocalityTest.testGetAppLocality();
    HasAppSettingsTest.testHasAppSettings();
    ChangeAppLanguageTest.testChangeAppLanguage();
    ChangeAppSettingsTest.testChangeAppSettings();
  });
}
