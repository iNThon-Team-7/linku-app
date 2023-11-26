import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/common/const/color.dart';
import 'package:linku/common/layout/default_layout.dart';
import 'package:linku/user/screeen/profile_screen.dart';
import 'package:linku/user/screeen/propose_screen.dart';

class RootScreen extends StatelessWidget {
  final Widget child;
  const RootScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: child is ProfileScreen
          ? '내 정보'
          : child is ProposeScreen
              ? '링쿠하기'
              : '링쿠',
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        // type: BottomNavigationBarType.shifting,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/propose');
              break;
            case 2:
              context.go('/history');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
        currentIndex: () {
          final location = GoRouterState.of(context).location;
          if (location.startsWith('/home')) return 0;
          if (location.startsWith('/propose')) return 1;
          if (location.startsWith('/history')) return 2;
          if (location.startsWith('/profile')) return 3;
          return 0;
        }(),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.link),
            label: '링쿠하기',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '기록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '내 정보',
          ),
        ],
      ),
      child: child,
    );
  }
}
