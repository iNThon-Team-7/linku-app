import 'package:json_annotation/json_annotation.dart';
import 'package:linku/user/model/user_model.dart';

part 'meet_proposal_mode.g.dart';

@JsonSerializable()
class MeetProposalModel {
  final String title;
  final String body;
  final int tagId;
  final int maxParticipants;
  @JsonKey(toJson: dateTimeToJson)
  final DateTime meetTime;
  final bool isOnline;
  final String location;
  final Gender? gender;
  final int minAge;
  final int maxAge;

  MeetProposalModel({
    required this.title,
    required this.body,
    required this.tagId,
    required this.maxParticipants,
    required this.meetTime,
    required this.isOnline,
    required this.location,
    this.gender,
    required this.minAge,
    required this.maxAge,
  });

  copyWith({
    String? title,
    String? body,
    int? tagId,
    int? maxParticipants,
    DateTime? meetTime,
    bool? isOnline,
    Gender? gender,
    String? location,
    int? minAge,
    int? maxAge,
  }) {
    return MeetProposalModel(
      title: title ?? this.title,
      body: body ?? this.body,
      tagId: tagId ?? this.tagId,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      meetTime: meetTime ?? this.meetTime,
      gender: gender ?? this.gender,
      isOnline: isOnline ?? this.isOnline,
      location: location ?? this.location,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
    );
  }

  static String dateTimeToJson(DateTime dateTime) =>
      dateTime.toUtc().toIso8601String();

  Map<String, dynamic> toJson() => _$MeetProposalModelToJson(this);
}
