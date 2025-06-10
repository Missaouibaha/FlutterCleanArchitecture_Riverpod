import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';

abstract class LoginRepository {
  Future<ApiResult<User>> login(String email, String password);
}
