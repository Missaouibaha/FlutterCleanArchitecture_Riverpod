import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String? message;
  final int? code;
  @JsonKey(name: 'data')
  final Map<String, dynamic>? errors;
  ApiErrorModel({required this.message, this.code, this.errors});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      message: json['message'] as String?,
      code: json['code'] as int?,
      errors:
          (json['data'] is Map<String, dynamic>)
              ? json['data'] as Map<String, dynamic>
              : {},
    );
  }
  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  String getErrorMessage() {
    if (errors != null) {
      var firstError = errors?.values.first;
      if (firstError is List && firstError.isNotEmpty) {
        return firstError.first.toString();
      }
    }
    return message ?? AppStrings.unknownError;
  }
}
