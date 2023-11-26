import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linku/common/component/custom_outlined_button.dart';
import 'package:linku/common/const/color.dart';
import 'package:linku/common/layout/default_card_layout.dart';
import 'package:linku/common/style/default_text_style.dart';
import 'package:linku/common/utils/utils.dart';
import 'package:linku/history/model/history_model.dart';
import 'package:linku/tag/model/tag_model.dart';
import 'package:linku/user/model/user_model.dart';

class HistoryView extends StatelessWidget {
  final int id;
  final UserModel host;
  final String title;
  final DateTime historyTime;
  final TagModel tag;
  const HistoryView({
    super.key,
    required this.id,
    required this.host,
    required this.title,
    required this.historyTime,
    required this.tag,
  });

  factory HistoryView.fromModel(HistoryModel model) {
    return HistoryView(
      id: model.id,
      host: model.host,
      title: model.title,
      historyTime: model.meetTime,
      tag: model.tag,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultCardLayout(
      borderColor: PRIMARY_COLOR,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: defaultTextStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 18.sp,
                ),
                SizedBox(width: 5.w),
                Text(
                  host.name,
                  style: defaultTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Text(
              Utils.fromUTCtoKRYYYYMMDDHHMMSS(historyTime),
              style: defaultTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            CustomOutlinedButton(
              text: '#${tag.name}',
              onPressed: () {},
              isSelected: true,
            ),
          ],
        ),
      ),
    );
  }
}
