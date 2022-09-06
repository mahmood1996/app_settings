import 'package:app_settings/application/services/change_app_settings_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_settings/app_settings.dart';

class AppSettingsDI {
  static Future<void> init() async {
    var dependencyInjector = GetIt.instance;
    var preferencesInstance = await SharedPreferences.getInstance();
    dependencyInjector.registerLazySingleton<AppSettingsRepository>(() =>
        AppSettingsRepository(sharedPreferences: preferencesInstance));
  }

  static ChangeAppLanguageUseCase changeLanguage() {
    var dependencyInjector = GetIt.asNewInstance();
    dependencyInjector.registerFactory<ChangeAppLanguageUseCase>(() =>
        ChangeAppLanguageService(
            loadAppSettingsPort: GetIt.instance<AppSettingsRepository>(),
            updateAppSettingsStatePort:
                GetIt.instance<AppSettingsRepository>()));
    return dependencyInjector<ChangeAppLanguageUseCase>();
  }

  static ChangeAppSettingsUseCase changeAppSettings() {
    var dependencyInjector = GetIt.asNewInstance();
    dependencyInjector.registerFactory<ChangeAppSettingsUseCase>(() =>
        ChangeAppSettingsService(
            updateAppSettingsStatePort:
                GetIt.instance<AppSettingsRepository>()));
    return dependencyInjector<ChangeAppSettingsUseCase>();
  }

  static GetAppSettingsUseCase getAppSettingsUseCase() {
    var dependencyInjector = GetIt.asNewInstance();
    dependencyInjector
        .registerFactory<GetAppSettingsUseCase>(() => GetAppSettingsService(
              hasAppSettingsPort: GetIt.instance<AppSettingsRepository>(),
              loadAppSettingsPort: GetIt.instance<AppSettingsRepository>(),
            ));
    return dependencyInjector<GetAppSettingsUseCase>();
  }

  static HasStoredAppSettingsUseCase hasAppSettingsUseCase() {
    var dependencyInjector = GetIt.asNewInstance();
    dependencyInjector.registerFactory<HasStoredAppSettingsUseCase>(
        () => HasAppSettingsService(
              hasAppSettingsPort: GetIt.instance<AppSettingsRepository>(),
            ));
    return dependencyInjector<HasStoredAppSettingsUseCase>();
  }

  static GetAppLocalityUseCase getAppLocalityUseCase() {
    var dependencyInjector = GetIt.asNewInstance();
    dependencyInjector.registerFactory<GetAppLocalityUseCase>(() =>
        GetAppLocalityService(
            loadAppSettingsPort: GetIt.instance<AppSettingsRepository>(),
            hasAppSettingsPort: GetIt.instance<AppSettingsRepository>()));
    return dependencyInjector<GetAppLocalityUseCase>();
  }
}
