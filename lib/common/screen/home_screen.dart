import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/common/layout/default_layout.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: Center(
        child: GestureDetector(
          onTap: () {
            context.go('/profile/edit');
          },
          child: SizedBox(
            width: 100,
            height: 100,
            child: const Text('Home Screen'),
          ),
        ),
      ),
    );
  }
}
