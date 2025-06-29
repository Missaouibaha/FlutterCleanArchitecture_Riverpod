import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_response.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/usecases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';

void main() {
  late MockLoginRepository mockRepo;
  late LoginUseCase mockUsecase;

  final fakeUser = User(name: 'name', token: "token");
  setUp(() {
    mockRepo = MockLoginRepository();
    mockUsecase = LoginUseCase(mockRepo);
  });

  test("should user login success and returna user object...", () async {
    //arrange
    when(
      () => mockRepo.login("email", "password"),
    ).thenAnswer((_) async => ApiResult.success(fakeUser));

    //act
    final result = await mockUsecase.call("email", "password");

    // assert
    result.when(
      success: (user) {
        expect(user, fakeUser);
      },
      failure: (errorHandler) {
        fail("Test failed: expected success, but got failure.");
      },
    );
  });
  test(
    "Login must fail if credentials are incorrect or any server exception is thrown.",
    () async {
      final failLoginResponse = LoginResponse(
        message: "Credentials doesn`t match our records",
        userData: null,
        status: false,
        code: 401,
      );

      //arrange
      when(() => mockRepo.login("email", "password")).thenAnswer(
        (_) async => ApiResult.failure(
          ErrorHandler(
            apiErrorModel: ApiErrorModel(
              message: failLoginResponse.message,
              code: failLoginResponse.code,
            ),
          ),
        ),
      );

      //act
      final result = await mockUsecase.call("email", "password");

      //assert
      result.when(
        success: (data) {
          fail("Test failed: expected failure, but got success.");
        },
        failure: (errorHandler) {
          expect(errorHandler.apiErrorModel.message, failLoginResponse.message);
          expect(errorHandler.apiErrorModel.code, failLoginResponse.code);
        },
      );
    },
  );
}
