import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';

extension UserDataMapper on UserLocal {
  User toDomain() {
    return User(token: token ?? '', name: name ?? '');
  }
}
