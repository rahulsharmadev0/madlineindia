// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:developer' as developer;
import 'package:flutter/material.dart';

ScaffoldMessengerState get messenger => Config.messengerKey.currentState!;

NavigatorState get navigation => Config.navigatorKey.currentState!;

void printLog(Object? message, {bool isTime = false}) {
  if (Config.isDebugMode) {
    developer.log('$message', time: isTime ? DateTime.now() : null);
  }
}

class Config {
  Config._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static const isDebugMode = true;
}
