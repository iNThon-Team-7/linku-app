import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/user/model/login_model.dart';
import 'package:linku/user/model/user_model.dart';
import 'package:linku/user/provider/user_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen(
      userProvider,
      ((previous, next) {
        if (previous != next) {
          notifyListeners();
        }
      }),
    );
  }

  Future<void> login({
    required LoginModel loginModel,
  }) async {
    ref.read(userProvider.notifier).login(
          loginModel: loginModel,
        );
  }

  Future<void> logout() async {
    ref.read(userProvider.notifier).logout();
  }

  Future<void> register({
    required LoginModel loginModel,
  }) async {
    ref.read(userProvider.notifier).register(
          loginModel: loginModel,
        );
  }

  bool checkPending() {
    final user = ref.read(userProvider);
    if (user is! UserModel) {
      return false;
    }
    if (user.role == UserRole.pending) {
      return true;
    }
    return false;
  }

  FutureOr<String?> redirectAuthLogic(_, GoRouterState state) async {
    final user = ref.read(userProvider);

    final isLogginIn = state.location == '/login';
    final isSplashScreen = state.location == '/splash';
    final isRegistering = state.location == '/register';
    final isPending = state.location == '/pending';

    if (checkPending()) {
      return '/pending';
    }

    if (user == null) {
      if (isRegistering) {
        return '/register';
      }
      return '/login';
    }

    if (user is UserModel) {
      if (isSplashScreen || isLogginIn || isRegistering || isPending) {
        return '/home';
      }
    }

    if (user is UserModelError) {
      if (isRegistering) {
        return '/register';
      }
      return '/login';
    }
    return null;
  }
}

final isInitProvider = StateProvider((ref) => true);
