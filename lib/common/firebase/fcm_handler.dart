import 'package:dio/dio.dart' hide Headers;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/common/const/data.dart';
import 'package:linku/common/provider/dio.dart';
import 'package:linku/common/provider/go_router_provider.dart';
import 'package:linku/common/provider/pending_provider.dart';

final fcmTokenProvider =
    StateNotifierProvider<FcmTokenStateNotifier, String>((ref) {
  final dio = ref.watch(dioProvider);
  return FcmTokenStateNotifier(
    dio,
  );
});

class FcmTokenStateNotifier extends StateNotifier<String> {
  final Dio dio;
  FcmTokenStateNotifier(
    this.dio,
  ) : super('') {
    getToken();
  }

  Future<void> getToken() async {
    final messaging = FirebaseMessaging.instance;
    final token = await messaging.getToken();
    state = token!;
  }

  Future<void> deleteToken() async {
    final messaging = FirebaseMessaging.instance;
    await messaging.deleteToken();
    state = '';
  }

  Future<void> updateToken(String token) async {
    state = token;
    uploadToken();
  }

  Future<void> uploadToken() async {
    final token = state;
    await dio.post(
      '$ip/auth/fcm',
      data: {
        'fcmToken': token,
      },
      options: Options(
        headers: {
          'accessToken': 'true',
        },
      ),
    );
  }
}

Future requestPermissionIOS(FirebaseMessaging fbMsg) async {
  await fbMsg.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

Future<void> fcmTokenRefreshHandler(
  String token,
  FcmTokenStateNotifier notifier,
) async {
  print('Handling a token refresh $token');
  notifier.updateToken(token);
}

@pragma('vm:entry-point')
Future<void> fcmMessageHandler(
  RemoteMessage message,
  ProviderContainer container,
) async {
  await Firebase.initializeApp();
  print('Handling a message ${message.messageId}, ${message.data['title']}');
  fcmActionHandler(
    context: rootNavigatorKey.currentContext!,
    container: container,
  );
}

@pragma('vm:entry-point')
fcmOnOpenedAppHandler({
  required RemoteMessage message,
  required ProviderContainer container,
}) async {
  print('message opened by : ${message.messageId}, ${message.data}');
  if (message.data['type'] == 'certificate') {
    container.read(pendingProvider.notifier).update((state) => true);
  }
  fcmActionHandler(
    context: rootNavigatorKey.currentContext!,
    container: container,
  );
}

fcmActionHandler({
  required BuildContext context,
  required ProviderContainer container,
}) async {}

final launchedByFCMProvider = StateProvider<RemoteMessage?>((ref) => null);
