import 'package:clean_arch_riverpod/featues/home/data/providers/home_data_providers.dart';
import 'package:clean_arch_riverpod/featues/home/domain/use_cases/home_data_use_case.dart';
import 'package:clean_arch_riverpod/featues/home/domain/use_cases/user_data_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userUseCasesProvider = FutureProvider<UserDataUseCase>((ref) async {
  final homeRepository = await ref.read(homeRepositoryProvider.future);

  return UserDataUseCase(homeRepository);
});

final homeDataUseCasesProvider = FutureProvider<HomeDataUseCase>((ref) async {
  final homeRepository = await ref.read(homeRepositoryProvider.future);

  return HomeDataUseCase(homeRepository);
});
