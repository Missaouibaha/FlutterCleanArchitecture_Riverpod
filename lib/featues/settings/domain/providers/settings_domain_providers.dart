import 'package:clean_arch_riverpod/featues/settings/data/providers/settings_data_providers.dart';
import 'package:clean_arch_riverpod/featues/settings/domain/usecases/settings_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingUseCaseProvider = FutureProvider<SettingsUsecase>((ref) async {
  final settingRepository = await ref.read(settingRepositoryProvider.future);
  return SettingsUsecase(settingRepository);
});
