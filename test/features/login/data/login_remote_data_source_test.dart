import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/login_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/login_remote_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_request_body.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_response.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helper/test_utils.dart';

void main() {
  late MockApiService mockApi;
  late LoginRemoteDataSource remoteDataSource;
  final fakeLoginResponse = LoginResponse(
    code: 1,
    message: "fake Login Response",
    status: true,
    userData: UserData(name: "Fake", token: "fake token"),
  );
  setUp(() {
    mockApi = MockApiService();
    remoteDataSource = LoginRemoteDataSourceImpl(apiService: mockApi);
    registerFallbackValue(
      LoginRequestBody(email: 'email', password: 'password'),
    );
  });

  test('should return a LoginResponse wrapped in ApiResult', () async {
    //arrange
    when(() => mockApi.login(any())).thenAnswer((_) async => fakeLoginResponse);

    //act
    final response = await remoteDataSource.login("fakeemail", 'fakepassword');
    // assert
    expect(response, isA<Success<LoginResponse?>>());
    final success = response as Success<LoginResponse?>;
    expect(success.data, fakeLoginResponse);
    final code = success.data?.code;
    expect(code, fakeLoginResponse.code);
    final user = success.data?.userData;
    expect(user, fakeLoginResponse.userData);
  });

  test(
    "should return a failed login response wrappedin api result ( fail Credentials doesn`t match our records)",
    () async {
      final failLoginResponse = LoginResponse(
        message: "Credentials doesn`t match our records",
        userData: null,
        status: false,
        code: 401,
      );
      //arrange
      when(
        () => mockApi.login(any()),
      ).thenAnswer((_) async => failLoginResponse);
      //act
      final response = await remoteDataSource.login('email', 'password');
      //assert
      expect(response, isA<Success<LoginResponse?>>());
      final result = response as Success<LoginResponse?>;
      expect(result.data, failLoginResponse);
      final code = result.data?.code;
      expect(code, failLoginResponse.code);
      final message = result.data?.message;
      expect(message, failLoginResponse.message);
    },
  );

  test("should user login  fail (eg : INTERNAL_SERVER_ERROR...) ", () async {
    // Arrange: simulate a DioException with 500 INTERNAL_SERVER_ERROR

    when(() => mockApi.login(any())).thenThrow(
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
    final result = await remoteDataSource.login('email', 'password');

    //assert

    expect(result, isA<Failure<LoginResponse?>>());
    final failure = result as Failure<LoginResponse?>;
    final errorModel = failure.errorHandler.apiErrorModel;

    expect(errorModel.code, ResponseCode.INTERNAL_SERVER_ERROR);
    expect(errorModel.message, ResponseMessage.INTERNAL_SERVER_ERROR);
  });
}
