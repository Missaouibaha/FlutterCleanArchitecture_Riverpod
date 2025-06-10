import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';

extension UserDataMapper on UserData {
  UserLocal toLocal() {
    return UserLocal(name: name ?? '', token: token ?? '');
  }

  User toDomain() {
    return User(name: name ?? '', token: token ?? '');
  }
}
