import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_keys.dart';
import 'package:clean_arch_riverpod/core/services/hive_keys.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/login_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/login_local_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helper/test_utils.dart';

void main() {
  late MockSharedPreferencesHelper mochPrefs;
  late MockHiveService mockHive;
  late LoginLocalDataSource loginLocalDataSource;
  final UserLocal user = UserLocal(name: 'Test ', token: 'fakeToken');

  setUp(() {
    mochPrefs = MockSharedPreferencesHelper();
    mockHive = MockHiveService();
    loginLocalDataSource = LoginLocalDataSourceImpl(
      prefs: mochPrefs,
      hive: mockHive,
    );
  });

  setUpAll(() {
    registerFallbackValue(UserLocal(name: '', token: ''));
  });

  test(
    'shoul cache token , connecivity on shared and save user on hive ',
    () async {
      //Arrange
      when(
        () => mochPrefs.setSecureString(any(), any()),
      ).thenAnswer((_) async {});

      when(() => mochPrefs.setData(any(), any())).thenAnswer((_) async {});

      when(
        () => mockHive.openAndPut<UserLocal>(any(), any(), any()),
      ).thenAnswer((_) async {});

      //Act
      await loginLocalDataSource.cacheUser(user);

      // assert
      verify(
        () =>
            mochPrefs.setSecureString(SharedPreferencesKeys.token, user.token),
      ).called(1);
      verify(
        () => mochPrefs.setData(SharedPreferencesKeys.isConnected, true),
      ).called(1);
      verify(
        () =>
            mockHive.openAndPut(HiveKeys.connectedUserBox, HiveKeys.user, user),
      ).called(1);
    },
  );
}
