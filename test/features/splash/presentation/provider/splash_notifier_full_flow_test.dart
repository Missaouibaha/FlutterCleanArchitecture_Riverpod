import 'package:clean_arch_riverpod/core/base/base_providers.dart';
import 'package:clean_arch_riverpod/core/helper/failure_model.dart';
import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_keys.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/featues/splash/presentation/providers/splash_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';

void main() {
  late ProviderContainer container;
  late MockSharedPreferencesHelper mockPrefs;
  setUp(() {
    mockPrefs = MockSharedPreferencesHelper();
    container = ProviderContainer(
      overrides: [sharedPrefHelperProvider.overrideWith((ref) => mockPrefs)],
    );
    addTearDown(() => container.dispose());
  });

  test('should return true when user is connected and token exists', () async {
    // arrange
    when(
      () => mockPrefs.getValue(SharedPreferencesKeys.isConnected, false),
    ).thenAnswer((_) async => true);

    when(
      () => mockPrefs.getSecureString(SharedPreferencesKeys.token),
    ).thenAnswer((_) async => 'validToken');
    // act: trigger the splashNotifier through Rierpod
    final result = await container.read(splashNotifierProvider.future);
    //Assert: should return true
    expect(result, true);
  });

  test(
    'should return false when user is disconnected or token not exists or both',
    () async {
      // arrange
      when(
        () => mockPrefs.getValue(SharedPreferencesKeys.isConnected, false),
      ).thenAnswer((_) async => false);
      when(
        () => mockPrefs.getString(SharedPreferencesKeys.token),
      ).thenAnswer((_) async => "");

      //act

      final result = await container.read(splashNotifierProvider.future);

      // Assert should return false
      expect(result, false);
    },
  );

  test('should fail and return Left(--) with an exception(eg : cache error ) ', () async {
    //arange
    when(
      () => mockPrefs.getValue(SharedPreferencesKeys.isConnected, false),
    ).thenThrow(Failure(ResponseMessage.CACHE_ERROR));
    when(
      () => mockPrefs.getSecureString(SharedPreferencesKeys.token),
    ).thenThrow(Failure(ResponseMessage.CACHE_ERROR));

    //act
    final result = await container.read(splashNotifierProvider.future);

    //assert should return false

    expect(result, false);
  });
}
