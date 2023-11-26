import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/common/const/color.dart';
import 'package:linku/common/layout/default_layout.dart';

class RootScreen extends StatelessWidget {
  final Widget child;
  const RootScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
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
              context.go('/history');
              break;
            case 2:
              context.go('/alert');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
        currentIndex: () {
          final location = GoRouterState.of(context).location;
          if (location.startsWith('/home')) return 0;
          if (location.startsWith('/history')) return 1;
          if (location.startsWith('/alert')) return 2;
          if (location.startsWith('/profile')) return 3;
          return 0;
        }(),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '나의 예약',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '알림',
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
