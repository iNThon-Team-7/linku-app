import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/common/component/custom_button.dart';
import 'package:linku/common/component/custom_outlined_button.dart';
import 'package:linku/common/const/color.dart';
import 'package:linku/common/layout/default_layout.dart';
import 'package:linku/common/style/default_text_style.dart';
import 'package:linku/common/utils/utils.dart';
import 'package:linku/meet/model/meet_detail_model.dart';
import 'package:linku/meet/provider/meet_detail_provider.dart';

class MeetDetailScreen extends ConsumerWidget {
  final int id;
  const MeetDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meet = ref.watch(meetDetailProvider(id));
    if (meet is! MeetDetailModel) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    final pMeet = meet as MeetDetailModel;
    return DefaultLayout(
      title: pMeet.title,
      child: Container(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 32.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIconAndText(
              icon: Icons.person,
              textSpan: TextSpan(
                text: '${pMeet.host.name} 님의 모임',
                style: defaultTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                  color: TEXT_SUBTITLE_COLOR,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            _buildIconAndText(
              icon: Icons.location_on,
              textSpan: TextSpan(
                text: pMeet.location,
                style: defaultTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                  color: TEXT_SUBTITLE_COLOR,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            _buildIconAndText(
              icon: Icons.people,
              textSpan: TextSpan(
                text:
                    '${pMeet.participants.length}명 / ${pMeet.maxParticipants}명',
                style: defaultTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: TEXT_SUBTITLE_COLOR,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            _buildIconAndText(
              icon: Icons.calendar_today,
              textSpan: TextSpan(
                text: Utils.fromUTCtoKRYYYYMMDDHHMMSS(pMeet.meetTime),
                style: defaultTextStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: TEXT_SUBTITLE_COLOR,
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.tag,
                  size: 24.w,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8.w,
                ),
                CustomOutlinedButton(
                  text: pMeet.tag.name,
                  onPressed: () {},
                  isSelected: true,
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              pMeet.body,
              style: defaultTextStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
                overflow: TextOverflow.visible,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            CustomButton(
              text: '참여하기',
              onPressed: () {
                ref.read(meetDetailProvider(id).notifier).join();
                while(context.canPop()){
                  context.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconAndText({
    required IconData icon,
    required TextSpan textSpan,
  }) {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: Icon(
              icon,
              size: 24.w,
              color: Colors.black,
            ),
          ),
          WidgetSpan(
            child: SizedBox(
              width: 8.w,
            ),
          ),
          textSpan,
        ],
      ),
    );
  }
}
