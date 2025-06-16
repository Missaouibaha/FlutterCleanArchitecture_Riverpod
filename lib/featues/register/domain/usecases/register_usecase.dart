import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/register/domain/repository/register_repository.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';

class RegisterUsecase {
  final RegisterRepository registerRepository;
  RegisterUsecase(this.registerRepository);

  Future<ApiResult<User>> call(
    String name,
    String email,
    String phone,
    int gender,
    String password,
  ) async {
    return await registerRepository.register(
      name,
      email,
      phone,
      gender,
      password,
    );
  }
}
