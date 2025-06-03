import 'package:clean_arch_riverpod/featues/splash/data/splash_data_providers.dart';
import 'package:clean_arch_riverpod/featues/splash/domain/use_case/check_user_connection_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashUseCaseProvider = FutureProvider<CheckUserConnectionUseCase>((
  ref,
) async {
  final repository = await ref.read(splashRepositoryProvider.future);
  return CheckUserConnectionUseCase(repository);
});
