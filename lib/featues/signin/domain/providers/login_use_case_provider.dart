import 'package:clean_arch_riverpod/featues/signin/data/providers/login_data_provider.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/usecases/login_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginUseCaseProvider = FutureProvider<LoginUseCase>((ref) async {
  final loginRepository = await ref.read(loginRepositoryProvider.future);
  return LoginUseCase(loginRepository);
});
