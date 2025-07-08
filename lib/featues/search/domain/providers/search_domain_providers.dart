import 'package:clean_arch_riverpod/featues/search/data/providers/search_data_provider.dart';
import 'package:clean_arch_riverpod/featues/search/domain/useCases/search_doctor_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchUseCasesProvider = FutureProvider<SearchDoctorUseCase>((ref) async {
  final searchRepository = await ref.read(searchRepositoryProvider.future);
  return SearchDoctorUseCase(searchRepository);
});
