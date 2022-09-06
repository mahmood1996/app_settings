import 'dart:ui';
import '../../domain/app_setting.dart';
import '../ports/in/change_app_language_usecase.dart';
import '../ports/out/load_app_settings_port.dart';
import '../ports/out/update_app_settings_port.dart';

class ChangeAppLanguageService implements ChangeAppLanguageUseCase {
  final LoadAppSettingsPort         loadAppSettingsPort;
  final UpdateAppSettingsStatePort  updateAppSettingsStatePort;

  ChangeAppLanguageService({
    required this.updateAppSettingsStatePort,
    required this.loadAppSettingsPort
  });

  @override
  Future<void> changeLanguage(Locale locale) async {
    AppSettings settings = loadAppSettingsPort.loadAppSettings()!;
    await updateAppSettingsStatePort.updateSettings(settings.copyWith(locale: locale));
  }
}