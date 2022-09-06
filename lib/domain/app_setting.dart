import 'package:flutter/material.dart';

class AppSettings {
  final Locale locale;

  AppSettings(
      {this.locale = const Locale('en', '')});

  AppSettings copyWith({Locale? locale}) {
    return AppSettings(locale: locale ?? this.locale);
  }

  @override
  int get hashCode => locale.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! AppSettings) return false;
    return other.locale == locale;
  }
}
