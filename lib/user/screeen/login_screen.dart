import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linku/user/model/login_model.dart';
import 'package:linku/user/provider/auth_provider.dart';


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
                children: [
                  TextField(
                    onChanged: (value) => {
                      email = value,
                    },
                    decoration: InputDecoration(
                      hintText: '이메일을 입력해주세요',
                      labelText: '이메일',
                    ),
                  ),
                  TextField(
                    onChanged: (value) => {
                      password = value,
                    },
                    decoration: InputDecoration(
                      helperText: '비밀번호는 8자 이상이어야 합니다',
                      labelText: '비밀번호',
                      hintText: '비밀번호를 입력해주세요',
                    ),
                  ),
                ],
              ),
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
