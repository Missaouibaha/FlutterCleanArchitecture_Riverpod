import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_response.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:clean_arch_riverpod/featues/signin/data/repository/login_repository_implementation.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/repository/login_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';

void main() {
  final fakeLoginResponse = LoginResponse(
    code: 1,
    message: "fake Login Response",
    status: true,
    userData: UserData(name: "Fake", token: "token"),
  );
  late MockLoginRemoteDataSource mockRemoteDataSource;
  late MockLoginLocalDataSource mockLocalDataSource;

  late LoginRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(UserLocal(name: "Fake", token: "token"));
  });
  setUp(() {
    mockLocalDataSource = MockLoginLocalDataSource();
    mockRemoteDataSource = MockLoginRemoteDataSource();
    mockRepo = LoginRepositoryImplementation(
      mockLocalDataSource,
      mockRemoteDataSource,
    );
  });

  test(
    'should user login success and return User after remote login and local cache ....',
    () async {
      when(
        () => mockRemoteDataSource.login("email", "password"),
      ).thenAnswer((_) async => ApiResult.success(fakeLoginResponse));
      when(() => mockLocalDataSource.cacheUser(any())).thenAnswer((_) async {});

      // Act
      final result = await mockRepo.login("email", "password");

      // Assert

      result.when(
        success: (user) {
          expect(user, isA<User>());
          expect(user.name, "Fake");
        },
        failure: (errorHandler) {},
      );

      verify(() => mockRemoteDataSource.login("email", "password")).called(1);
      verify(() => mockLocalDataSource.cacheUser(any())).called(1);
    },
  );

  test("should fail ", () async {
    final failLoginResponse = LoginResponse(
      message: "Credentials doesn`t match our records",
      userData: null,
      status: false,
      code: 401,
    );
    //arrange
    when(() => mockRemoteDataSource.login("email", "password")).thenAnswer((
      _,
    ) async {
      return ApiResult.failure(
        ErrorHandler(
          apiErrorModel: ApiErrorModel(
            message: failLoginResponse.message,
            code: failLoginResponse.code,
          ),
        ),
      );
    });
    //act
    final result = await mockRepo.login("email", "password");

    //assert
    result.when(
      success: (data) {
        fail("Expected failure but got success");
      },
      failure: (errorHandler) {
        expect(errorHandler.apiErrorModel.message, failLoginResponse.message);
        expect(errorHandler.apiErrorModel.code, failLoginResponse.code);
      },
    );
  });

  test("should throw an Exception (eg : INTERNAL_SERVER_ERROR...)", () async {
    when(() => mockRemoteDataSource.login("email", "password")).thenThrow(
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
    final result = await mockRepo.login("email", "password");

    //assert

    result.when(
      success: (data) {
        fail("Test failed: expected failure, but got success.");
      },
      failure: (errorHandler) {
        expect(
          errorHandler.apiErrorModel.message,
          ResponseMessage.INTERNAL_SERVER_ERROR,
        );
        expect(
          errorHandler.apiErrorModel.code,
          ResponseCode.INTERNAL_SERVER_ERROR,
        );
      },
    );
  });
}
