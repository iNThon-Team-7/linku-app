import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linku/common/component/custom_button.dart';
import 'package:linku/common/component/custom_text_form_field.dart';
import 'package:linku/user/model/login_model.dart';
import 'package:linku/user/model/user_model.dart';
import 'package:linku/user/provider/auth_provider.dart';
import 'package:linku/user/provider/user_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: SizedBox(
                    width: 124.h,
                    height: 124.h,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '이메일',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomTextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    hintText: '이메일을 입력해주세요',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '비밀번호',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomTextFormField(
                    onChanged: (value) => {
                      password = value,
                    },
                    hintText: '비밀번호를 입력해주세요',
                    isPassword: true,
                  ),
                ],
              ),
            ),
            if (kDebugMode)
              CustomButton(
                text: 'Force Login',
                onPressed: () {
                  ref.read(userProvider.notifier).loginInstatnt();
                  ref.read(userProvider.notifier).setUser(
                        UserModel(
                          id: 1,
                          name: '123',
                          intro: '123',
                        ),
                      );
                },
              ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              child: MaterialButton(
                onPressed: () {
                  ref.read(authProvider.notifier).login(
                        loginModel: LoginModel(
                          email: email,
                          password: password,
                        ),
                      );
                },
                padding: EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffff6666),
                  ),
                  height: 54,
                  child: Center(
                    child: Text(
                      '로그인',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              child: MaterialButton(
                onPressed: () {
                  context.push('/register');
                },
                padding: EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffff6666),
                  ),
                  height: 54,
                  child: Center(
                    child: Text(
                      '회원가입 하기',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
