import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:linku/common/exception/custom_exception_handler.dart';
import 'package:linku/firebase_options.dart';

import 'common/firebase/fcm_handler.dart';
import 'common/provider/go_router_provider.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print(
      "Provider ${provider.name ?? provider.runtimeType} updated from $previousValue to $newValue",
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(observers: [Logger()]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.onTokenRefresh.listen(
    (token) => fcmTokenRefreshHandler(
      token,
      container.read(fcmTokenProvider.notifier),
    ),
  );

  container.read(fcmTokenProvider);

  FirebaseMessaging.onMessage
      .listen((message) => fcmMessageHandler(message, container));

  FirebaseMessaging.onBackgroundMessage(
    (message) => fcmMessageHandler(message, container),
  );

  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) => fcmOnOpenedAppHandler(
      message: message,
      container: container,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.grey[50],
    ),
  );

  // final originalOnError = FlutterError.onError;
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // originalOnError?.call(details);
    CustomExceptionHandler.hanldeException(details.exception);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    if (!kDebugMode) {}
    CustomExceptionHandler.hanldeException(error);
    return true;
  };

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size.height > 700
          ? const Size(375, 812)
          : MediaQuery.of(context).size.height > 550
              ? const Size(375, 667)
              : const Size(375, 500),
      scaleByHeight: MediaQuery.of(context).size.width > 450,
      builder: (context, child) => MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: child!,
        ),
      ),
    );
  }
}
