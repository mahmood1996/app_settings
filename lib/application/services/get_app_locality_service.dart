import 'dart:async';
import 'dart:ui';
import '../ports/in/get_app_locality_usecase.dart';
import '../ports/out/has_app_settings_port.dart';
import '../ports/out/load_app_settings_port.dart';


class GetAppLocalityService implements GetAppLocalityUseCase {
  final LoadAppSettingsPort loadAppSettingsPort;
  final HasAppSettingsPort hasAppSettingsPort;
  GetAppLocalityService(
      {required this.loadAppSettingsPort, required this.hasAppSettingsPort});

  @override
  FutureOr<Locale> get currentLocality => _currentLocality();

  FutureOr<Locale> _currentLocality() {
    if (!hasAppSettingsPort.hasStored()!) return const Locale('en', '');
    return loadAppSettingsPort.loadAppSettings()!.locale;
  }
}
