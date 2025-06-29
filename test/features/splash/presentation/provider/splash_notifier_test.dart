import 'package:clean_arch_riverpod/core/helper/failure_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/featues/splash/domain/providers/splash_usecase_providers.dart';
import 'package:clean_arch_riverpod/featues/splash/presentation/providers/splash_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';

void main() {
  late ProviderContainer providerContainer;
  late MockSplashUseCase mockUSeCases;

  setUp(() {
    mockUSeCases = MockSplashUseCase();

    providerContainer = ProviderContainer(
      overrides: [
        splashUseCaseProvider.overrideWith((ref) async => mockUSeCases),
      ],
    );
    addTearDown(() => providerContainer.dispose());
  });

  test('should return true if usecase return true', () async {
    //arrange

    when(() => mockUSeCases.call()).thenAnswer((_) async => Right(true));

    //act
    final notifier = providerContainer.read(splashNotifierProvider.notifier);
    final future = notifier.build();
    //assert
    expect(await future, true);
  });

  test('should return false if usecase return false', () async {
    //arrange
    when(() => mockUSeCases.call()).thenAnswer((_) async => Right(false));
    //act
    final notifier = providerContainer.read(splashNotifierProvider.notifier);
    final future = notifier.build();

    //assert
    expect(await future, false);
  });

  test('should fail with an exception(eg : cache error )', () async {
    final failure = Failure(ResponseMessage.CACHE_ERROR);

    when(() => mockUSeCases.call()).thenAnswer((_) async => Left(failure));

    //act
    final notifier = providerContainer.read(splashNotifierProvider.notifier);
    final future = notifier.build();

    expect(await future, false);
  });
}
