


import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/repository/login_repository.dart';

class LoginUseCase {
final LoginRepository loginRepository ;
LoginUseCase(this.loginRepository);


Future<ApiResult<User>> call(String email , String password) async{
  return await loginRepository.login(email, password);
}

}