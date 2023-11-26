import 'package:json_annotation/json_annotation.dart';
import 'package:linku/tag/model/tag_model.dart';

part 'user_model.g.dart';

enum UserRole {
  @JsonValue('PENDING')
  pending,
  @JsonValue('USER')
  user,
}

enum Gender {
  @JsonValue('M')
  M,
  @JsonValue('F')
  F,
}

abstract class UserModelBase {}

class UserModelLoading extends UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

@JsonSerializable()
class UserModel extends UserModelBase {
  final int id;
  final String name;
  final String intro;
  final String? email;
  final UserRole? role;
  final int? age;
  final Gender? gender;
  final List<TagModel>? tags;

  UserModel({
    required this.id,
    required this.name,
    required this.intro,
    this.email,
    this.role,
    this.age,
    this.gender,
    this.tags,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
