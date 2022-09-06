import 'package:flutter/material.dart';
import '../../domain/app_setting.dart';

abstract class _IMapper <ResultOfEncode, Data> {
  Data           decode (ResultOfEncode data);
  ResultOfEncode encode (Data data);
}

abstract class AppSettingsMapper<T extends AppSettings> implements _IMapper<Map<String, dynamic>, T> {
  @override
  Map<String, dynamic> encode(T appSettings);

  @override
  T decode(Map<String, dynamic> data);
}

class AppSettingsMapperImpl implements AppSettingsMapper<AppSettings> {
  final _LocalityMapper _localityMapper;
  AppSettingsMapperImpl() : _localityMapper = _LocalityMapper();

  @override
  AppSettings decode(Map<String, dynamic> data) {
    return AppSettings(locale: _localityMapper.decode(data['locale']));
  }

  @override
  Map<String, dynamic> encode(AppSettings appSettings) {
    return <String, dynamic> {
      'locale' : _localityMapper.encode(appSettings.locale)
    };
  }
}

class _LocalityMapper implements _IMapper<Map<String, dynamic>, Locale> {
  @override
  Locale decode(Map<String, dynamic> data) {
    return Locale(
      data['lang'],
      data['country_code']
    );
  }

  @override
  Map<String, dynamic> encode(Locale locale) {
    return <String, dynamic> {
      'lang': locale.languageCode,
      'country_code': locale.countryCode
    };
  }
}