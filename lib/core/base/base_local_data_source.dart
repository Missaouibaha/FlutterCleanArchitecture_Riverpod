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
      return await prefs!.getSecureString(SharedPreferencesKeys.isConnected);
    } catch (error) {
      debugPrint("get token error : $error");
      return "";
    }
  }

  Future cache<T>(String boxKey, String objectKey, T data) async {
    await hive?.openAndPut(boxKey, objectKey, data);
  }

  Future<T?> getCached<T>(String boxKey, String objectKey) async {
    return await hive?.openAndGet(boxKey, objectKey);
  }
}
