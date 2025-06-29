import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_helper.dart';
import 'package:clean_arch_riverpod/core/networking/api_service.dart';
import 'package:clean_arch_riverpod/core/services/hive_service.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/local/register_local_datasource.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/register_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/register/domain/repository/register_repository.dart';
import 'package:clean_arch_riverpod/featues/register/domain/usecases/register_usecase.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/login_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/login_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/repository/login_repository.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/usecases/login_use_case.dart';
import 'package:clean_arch_riverpod/featues/splash/data/data_sources/local/splash_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/splash/domain/repository/splash_repository.dart';
import 'package:clean_arch_riverpod/featues/splash/domain/use_case/check_user_connection_use_case.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

// global
class MockSharedPreferencesHelper extends Mock
    implements SharedPreferencesHelper {}

class MockNavigatorObservor extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

class MockApiService extends Mock implements ApiService {}

class MockHiveService extends Mock implements HiveService {}

//splash
class MockSplashUseCase extends Mock implements CheckUserConnectionUseCase {}

class SplashMockLocalDataSource extends Mock implements SplashLocalDataSource {}

class MockSplashRepository extends Mock implements SplashRepository {}

//register
class MockRegisterRemote extends Mock implements RegisterRemoteDataSource {}

class MockRegisterLocalDataSource extends Mock implements RegisterLocalDatasource {}

class MockRegisterRepository extends Mock implements RegisterRepository {}

class MockRegisterUseCase extends Mock implements RegisterUsecase {}

//login

class MockLoginRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockLoginLocalDataSource extends Mock implements LoginLocalDataSource {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockLoginRepository extends Mock implements LoginRepository {}
