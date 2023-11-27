import 'package:json_annotation/json_annotation.dart';
import 'package:linku/tag/model/tag_model.dart';
import 'package:linku/user/model/user_model.dart';

part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel {
  final int id;
  final UserModel host;
  final String title;
  final DateTime meetTime;
  final TagModel tag;

  HistoryModel({
    required this.id,
    required this.host,
    required this.title,
    required this.meetTime,
    required this.tag,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
