import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_helper.dart';
import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_keys.dart';
import 'package:flutter/material.dart';

class BaseLocalDataSource {
  final SharedPreferencesHelper? prefs;
  BaseLocalDataSource(this.prefs);

  Future<void> cacheToken(String token) async {
    try {
      await prefs?.setSecureString(SharedPreferencesKeys.token, token);
      await prefs?.setData(SharedPreferencesKeys.isConnected, token);
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
}
