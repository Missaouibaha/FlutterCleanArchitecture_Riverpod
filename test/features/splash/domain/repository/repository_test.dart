import 'package:clean_arch_riverpod/core/helper/failure_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/featues/splash/data/repository/splash_repository_implementation.dart';
import 'package:clean_arch_riverpod/featues/splash/domain/repository/splash_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';

void main() {
  late SplashMockLocalDataSource mockDataSource;
  late SplashRepository splashRepository;

  setUp(() {
    mockDataSource = SplashMockLocalDataSource();
    splashRepository = SplashRepositoryImplementation(mockDataSource);
  });

  test('should return Right(true) if is connected', () async {
    //arrange
    when(
      () => mockDataSource.isConnected(),
    ).thenAnswer((_) async => Right(true));

    //act
    final result = await splashRepository.isAuthenticated();
    //assert
    expect(result, Right(true));
    verify(() => mockDataSource.isConnected()).called(1);
  });

  test('should return Right(false) if is disconnected', () async {
    //arrange
    when(() {
      return mockDataSource.isConnected();
    }).thenAnswer((_) async => Right(false));

    //act
    final result = await splashRepository.isAuthenticated();
    //assert
    expect(result, Right(false));
    verify(() => mockDataSource.isConnected()).called(1);
  });

  test(
    'should fail and return Left(--) with an exception(eg : cache error ) ',
    () async {
      final failure = Failure(
        ResponseMessage.CACHE_ERROR,
        code: ResponseCode.CACHE_ERROR,
      );
      //arrange
      when(() {
        return mockDataSource.isConnected();
      }).thenAnswer((_) async => Left(failure));

      //act
      final result = await splashRepository.isAuthenticated();
      //assert
      expect(result, Left(failure));
      verify(() => mockDataSource.isConnected()).called(1);
    },
  );
}
