import 'package:clean_arch_riverpod/featues/home/domain/repository/home_repository.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';

class UserDataUseCase {
  final HomeRepository _homeRepository;
  UserDataUseCase(this._homeRepository);

  Future<User?> call() async {
    return await _homeRepository.getUser();
  }
}
