import 'package:clean_arch_riverpod/core/services/hive_keys.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  Future<void> init() async {
    if (!kIsWeb) {
      final dir = await getApplicationCacheDirectory();
      Hive.init(dir.path);
    } else {
      await Hive.initFlutter();
    }
    Hive.registerAdapter(UserLocalAdapter());
  }

  Future<Box<T>> openBox<T>(String name) async {
    if (!Hive.isBoxOpen(name)) {
      return await Hive.openBox<T>(name);
    }
    return Hive.box<T>(name);
  }

  Box<T> getBox<T>(String name) {
    if (!Hive.isBoxOpen(name)) {
      throw Exception('Box "$name" is not open , use openBox()first');
    }
    return Hive.box<T>(name);
  }

  Future<T?> openAndGet<T>(String boxKey, dynamic dataKey) async {
    Box<T> box;
    box = await openBox(boxKey);
    return box.get(dataKey);
  }

  Future<void> openAndPut<T>(String boxKey, dynamic dataKey, T data) async {
    Box<T> box;
    box = await openBox(boxKey);
    await box.put(dataKey, data);
  }

  Future<void> clearAll() async {
    for (var boxName in [HiveKeys.connectedUserBox, HiveKeys.user]) {
      await clearBox(boxName);
    }
    await Hive.close();
    await Hive.deleteFromDisk();
  }

  Future<void> clearBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).clear();
    } else {
      final box = await Hive.openBox(boxName);
      await box.clear();
      await box.close();
    }
  }

  Future<void> clear() async {
    if (Hive.isBoxOpen(HiveKeys.connectedUserBox)) {
      await Hive.box<UserLocal>(HiveKeys.connectedUserBox).clear();
      await Hive.box<UserLocal>(HiveKeys.connectedUserBox).close();
    }

    await Hive.close();
    await Hive.deleteFromDisk();
  }
}
