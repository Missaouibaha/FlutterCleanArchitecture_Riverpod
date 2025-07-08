import 'package:equatable/equatable.dart';

class SpecialityEntity extends Equatable {
  final int? id;
  final String? name;
  final String? spacilityIconUrl;
  bool? isSelected = false;
  SpecialityEntity(this.id, this.name, this.spacilityIconUrl, this.isSelected);

  @override
  List<Object?> get props => [id, name, spacilityIconUrl, isSelected];
}
