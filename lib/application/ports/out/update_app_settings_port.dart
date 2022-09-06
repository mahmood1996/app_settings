import '../../../domain/app_setting.dart';

abstract class UpdateAppSettingsStatePort {
  Future<void>? updateSettings(AppSettings appSettings);
}