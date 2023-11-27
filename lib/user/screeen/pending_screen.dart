import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/common/component/custom_button.dart';
import 'package:linku/common/layout/default_layout.dart';
import 'package:linku/common/provider/pending_provider.dart';
import 'package:linku/user/provider/user_provider.dart';

class PendingScreen extends ConsumerWidget {
  const PendingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = ref.watch(pendingProvider);
    return DefaultLayout(
      title: '메일 인증 대기 중',
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text(
              '메일 인증을 기다리고 있습니다.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              text: '매일 인증 완료',
              onPressed: () {
                ref.read(userProvider.notifier).getMe();
              },
              isDisabled: !pending,
            ),
          ],
        ),
      ),
    );
  }
}
