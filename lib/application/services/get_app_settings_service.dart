import '../../domain/app_setting.dart';
import '../ports/in/get_app_settings_usecase.dart';
import '../ports/out/has_app_settings_port.dart';
import '../ports/out/load_app_settings_port.dart';

class GetAppSettingsService implements GetAppSettingsUseCase {
  final LoadAppSettingsPort loadAppSettingsPort;
  final HasAppSettingsPort hasAppSettingsPort;
  GetAppSettingsService(
      {required this.loadAppSettingsPort, required this.hasAppSettingsPort});

  @override
  AppSettings getAppSettings() {
    if (! hasAppSettingsPort.hasStored()!) return AppSettings();
    return loadAppSettingsPort.loadAppSettings()!;
  }
}
