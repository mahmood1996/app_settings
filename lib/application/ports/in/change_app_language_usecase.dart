import 'package:flutter/material.dart';

abstract class ChangeAppLanguageUseCase {
  Future<void>? changeLanguage(Locale locale);
}