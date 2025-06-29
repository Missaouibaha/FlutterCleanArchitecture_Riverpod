import 'package:clean_arch_riverpod/core/helper/failure_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/featues/splash/domain/use_case/check_user_connection_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';

void main() {
  late MockSplashRepository mockeRepo;
  late CheckUserConnectionUseCase useCase;

  setUp(() {
    mockeRepo = MockSplashRepository();
    useCase = CheckUserConnectionUseCase(mockeRepo);
  });

  test('should return right(true) when user is connected', () async {
    // arrange

    when(() {
      return mockeRepo.isAuthenticated();
    }).thenAnswer((_) async => Right(true));

    // act
    final result = await useCase();

    // assert
    expect(result, Right(true));
    verify(() => mockeRepo.isAuthenticated()).called(1);
  });
  test('should return right(false) when user is disconnected', () async {
    // arrange
    when(() {
      return mockeRepo.isAuthenticated();
    }).thenAnswer((_) async {
      return Right(false);
    });

    // act
    final result = await useCase();

    //assert
    expect(result, Right(false));
    verify(() => mockeRepo.isAuthenticated()).called(1);
  });

  test('should fail and return Left(--) with an exception(eg : cache error ) ', () async {
    // arrange
    final failure = Left<Failure, bool>(
      Failure(ResponseMessage.CACHE_ERROR, code: ResponseCode.CACHE_ERROR),
    );

    when(
      () => mockeRepo.isAuthenticated(),
    ).thenAnswer((_) async => failure as Either<Failure, bool>);

    // act
    final result = await useCase();

    //assert
    expect(result, failure);
    verify(() => mockeRepo.isAuthenticated()).called(1);
  });
}
