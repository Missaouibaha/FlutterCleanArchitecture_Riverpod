import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/home_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  final String? message;
  final bool? status;
  final int? code;
  @JsonKey(name: 'data')
  final List<HomeData> homeData;

  HomeResponse(this.message, this.code, this.status, this.homeData);

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
}
