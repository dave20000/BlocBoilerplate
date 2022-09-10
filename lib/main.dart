import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'core/app_bootstrapper.dart';
import 'core/configs/cubit_observer_log.dart';
import 'presentation/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBootStrapper.initialize();
  _runAppInZone();
}

Future<void> _runAppInZone() async {
  Bloc.observer = CubitObserverLog();
  runZonedGuarded(() {
    runApp(
      // ProviderScope(
      //   observers: [
      //     ProviderLog(),
      //   ],
      //   child: const App(),
      // ),
      const App(),
    );
  }, (ex, s) {
    log("Error", error: ex, stackTrace: s);
  });
}
