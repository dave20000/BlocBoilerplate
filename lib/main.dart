import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'core/app_bootstrapper.dart';
import 'core/configs/cubit_observer_log.dart';
import 'core/device/logger_service.dart';
import 'core/injector/di.dart';
import 'presentation/ui/app.dart';

abstract class Main {
  static Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppBootStrapper.initialize();
    _runAppInZone();
  }

  static Future<void> _runAppInZone() async {
    final loggerService = DI.resolve<LoggerService>();
    runZonedGuarded(() {
      Bloc.observer = CubitObserverLog(loggerService);
      runApp(const App());
    }, (ex, s) {
      loggerService.logException(ex, s);
    });
  }
}
