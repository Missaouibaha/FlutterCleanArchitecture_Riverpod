import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_response.dart';
import 'package:clean_arch_riverpod/featues/register/domain/repository/register_repository.dart';
import 'package:clean_arch_riverpod/featues/register/domain/usecases/register_usecase.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';


void main() {
  late MockRegisterRepository mockRepo;

  late RegisterUsecase registerUsecase;
  final fakeRegisterResponse = RegisterResponse(
    "message",
    true,
    200,
    UserData(token: "token", name: "name"),
  );
  setUp(() {
    mockRepo = MockRegisterRepository();
    registerUsecase = RegisterUsecase(mockRepo);
  });

  test("Should user registration success", () async {
    when(() => mockRepo.register(any(), any(), any(), any(), any())).thenAnswer(
      (_) async => ApiResult.success(
        User(
          name: fakeRegisterResponse.userData!.name!,
          token: fakeRegisterResponse.userData!.token!,
        ),
      ),
    );

    //act
    final result = await registerUsecase.call(
      "name",
      "email",
      "22222222",
      1,
      "password",
    );

    //assert
    result.when(
      success: (user) {
        expect(user.name, fakeRegisterResponse.userData?.name);
        expect(user.token, fakeRegisterResponse.userData?.token);
      },
      failure: (errorHandler) {
        fail("Test failed: expected success, but got failure.");
      },
    );
  });

  test("Should user registration fail  eg : user already exists", () async {
    final failedRegisterResponse = RegisterResponse(
      "user already exists",
      false,
      401,
      null,
    );
    when(() => mockRepo.register(any(), any(), any(), any(), any())).thenAnswer(
      (_) async => ApiResult.failure(
        ErrorHandler(
          apiErrorModel: ApiErrorModel(
            message: failedRegisterResponse.message,
            code: failedRegisterResponse.code,
          ),
        ),
      ),
    );

    // act
    final result = await registerUsecase.call(
      "name",
      "email",
      "5555555",
      1,
      "password",
    );

    //assert
    result.when(
      success: (data) {
        fail("Test failed: expected failure, but got success.");
      },
      failure: (errorHandler) {
        expect(errorHandler.apiErrorModel.code, failedRegisterResponse.code);
        expect(
          errorHandler.apiErrorModel.message,
          failedRegisterResponse.message,
        );
      },
    );
  });
}
