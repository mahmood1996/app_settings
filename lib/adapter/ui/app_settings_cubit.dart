import 'dart:ui';
import 'package:app_settings/app_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSettingsCubit extends Cubit<AppSettings> {
  late GetAppSettingsUseCase _appSettingsUseCase;
  late ChangeAppLanguageUseCase _changeLanguageUseCase;
  late ChangeAppSettingsUseCase _changeAppSettingsUseCase;

  AppSettingsCubit()
      : super(AppSettingsDI.getAppSettingsUseCase().getAppSettings()) {
    _appSettingsUseCase = AppSettingsDI.getAppSettingsUseCase();
    _changeLanguageUseCase = AppSettingsDI.changeLanguage();
    _changeAppSettingsUseCase = AppSettingsDI.changeAppSettings();
  }

  Future<void> changeLanguage(Locale locale) async {
    await _changeLanguageUseCase.changeLanguage(locale);
    _loadAppSettings();
  }

  Future<void> changeAppSettings(AppSettings appSettings) async {
    await _changeAppSettingsUseCase.changeAppSettings(appSettings);
    _loadAppSettings();
  }

  void _loadAppSettings() {
    emit(_appSettingsUseCase.getAppSettings());
  }
}