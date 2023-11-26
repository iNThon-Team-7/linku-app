import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/common/component/custom_button.dart';
import 'package:linku/common/component/custom_dialog.dart';
import 'package:linku/common/component/custom_outlined_button.dart';
import 'package:linku/common/const/data.dart';
import 'package:linku/common/firebase/fcm_handler.dart';
import 'package:linku/common/model/custom_button_model.dart';
import 'package:linku/common/model/custom_dialog_model.dart';
import 'package:linku/common/provider/storage.dart';
import 'package:linku/common/style/default_text_style.dart';
import 'package:linku/user/model/user_model.dart';
import 'package:linku/user/provider/user_provider.dart';
import 'package:skeletons/skeletons.dart';

class IconTitleFunctionModel {
  final IconData iconData;
  final String title;
  final Function onTap;

  IconTitleFunctionModel({
    required this.iconData,
    required this.title,
    required this.onTap,
  });
}

class ProfileScreen extends ConsumerWidget {
  static String get routerName => '/profile';
  const ProfileScreen({super.key});

  ImageProvider<Object> getCharacterAvatar(String url) {
    final image = Image.network(
      url,
      errorBuilder: (context, object, trace) {
        print('errorBuilder triggered');
        return Image(
          image: NetworkImage(defaultProfile),
        );
      },
    ).image;
    return image;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.watch(userProvider);
    if (userModel == null || userModel is UserModelLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    final user = userModel
        as UserModel; //must be UserModel since GoRouter redirect logic will kick if not logged in

    final List<IconTitleFunctionModel> settingList = [
      // IconTitleFunctionModel(
      //   iconData: JariBeanIconPack.notice,
      //   title: '알림',
      //   onTap: () {
      //     context.push('/profile/alert');
      //   },
      // ),
      IconTitleFunctionModel(
        iconData: Icons.logout,
        title: '로그아웃',
        onTap: showCustomDialog(
          context: context,
          model: CustomDialogWithTwoButtonsModel(
            title: '로그아웃',
            description: '로그아웃 할까요?',
            customButtonModelSecond: CustomButtonModel(
              title: '로그아웃',
              onPressed: () async {
                ref.read(userProvider.notifier).logout();
              },
            ),
            customButtonModel: CustomButtonModel(
              title: '취소',
              isDismiss: true,
            ),
          ),
        ),
      ),
      if (kDebugMode)
        IconTitleFunctionModel(
          iconData: Icons.token_outlined,
          title: 'Get Access Token',
          onTap: () async {
            print(
              await ref.read(storageProvider).read(key: accessTokenKey),
            );
          },
        ),
      if (kDebugMode)
        IconTitleFunctionModel(
          iconData: Icons.token_outlined,
          title: 'Get Fcm Token',
          onTap: () {
            Clipboard.setData(
              ClipboardData(text: ref.read(fcmTokenProvider)),
            );
          },
        ),
    ];
    //copy footerList contents into infoList
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 64.w,
                    height: 64.w,
                    child: Stack(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: 64.w,
                            height: 64.w,
                            borderRadius: BorderRadius.circular(32.w),
                          ),
                        ),
                        CircleAvatar(
                          radius: 32.w,
                          backgroundImage: getCharacterAvatar(
                            '$ip/user/${user.id}/image',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: defaultTextStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        user.intro ?? '자기소개가 없습니다.',
                        style: defaultTextStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 30.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 70.w,
                    child: CustomOutlinedButton(
                      text: user.tags![index].name,
                      onPressed: () {},
                      isSelected: true,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 6.0.w);
                },
                itemCount: user.tags!.length,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomButton(
                text: '프로필 수정',
                onPressed: () {
                  context.push('/profile/edit');
                },
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomButton(
                text: '태그 수정',
                onPressed: () {
                  context.push('/tag');
                },
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              height: 10.h,
              color: Color(0xFFF5F5F5),
            ),
            SizedBox(
              height: 12.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _settingItemBuilder(
                iconData: settingList[index].iconData,
                title: settingList[index].title,
                onTap: settingList[index].onTap,
              ),
              itemCount: settingList.length,
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              height: 10.h,
              color: Color(0xFFF5F5F5),
            ),
            SizedBox(
              height: 12.h,
            ),
          ],
        ),
      ],
    );
  }

  Widget _settingItemBuilder({
    required IconData iconData,
    required String title,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  color: Colors.black,
                  iconData,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  title,
                  style: defaultTextStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 12.w,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
            ),
          ],
        ),
      ),
    );
  }
}
