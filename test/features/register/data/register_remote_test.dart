import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_request_body.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_response.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/register_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/register_remote_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helper/test_utils.dart';


void main() {
  late MockApiService mockApiService;
  late RegisterRemoteDataSource registerRemoteDataSource;
  final registerRequestBody = RegisterRequestBody(
    "name",
    "email",
    "phone",
    "password",
    "password",
    1,
  );
  final userData = UserData(name: "name", token: "token");
  final RegisterResponse fakeRegisterResponse = RegisterResponse(
    "message",
    true,
    200,
    userData,
  );
  setUp(() {
    mockApiService = MockApiService();
    registerRemoteDataSource = RegisterRemoteDataSourceImpl(
      apiService: mockApiService,
    );
  });

  test('should return register response', () async {
    //arrange
    when(
      () => mockApiService.register(registerRequestBody),
    ).thenAnswer((_) async => fakeRegisterResponse);

    //act
    final result = await registerRemoteDataSource.register(registerRequestBody);

    //assert
    expect(result, isA<Success<RegisterResponse?>>());
    final success = result as Success<RegisterResponse?>;
    expect(success.data, fakeRegisterResponse);
  });

  test(
    "should return a failed response wrapped in api result ( fail Credentials doesn`t match our records)",
    () async {
      final failRegisterResponse = RegisterResponse(
        "fail Credentials doesn`t match our records",
        false,
        401,
        null,
      );

      when(
        () => mockApiService.register(registerRequestBody),
      ).thenAnswer((_) async => failRegisterResponse);

      final result = await registerRemoteDataSource.register(
        registerRequestBody,
      );

      expect(result, isA<Success<RegisterResponse?>>());
      final failure = result as Success<RegisterResponse?>;
      expect(failure.data, failRegisterResponse);
      expect(failure.data?.message, failRegisterResponse.message);
    },
  );

  test("should fail  (eg : INTERNAL_SERVER_ERROR...) ", () async {
    when(() => mockApiService.register(registerRequestBody)).thenThrow(
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

    final result = await registerRemoteDataSource.register(registerRequestBody);

    expect(result, isA<Failure<RegisterResponse?>>());
    final error = result as Failure<RegisterResponse?>;
    expect(
      error.errorHandler.apiErrorModel.message,
      ResponseMessage.INTERNAL_SERVER_ERROR,
    );
    expect(
      error.errorHandler.apiErrorModel.code,
      ResponseCode.INTERNAL_SERVER_ERROR,
    );
  });
}
