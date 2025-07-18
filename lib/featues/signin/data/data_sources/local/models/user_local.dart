import 'package:hive_flutter/hive_flutter.dart';

part 'user_local.g.dart';
@HiveType(typeId: 0)
class UserLocal {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? token;

  UserLocal({this.name, this.token});
}
