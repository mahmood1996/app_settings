import 'dart:async';
import 'package:flutter/material.dart';

abstract class GetAppLocalityUseCase {
  FutureOr<Locale> get currentLocality;
}