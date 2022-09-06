import '../ports/in/has_app_settings_usecase.dart';
import '../ports/out/has_app_settings_port.dart';

class HasAppSettingsService implements HasStoredAppSettingsUseCase {
  final HasAppSettingsPort hasAppSettingsPort;
  HasAppSettingsService({required this.hasAppSettingsPort});

  @override
  Future<bool> hasStoredAppSettings() async {
    return hasAppSettingsPort.hasStored()!;
  }
}