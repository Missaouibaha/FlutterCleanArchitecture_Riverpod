import 'package:clean_arch_riverpod/core/services/hive_keys.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/city.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/doctor.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/governorate.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/home_data.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/specialization.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/models/user_profile_data.dart';
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
    Hive.registerAdapter(HomeDataAdapter());
    Hive.registerAdapter(DoctorAdapter());
    Hive.registerAdapter(SpecializationAdapter());
    Hive.registerAdapter(CityAdapter());
    Hive.registerAdapter(GovernorateAdapter());
    Hive.registerAdapter(UserProfileDataAdapter());
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

    if (Hive.isBoxOpen(boxKey)) {
      box = Hive.box<T>(boxKey);
    } else {
      box = await Hive.openBox<T>(boxKey);
    }

    return box.get(dataKey);
  }

  Future<void> openAndPut<T>(String boxKey, dynamic dataKey, T data) async {
    Box<T> box;
    box = await openBox<T>(boxKey);
    await box.put(dataKey, data);
  }

  Future<void> clearAll() async {
    await _clearAndCloseBox<UserLocal?>(HiveKeys.connectedUserBox);
    await _clearAndCloseBox<HomeData>(HiveKeys.homeDataListBox);
    await _clearAndCloseBox<Doctor>(HiveKeys.recomendedDocListBox);
    await _clearAndCloseBox<Doctor>(HiveKeys.doctorsListBox);
    await _clearAndCloseBox<UserProfileData?>(HiveKeys.userProfileBox);
    await Hive.close();
    await Hive.deleteFromDisk();
  }

  Future<void> _clearAndCloseBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      try {
        await Hive.box<T>(boxName).clear();
      } catch (error, st) {
        debugPrint("$error");
      }
    } else {
      final box = await Hive.openBox<T>(boxName);
      await box.clear();
      await box.close();
    }
  }

  Future<void> clearBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      try {
        await Hive.box<T>(boxName).clear();
      } catch (error, st) {
        debugPrint("$error");
      }
    } else {
      final box = await Hive.openBox<T>(boxName);
      await box.clear();
    }
  }
}
