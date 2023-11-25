import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final fcm = ref.watch(fcmTokenProvider);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:EdgeInsets.all(10),
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
            // add email text field
            // add input filed
            Container(
              padding: EdgeInsets.all(10),
              child:
                Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: '이메일을 입력해주세요',
                        labelText: '이메일',
                      ),
                    ),
                    // add password text field
                    TextField(
                      controller: passwordController,
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
                  final email = emailController.text;
                  final password = passwordController.text;
                  // todo: generating auth model

                  //send auth to server

                  // route to home screen  -> for test
                  context.push('/home');
                },
                padding: EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),color: Color(0xffff6666),),
                  height: 54,
                    child: Center(child: Text('로그인',style: TextStyle(color: Colors.white),)),),
              ),
            ),
            // add register button
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              child: MaterialButton(
                onPressed: () {
                  //route to register screen
                  context.push('/register');

                },
                padding: EdgeInsets.all(0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),color: Color(0xffff6666),),
                    height: 54,
                    child: Center(child: Text('회원가입',style: TextStyle(color: Colors.white),)),),
              ),
            ),
          ],
        ),
      ),);
  }
}
