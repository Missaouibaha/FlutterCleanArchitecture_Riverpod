import 'package:clean_arch_riverpod/core/networking/api_constants.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/home_response.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/models/profile_response.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_request_body.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_response.dart';
import 'package:clean_arch_riverpod/featues/search/data/data_sources/models/doctors_response.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_request_body.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);

  @POST(ApiConstants.register)
  Future<RegisterResponse> register(
    @Body() RegisterRequestBody registerRequestBody,
  );

  @GET(ApiConstants.home)
  Future<HomeResponse?> getHomeData(@Header("Authorization") String token);

  @GET(ApiConstants.doctor)
  Future<DoctorsResponse> getDoctors(@Header("Authorization") String token);

  
  @GET(ApiConstants.profile)
  Future<ProfileResponse> getProfile(@Header("Authorization") String token);
}
