import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

  Future<void> login() async {}

  Future<void> logout() async {}

  bool checkRegistered() {
    return true;
  }

  Future<bool> deleteAccount({required String type}) async {
    return true;
  }

  FutureOr<String?> redirectAuthLogic(_, GoRouterState state) async {
    return '/login';
    // return null;
  }

  FutureOr<String?> redirectRegisterLogic(_, GoRouterState state) async {
    return null;
  }
}

final isInitProvider = StateProvider((ref) => true);
