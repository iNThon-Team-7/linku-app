import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linku/user/provider/auth_provider.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                        height: 124.h,
                        child: Center(child: Text('회원가입',style: TextStyle(fontSize: 30),))),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 280.h,
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
                          TextField(
                            controller: passwordController2,
                            decoration: InputDecoration(
                              helperText: '비밀번호는 8자 이상이어야 합니다',
                              labelText: '비밀번호 확인',
                              hintText: '비밀번호를 입력해주세요',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              child: MaterialButton(
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  final password2 = passwordController.text;

                  //validation
                  if (email=="" || password=="" || password2=="") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('데이터가 비었습니다'),
                        ),
                      );
                      return;
                    }
                  if (password != password2) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('비밀번호가 다릅니다'),
                      ),
                    );
                    return;
                  }
                  //todo: send auth to server


                  //route to profile editting screen

                  context.go('/edit_profile');

                },
                padding: EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),color: Color(0xffff6666),),
                  height: 54,
                  child: Center(child: Text('다음',style: TextStyle(color: Colors.white),)),),
              ),
            ),
          ],
        ),
      ),);
  }
}