import 'package:app_settings/app_settings.dart';

abstract class ChangeAppSettingsUseCase {
  Future<void> changeAppSettings(AppSettings appSettings);
}