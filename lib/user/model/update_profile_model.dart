import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:linku/user/model/user_model.dart';

class UpdateProfileModel {
  final String? name;
  final String? intro;
  final int? age;
  final Gender? gender;
  final FilePickerResult? imgFile;

  UpdateProfileModel({
    this.name,
    this.intro,
    this.age,
    this.gender,
    this.imgFile,
  });

  copyWith({
    String? name,
    String? intro,
    int? age,
    Gender? gender,
    FilePickerResult? imgFile,
  }) {
    return UpdateProfileModel(
      name: name ?? this.name,
      intro: intro ?? this.intro,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      imgFile: imgFile ?? this.imgFile,
    );
  }

  Map<String, dynamic> updateOthers() {
    // jsonify for only not null value
    final Map<String, dynamic> json = {};
    if (name != null) json['name'] = name;
    if (intro != null) json['intro'] = intro;
    if (age != null) json['age'] = age;
    if (gender != null) json['gender'] = gender!.toString().split('.').last;
    return json;
  }

  FormData updateImage() {
    final formData = FormData();
    if (imgFile != null) {
      final fileName = imgFile!.files.first.name;
      final String fileExtension = imgFile!.files.first
          .extension!; // assume that selected file must have extension
      final file = MultipartFile.fromBytes(
        imgFile!.files.first.bytes!,
        filename: fileName,
        contentType: MediaType('image', fileExtension),
      );
      formData.files.add(MapEntry('image', file));
    }
    return formData;
  }
}
