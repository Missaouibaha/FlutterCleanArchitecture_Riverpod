import 'package:clean_arch_riverpod/core/helper/failure_model.dart';
import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_keys.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/featues/splash/data/data_sources/local/splash_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/splash/data/data_sources/local/splash_local_data_source_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helper/test_utils.dart';

void main() {
  late MockSharedPreferencesHelper mockShrdHelper;
  late SplashLocalDataSource localDataSource;

  setUp(() {
    mockShrdHelper = MockSharedPreferencesHelper();
    localDataSource = SplashLocalDataSourceImpl(prefs: mockShrdHelper);
  });
  test('should return right(true) if is connected and token exists ', () async {
    //arrange

    when(
      () => mockShrdHelper.getValue(SharedPreferencesKeys.isConnected, false),
    ).thenAnswer((_) async => true);

    when(
      () => mockShrdHelper.getSecureString(SharedPreferencesKeys.token),
    ).thenAnswer((_) async => 'validToken');
    //act
    final result = await localDataSource.isConnected();

    //assert

    expect(result, Right(true));
    verify(() {
      mockShrdHelper.getValue(SharedPreferencesKeys.isConnected, false);
      mockShrdHelper.getSecureString(SharedPreferencesKeys.token);
    }).called(1);
  });

  test(
    'should return right(false) if isn\'t connected and token exists ',
    () async {
      // arange

      when(
        () => mockShrdHelper.getValue(SharedPreferencesKeys.isConnected, false),
      ).thenAnswer((_) async => false);
      when(
        () => mockShrdHelper.getSecureString(SharedPreferencesKeys.token),
      ).thenAnswer((_) async => "validToken");

      // act
      final result = await localDataSource.isConnected();

      // assert
      expect(result, Right(false));
    },
  );

  test(
    'should return right(false) if is connected but token not exists  ',
    () async {
      // arange

      when(
        () => mockShrdHelper.getValue(SharedPreferencesKeys.isConnected, false),
      ).thenAnswer((_) async => true);
      when(
        () => mockShrdHelper.getSecureString(SharedPreferencesKeys.token),
      ).thenAnswer((_) async => '');

      // act
      final result = await localDataSource.isConnected();

      // assert
      expect(result, Right(false));
    },
  );
  test('should fail with an exception(eg : cache error )', () async {
    // arange
    when(
      () => mockShrdHelper.getValue(SharedPreferencesKeys.isConnected, false),
    ).thenThrow(Exception(ResponseMessage.CACHE_ERROR));
    when(
      () => mockShrdHelper.getSecureString(SharedPreferencesKeys.token),
    ).thenThrow(Exception(ResponseMessage.CACHE_ERROR));

    // act
    final result = await localDataSource.isConnected();

    // assert
    expect(
      result,
      isA<Left<Failure, bool>>().having(
        (left) => left.value.message,
        'failure message',
        contains(ResponseMessage.CACHE_ERROR),
      ),
    );
  });
}
