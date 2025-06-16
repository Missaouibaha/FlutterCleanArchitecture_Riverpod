import 'package:clean_arch_riverpod/core/helper/enums/gender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gnederProvider = StateProvider<Gender>((ref) {
  return Gender.male;
});
