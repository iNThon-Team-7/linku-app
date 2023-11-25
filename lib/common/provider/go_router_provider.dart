import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/common/screen/home_screen.dart';
import 'package:linku/common/screen/splash_screen.dart';
import 'package:linku/user/provider/auth_provider.dart';
import 'package:linku/user/screeen/edit_profile_screen.dart';
import 'package:linku/user/screeen/login_screen.dart';
import 'package:linku/user/screeen/pending_screen.dart';
import 'package:linku/user/screeen/propose_screen.dart';
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
      //for test
      // redirect: provider.redirectAuthLogic,
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/pending',
          builder: (context, state) => PendingScreen(),
        ),
        GoRoute(
          path: '/edit_profile',
          builder: (context, state) => EditProfileScreen(),
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
