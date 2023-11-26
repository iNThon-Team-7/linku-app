import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linku/common/const/color.dart';
import 'package:linku/common/style/default_text_style.dart';
import 'package:linku/tag/model/tag_model.dart';

class SelectableTagView extends StatelessWidget {
  final int id;
  final String name;
  final bool isSelected;
  final VoidCallback? onTap;
  const SelectableTagView({
    super.key,
    required this.id,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  factory SelectableTagView.fromModel(
    TagModel model,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return SelectableTagView(
      id: model.id,
      name: model.name,
      isSelected: isSelected,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150.w,
        width: 150.w,
        padding: EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 6.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: isSelected ? PRIMARY_COLOR : Colors.grey,
        ),
        child: Center(
          child: Text(
            name,
            style: defaultTextStyle.copyWith(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
