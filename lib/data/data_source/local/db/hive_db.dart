import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//TODO: Add adapters for other types in configure function
@injectable
class HiveDb {
  // ignore: avoid_void_async
  static Future<void> initialize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final String path = join(dir.path, 'hive_local_storage');
      if (!(await Directory(path).exists())) {
        // await Directory(path).delete(recursive: true);
        await Directory(path).create();
      }
      Hive.init(path);

      //TODO: register adapter and open box here
      // Hive.registerAdapter(UserAdapter());
    } catch (exception) {
      if (kDebugMode) print(exception);
    }
  }

  Future<Box<T>?> _openBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    } else {
      return Hive.openBox<T>(boxName);
    }
  }

  Future<List?> getAll<T>(String boxName) async {
    try {
      final box = await _openBox<T>(boxName);
      return (box != null) ? box.values.toList() : <T>[];
    } catch (ex) {
      return null;
    } finally {
      if (Hive.isBoxOpen(boxName)) await Hive.close();
    }
  }

  Future<void> addAll<T>(String boxName, Iterable<T> values) async {
    try {
      final box = await _openBox<T>(boxName);
      await box?.addAll(values);
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
    } finally {
      if (Hive.isBoxOpen(boxName)) await Hive.close();
    }
  }

  Future<void> clearAll<T>(String boxName) async {
    try {
      final box = await _openBox<T>(boxName);
      await box?.clear();
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    } finally {
      if (Hive.isBoxOpen(boxName)) await Hive.close();
    }
  }

  Future<void> clearAllBoxes(List<String> boxNames) async {
    try {
      // ignore: avoid_function_literals_in_foreach_calls
      boxNames.forEach((boxName) async {
        await clearAll(boxName);
      });
      await Hive.close();
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }
}
