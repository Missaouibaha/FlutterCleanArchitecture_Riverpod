import 'package:clean_arch_riverpod/featues/profile/data/providers/profile_data_providers.dart';
import 'package:clean_arch_riverpod/featues/profile/domain/useCases/get_profile_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileUseCase = FutureProvider<GetProfileUseCase>((ref) async {
  final repository = await ref.read(profileRepositoryProvider.future);
  return GetProfileUseCase(repository);
});
