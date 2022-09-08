import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'core/app_bootstrapper.dart';
import 'presentation/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBootStrapper.initialize();
  _runAppInZone();
}

Future<void> _runAppInZone() async {
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
