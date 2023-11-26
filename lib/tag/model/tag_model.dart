import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

@JsonSerializable()
class TagModel {
  final int id;
  final String name;

  TagModel({
    required this.id,
    required this.name,
  });

  TagModel copyWith({
    int? id,
    String? name,
  }) {
    return TagModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() => _$TagModelToJson(this);

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);
}
