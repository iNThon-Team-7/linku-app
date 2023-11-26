import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/common/screen/home_screen.dart';
import 'package:linku/common/screen/root_screen.dart';
import 'package:linku/common/screen/splash_screen.dart';
import 'package:linku/tag/screen/tag_edit_screen.dart';
import 'package:linku/user/provider/auth_provider.dart';
import 'package:linku/user/screeen/edit_profile_screen.dart';
import 'package:linku/user/screeen/login_screen.dart';
import 'package:linku/user/screeen/pending_screen.dart';
import 'package:linku/user/screeen/propose_screen.dart';
import 'package:linku/user/screeen/profile_screen.dart';
import 'package:linku/user/screeen/register_screen.dart';
import 'package:linku/user/screeen/search_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final provider = ref.read(authProvider);
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/home',
      debugLogDiagnostics: true,
      refreshListenable: provider,
      redirect: provider.redirectAuthLogic,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => RootScreen(child: HomeScreen()),
          routes: [
            GoRoute(
              path: 'splash',
              builder: (context, state) => SplashScreen(),
            ),
            GoRoute(
              path: 'login',
              builder: (context, state) => LoginScreen(),
            ),
            GoRoute(
              path: 'register',
              builder: (context, state) => RegisterScreen(),
            ),
            GoRoute(
              path: 'pending',
              builder: (context, state) => PendingScreen(),
            ),
            GoRoute(
              path: 'home',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: RootScreen(child: HomeScreen())),
            ),
            GoRoute(
              path: 'profile',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: RootScreen(child: ProfileScreen())),
              routes: [
                GoRoute(
                  path: 'edit',
                  builder: (context, state) => EditProfileScreen(),
                ),
              ],
            ),
            GoRoute(
              path: 'tag',
              builder: (context, state) => TagEditScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/propose',
          builder: (context, state) => ProposeScreen(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => SearchScreen(),
        ),
      ],
    );
  },
);
