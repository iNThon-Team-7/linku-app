import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  final int? page;
  final int? size;

  PaginationParams({
    this.page = 0,
    this.size = 20,
  });

  PaginationParams copyWith({
    int? page,
    int? size,
  }) {
    return PaginationParams(
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);

  factory PaginationParams.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamsFromJson(json);
}
