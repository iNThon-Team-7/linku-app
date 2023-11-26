import 'package:json_annotation/json_annotation.dart';
import 'package:linku/tag/model/tag_model.dart';
import 'package:linku/user/model/user_model.dart';

part 'meet_model.g.dart';

@JsonSerializable()
class MeetModel {
  final int id;
  final UserModel host;
  final String title;
  final DateTime meetTime;
  final TagModel tag;

  MeetModel({
    required this.id,
    required this.host,
    required this.title,
    required this.meetTime,
    required this.tag,
  });

  factory MeetModel.fromJson(Map<String, dynamic> json) =>
      _$MeetModelFromJson(json);

  Map<String, dynamic> toJson() => _$MeetModelToJson(this);
}
