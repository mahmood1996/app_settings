import 'package:app_settings/app_settings.dart';

class ChangeAppSettingsService implements ChangeAppSettingsUseCase {
  final UpdateAppSettingsStatePort updateAppSettingsStatePort;
  ChangeAppSettingsService({required this.updateAppSettingsStatePort});

  @override
  Future<void> changeAppSettings(AppSettings appSettings) async {
    await updateAppSettingsStatePort.updateSettings(appSettings);
  }
}