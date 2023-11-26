import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/common/const/color.dart';
import 'package:linku/common/const/data.dart';
import 'package:linku/common/provider/go_router_provider.dart';
import 'package:linku/common/style/default_text_style.dart';
import 'package:skeletons/skeletons.dart';

class DefaultCardLayout extends StatelessWidget {
  final String? imgUrl;
  final Widget child;
  final String? routerPath;
  final Function()? onTap;
  final bool isShadowVisible;
  final bool isDisabled;
  final Color borderColor;

  const DefaultCardLayout({
    Key? key,
    this.imgUrl,
    required this.child,
    this.routerPath,
    this.onTap,
    this.isShadowVisible = true,
    this.isDisabled = false,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final Function() onTap;
    if (routerPath == null) {
      onTap = this.onTap ?? () => {};
    } else {
      onTap = () => {context.push(routerPath!)};
    }
    return Center(
      child: GestureDetector(
        onTap: this.onTap ?? onTap,
        child: Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Container(
            padding: EdgeInsets.all(16.w),
            width: 335.w,
            foregroundDecoration: isDisabled
                ? BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    backgroundBlendMode: BlendMode.saturation,
                  )
                : null,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: borderColor),
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.white,
              shadows: [
                if (isShadowVisible)
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 10,
                    offset: Offset(3, 3),
                    spreadRadius: 0,
                  ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(imgUrl != null ? 8 : 20),
                  child: Image.network(
                    imgUrl ?? defaultProfile,
                    width: 84.w,
                    height: 84.w,
                    fit: BoxFit.cover,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      return Skeleton(
                        isLoading: frame == null,
                        skeleton: SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: 84.w,
                            height: 84.w,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: child,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildSkeleton() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SkeletonLine(
        style: SkeletonLineStyle(
          height: 16.h,
          width: 200.w,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      SizedBox(
        height: 8.h,
      ),
      SkeletonLine(
        style: SkeletonLineStyle(
          height: 16.h,
          width: 100.w,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      SizedBox(
        height: 12.h,
      ),
      SkeletonLine(
        style: SkeletonLineStyle(
          height: 24.h,
          width: 100.w,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );
}

Widget buildBasic() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '다가오는 예약이 없어요 :(',
        style: defaultTextStyle.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(
        height: 16.h,
      ),
      FilledButton(
        onPressed: () {
          rootNavigatorKey.currentContext!.push('/search');
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            PRIMARY_COLOR,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 6.h,
          ),
          child: Text(
            '예약하러 가기!',
            style: defaultTextStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ],
  );
}
