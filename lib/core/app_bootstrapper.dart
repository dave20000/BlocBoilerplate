import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';

import '../data/data_source/local/cache/cache_manager_impl.dart';
import '../data/data_source/local/db/hive_db.dart';
import 'configs/cubit_observer_log.dart';
import 'configs/http_config.dart';
import 'device/background_service.dart';
import 'device/logger_service.dart';
import 'injector/di.dart';

class AppBootStrapper {
  static Future<void> initialize() async {
    try {
      await BackgroundService.initialize();
      await DI.instance.setupInjection();
      HttpOverrides.global = MyHttpOverrides();
      await CacheManagerImpl.init();
      await HiveDb.initialize();
      Bloc.observer = CubitObserverLog(DI.resolve<LoggerService>());
    } catch (e) {
      log("Error : ${e.toString()}", error: e);
    }
  }
}
