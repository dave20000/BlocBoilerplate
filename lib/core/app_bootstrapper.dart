import 'dart:io';

import '../data/data_source/local/cache/cache_manager_impl.dart';
import '../data/data_source/local/db/hive_db.dart';
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
    } catch (ex, s) {
      DI.resolve<LoggerService>().logException(ex, s);
    }
  }
}
