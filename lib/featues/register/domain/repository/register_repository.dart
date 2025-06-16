import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';

abstract class RegisterRepository {
  Future<ApiResult<User>> register(
    String name,
    String email,
    String phone,
    int gender,
    String password,
  );
}
