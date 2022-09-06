import '../../../domain/app_setting.dart';

abstract class LoadAppSettingsPort {
  AppSettings? loadAppSettings();
}