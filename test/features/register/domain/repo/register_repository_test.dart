import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/local/register_local_datasource.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_request_body.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_response.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/register_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/register/data/repository/register_repository_implementation.dart';
import 'package:clean_arch_riverpod/featues/register/domain/repository/register_repository.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/mappers/user_data_mapper.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';


void main() {
  late MockRegisterLocalDataSource mockLocalData;
  late MockRegisterRemote mockRemoteData;
  late RegisterRepository registerRepository;
  final fakeRegiserResponse = RegisterResponse(
    "",
    true,
    200,
    UserData(name: "name", token: "token"),
  );

  setUp(() {
    mockRemoteData = MockRegisterRemote();
    mockLocalData = MockRegisterLocalDataSource();
    registerRepository = RegisterRepositoryImplementation(
      mockLocalData,
      mockRemoteData,
    );
  });
  setUpAll(() {
    registerFallbackValue(
      RegisterRequestBody(
        "name",
        "email",
        "22222222",
        "password",
        "password",
        1,
      ),
    );
    registerFallbackValue(fakeRegiserResponse.userData!.toLocal());
  });
  test("Should user registration success", () async {
    when(
      () => mockRemoteData.register(any()),
    ).thenAnswer((_) async => ApiResult.success(fakeRegiserResponse));
    when(() => mockLocalData.cacheUser(any())).thenAnswer((_) async {});

    final result = await registerRepository.register(
      "name",
      "email",
      "22222222222",
      0,
      "password",
    );
    //assert
    result.when(
      success: (data) {
        expect(data.name, fakeRegiserResponse.userData?.name);

        expect(data.token, fakeRegiserResponse.userData?.token);
      },

      failure: (errorHandler) {
        fail("Test failed: expected success, but got failure.");
      },
    );

    verify(() => mockLocalData.cacheUser(any())).called(1);
    verify(() => mockRemoteData.register(any())).called(greaterThan(0));
  });

  test("Should user registration fail...", () async {
    final failedRegisterResponse = RegisterResponse(
      "user already exists",
      false,
      401,
      null,
    );
    when(() => mockRemoteData.register(any())).thenAnswer(
      (_) async => ApiResult.failure(
        ErrorHandler(
          apiErrorModel: ApiErrorModel(
            message: failedRegisterResponse.message,
            code: failedRegisterResponse.code,
          ),
        ),
      ),
    );

    //act
    final result = await registerRepository.register(
      "name",
      "email",
      "22222222",
      1,
      "password",
    );

    // assert
    result.when(
      success: (data) {
        fail("Test failed: expected failure, but got success.");
      },
      failure: (errorHandler) {
        expect(
          errorHandler.apiErrorModel.message,
          failedRegisterResponse.message,
        );
        expect(errorHandler.apiErrorModel.code, failedRegisterResponse.code);
      },
    );
  });

  test("Should user registration fail... ", () async {
    when(() => mockRemoteData.register(any())).thenThrow(
      DioException(
        type: DioExceptionType.badResponse,
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: ResponseCode.INTERNAL_SERVER_ERROR,
          statusMessage: ResponseMessage.INTERNAL_SERVER_ERROR,
          data: {
            'code': ResponseCode.INTERNAL_SERVER_ERROR,
            'message': ResponseMessage.INTERNAL_SERVER_ERROR,
          },
        ),
      ),
    );

    //act
    final result = await registerRepository.register(
      "name",
      "email",
      "22222222",
      1,
      "password",
    );

    // assert
    result.when(
      success: (data) {
        fail('Test failed: expected failure, but got success.');
      },
      failure: (errorHandler) {
        expect(
          errorHandler.apiErrorModel.code,
          ResponseCode.INTERNAL_SERVER_ERROR,
        );
        expect(
          errorHandler.apiErrorModel.message,
          ResponseMessage.INTERNAL_SERVER_ERROR,
        );
      },
    );
  });
}
