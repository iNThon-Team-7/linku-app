import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linku/common/const/color.dart';
import 'package:linku/common/style/default_text_style.dart';
import 'package:linku/tag/model/tag_model.dart';

class TagView extends StatelessWidget {
  final int id;
  final String name;
  const TagView({
    super.key,
    required this.id,
    required this.name,
  });

  factory TagView.fromModel(TagModel model) {
    return TagView(
      id: model.id,
      name: model.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.w,
      width: 150.w,
      padding: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 6.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: PRIMARY_COLOR,
      ),
      child: Center(
        child: Text(
          name,
          style: defaultTextStyle.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
