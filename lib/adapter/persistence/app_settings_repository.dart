import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../application/ports/out/has_app_settings_port.dart';
import '../../application/ports/out/load_app_settings_port.dart';
import '../../application/ports/out/update_app_settings_port.dart';
import '../../domain/app_setting.dart';
import 'app_settings_mapper.dart';

class AppSettingsRepository<T extends AppSettings>
    implements
        LoadAppSettingsPort,
        UpdateAppSettingsStatePort,
        HasAppSettingsPort {
  late SharedPreferences _sharedPreferences;
  late AppSettingsMapper _appSettingsMapper;

  AppSettingsRepository(
      {required SharedPreferences sharedPreferences,
      AppSettingsMapper? appSettingsMapper}) {
    _appSettingsMapper = appSettingsMapper ?? AppSettingsMapperImpl();
    _sharedPreferences = sharedPreferences;
  }

  static const String appSettingsStorageKey = "#AppSettings";

  @override
  bool hasStored() => _sharedPreferences.containsKey(appSettingsStorageKey);

  @override
  AppSettings loadAppSettings() => hasStored()
      ? _appSettingsMapper.decode(
          json.decode(_sharedPreferences.getString(appSettingsStorageKey)!))
      : AppSettings();

  @override
  Future<void> updateSettings(AppSettings appSettings) async {
    await _sharedPreferences.setString(appSettingsStorageKey,
        json.encode(_appSettingsMapper.encode(appSettings)));
  }
}
