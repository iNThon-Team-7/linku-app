import 'package:json_annotation/json_annotation.dart';
import 'package:linku/meet/model/meet_model.dart';
import 'package:linku/tag/model/tag_model.dart';
import 'package:linku/user/model/user_model.dart';

part 'meet_detail_model.g.dart';

@JsonSerializable()
class MeetDetailModel extends MeetModel {
  final String body;
  final int maxParticipants;
  final bool isOnline;
  final String location;
  final int? minAge;
  final int? maxAge;
  final Gender? gender;
  final DateTime createdAt;
  final List<UserModel> participants;

  MeetDetailModel({
    required int id,
    required UserModel host,
    required String title,
    required DateTime meetTime,
    required TagModel tag,
    required this.body,
    required this.maxParticipants,
    required this.isOnline,
    required this.location,
    required this.minAge,
    required this.maxAge,
    required this.gender,
    required this.createdAt,
    required this.participants,
  }) : super(
          id: id,
          host: host,
          title: title,
          meetTime: meetTime,
          tag: tag,
        );

  factory MeetDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MeetDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MeetDetailModelToJson(this);
}
