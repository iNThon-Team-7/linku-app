import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/common/component/custom_button.dart';
import 'package:linku/common/component/custom_text_form_field.dart';
import 'package:linku/common/const/data.dart';
import 'package:linku/common/layout/default_layout.dart';
import 'package:linku/user/model/user_model.dart';
import 'package:linku/user/provider/update_profile_provider.dart';
import 'package:linku/user/provider/user_provider.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.watch(userProvider);
    if (userModel is! UserModel) {
      return const Center(child: CircularProgressIndicator());
    }
    final user = userModel
    final bool isAgeSetted = user.age != null;
    final bool isGenderSetted = user.gender != null;
    final updateProfile = ref.watch(updateProfileProvider);
    return DefaultLayout(
      title: '프로필 수정',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: () async {
                  ref.read(updateProfileProvider.notifier).updateImgFile();
                },
                child: _profileImageEditWidget(
                  image: updateProfile.imgFile == null
                      ? NetworkImage('$ip/user/${user.id}/image')
                      : Image.memory(updateProfile.imgFile!.files.first.bytes!)
                          .image,
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              '닉네임',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomTextFormField(
              onChanged: (text) {
                ref.read(updateProfileProvider.notifier).updateName(
                      text,
                    );
              },
              hintText: user.name,
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              '자기소개',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomTextFormField(
              maxLines: 4,
              onChanged: (text) {
                ref.read(updateProfileProvider.notifier).updateIntro(
                      text,
                    );
              },
              hintText: user.intro,
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              '성별',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            if (user.gender != null)
              SizedBox(
                width: 160.w,
                child: CustomButton(
                  text: user.gender == Gender.M ? '남성' : '여성',
                  onPressed: () {},
                  isDismiss: false,
                ),
              ),
            if (user.gender == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 160.w,
                    child: CustomButton(
                      text: '남성',
                      onPressed: () {
                        ref
                            .read(updateProfileProvider.notifier)
                            .updateGender(Gender.M);
                      },
                      isDismiss: updateProfile.gender == null
                          ? true
                          : updateProfile.gender == Gender.F,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  SizedBox(
                    width: 160.w,
                    child: CustomButton(
                      text: '여성',
                      onPressed: () {
                        ref
                            .read(updateProfileProvider.notifier)
                            .updateGender(Gender.F);
                      },
                      isDismiss: updateProfile.gender == null
                          ? true
                          : updateProfile.gender == Gender.M,
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              '나이',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
              onTap: () {
                if (user.age != null) return;
                Timer? debounce;
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Align(
                      alignment: Alignment(0, 1),
                      child: Container(
                        height: 200.h,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: CupertinoPicker(
                          itemExtent: 40,
                          onSelectedItemChanged: (value) {
                            if (debounce?.isActive ?? false) debounce?.cancel();
                            debounce = Timer(
                              Duration(milliseconds: 500),
                              () {
                                ref
                                    .read(updateProfileProvider.notifier)
                                    .updateAge(value + 1);
                              },
                            );
                          },
                          children: List.generate(100, (index) => index + 1)
                              .map((e) => Text('$e'))
                              .toList(),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    '${updateProfile.age ?? user.age ?? '?'}세',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomButton(
              text: '프로필 적용',
              onPressed: () async {
                if ((isAgeSetted || updateProfile.age != null) &&
                    (isGenderSetted || updateProfile.gender != null)) {
                  context.pop();
                  await ref.read(updateProfileProvider.notifier).upload(
                        callback: () => ref.read(userProvider.notifier).getMe(),
                      );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Stack _profileImageEditWidget({
    required ImageProvider image,
  }) {
    return Stack(
      children: [
        SizedBox(
          width: 80.w,
          height: 80.w,
          child: CircleAvatar(backgroundImage: image),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 25.w,
            height: 25.w,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: OvalBorder(),
              shadows: const [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 2,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Icon(
              Icons.edit,
              size: 16.sp,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}