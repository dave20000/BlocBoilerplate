import 'dart:developer';
import 'dart:io';

import '../data/data_source/api/api_manager/api_manager.dart';
import '../data/data_source/local/cache/cache_manager.dart';
import '../data/data_source/local/cache/cache_manager_impl.dart';
import '../data/data_source/local/db/hive_db.dart';
import '../data/data_source/local/secure_storage/secure_storage_manager.dart';
import 'configs/app_configuration.dart';
import 'configs/http_config.dart';
import 'device/background_service.dart';
import 'injector/di.dart';

class AppBootStrapper {
  static Future<void> initialize() async {
    try {
      await BackgroundService.initialize();
      await DI.instance.setupInjection();
      DI.resolve<SecureStorageManager>();
      DI.resolve<CacheManager>();
      DI.resolve<ApiManager>(
        param1: AppConfiguration.baseUrl,
      );
      HttpOverrides.global = MyHttpOverrides();
      await CacheManagerImpl.init();
      await HiveDb.initialize();
    } catch (e) {
      log("Error : ${e.toString()}", error: e);
    }
  }
}
