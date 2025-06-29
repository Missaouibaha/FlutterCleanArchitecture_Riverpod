import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_keys.dart';
import 'package:clean_arch_riverpod/core/services/hive_keys.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/local/register_local_datasource.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/local/register_local_datasource_impl.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helper/test_utils.dart';

void main() {
  late MockSharedPreferencesHelper mockSharedPrefHelper;
  late MockHiveService mockHive;
  late RegisterLocalDatasource registerLocalDatasource;
  final fakeUser = UserLocal(name: "name", token: "token");

  setUp(() {
    mockSharedPrefHelper = MockSharedPreferencesHelper();
    mockHive = MockHiveService();
    registerLocalDatasource = RegisterLocalDatasourceImpl(
      hive: mockHive,
      prefs: mockSharedPrefHelper,
    );
  });

  setUpAll(() {
    registerFallbackValue(UserLocal(name: '', token: ''));
  });
  test("success cache user ", () async {
    when(
      () => mockSharedPrefHelper.setSecureString(any(), any()),
    ).thenAnswer((_) async {});

    when(
      () => mockSharedPrefHelper.setData(any(), any()),
    ).thenAnswer((_) async {});

    when(
      () => mockHive.openAndPut<UserLocal>(any(), any(), any()),
    ).thenAnswer((_) async {});

    //act
    await registerLocalDatasource.cacheUser(fakeUser);

    //assert

    verify(
      () => mockSharedPrefHelper.setSecureString(
        SharedPreferencesKeys.token,
        "token",
      ),
    ).called(1);
    verify(
      () =>
          mockSharedPrefHelper.setData(SharedPreferencesKeys.isConnected, true),
    ).called(1);
    verify(
      () => mockHive.openAndPut<UserLocal>(
        HiveKeys.connectedUserBox,
        HiveKeys.user,
        fakeUser,
      ),
    ).called(1);
  });
}
