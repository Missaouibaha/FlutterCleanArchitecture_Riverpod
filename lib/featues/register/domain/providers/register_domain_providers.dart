import 'package:clean_arch_riverpod/featues/register/data/providers/register_data_providers.dart';
import 'package:clean_arch_riverpod/featues/register/domain/usecases/register_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerUseCasesProvider = FutureProvider<RegisterUsecase>((ref) async {
  final registerRepository = await ref.read(registerRepositoryProvider.future);

  return RegisterUsecase(registerRepository);
});
