import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String get routerName => '/splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash Screen'),
      ),
      body: Center(
        child: Text(
          'Splash Screen',
        ),
      ),
    );
  }
}
