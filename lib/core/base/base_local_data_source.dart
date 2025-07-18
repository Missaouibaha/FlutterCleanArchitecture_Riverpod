import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_helper.dart';
import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_keys.dart';
import 'package:clean_arch_riverpod/core/services/hive_service.dart';
import 'package:flutter/material.dart';

class BaseLocalDataSource {
  final SharedPreferencesHelper? prefs;
  final HiveService? hive;
  BaseLocalDataSource({this.prefs, this.hive});

  Future<void> cacheUserToken(String token) async {
    try {
      await prefs?.setSecureString(SharedPreferencesKeys.token, token);
      await prefs?.setData(SharedPreferencesKeys.isConnected, true);
    } catch (error) {
      debugPrint("save token error : $error");
    }
  }

  Future<String> getToken() async {
    try {
      return await prefs!.getSecureString(SharedPreferencesKeys.token);
    } catch (error) {
      debugPrint("get token error : $error");
      return "";
    }
  }

  Future cache<T>(String boxKey, String objectKey, T data) async {
    try {
      await hive?.openAndPut<T>(boxKey, objectKey, data);
    } catch (error) {
      debugPrint("cache error : $error");
    }
  }

  Future<void> cacheList<T>(String boxKey, List<T> data) async {
    // Clear the box before inserting new data
    await hive?.clearBox<T>(boxKey);

    for (int i = 0; i < data.length; i++) {
      try {
        await cache<T>(boxKey, '$i', data[i]);
      } catch (error) {
        debugPrint("cache list error : $error");
      }
    }
  }

  Future<List<T>?> getCachedList<T>(String boxKey) async {
    final box = await hive?.openBox<T>(boxKey);
    return box?.values.toList();
  }

  Future<T?> getCached<T>(String boxKey, String objectKey) async {
    return await hive?.openAndGet<T?>(boxKey, objectKey);
  }

  Future<void> logoutAndClearCache() async {
    await prefs?.clearAllData();
    await hive?.clearAll();
  }
}
