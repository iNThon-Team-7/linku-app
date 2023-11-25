import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum UserRole {
  @JsonValue('PENDING')
  pending,
  @JsonValue('USER')
  user,
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
  final String email;
  final UserRole role;

  UserModel({
    required this.id,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
