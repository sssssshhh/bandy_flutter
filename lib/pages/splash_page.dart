import 'dart:math';

import 'package:bandy_flutter/pages/lectures/main_navigation.dart';
import 'package:bandy_flutter/pages/on_boarding/on_boarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

/// # 스플래시
class SplashPage extends StatefulWidget {
  static const routeName = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final stopWatch = Stopwatch();
      stopWatch.start();

      // 여러가지 초기화에 필요한 작업들 수행

      stopWatch.stop();

      debugPrint("splash elapsed: ${stopWatch.elapsed}");

      // 최대 1초 동안 표시되도록 함
      final int splashTime = 1000 - min(stopWatch.elapsed.inMilliseconds, 1000);
      await Future.delayed(Duration(milliseconds: splashTime));

      FlutterNativeSplash.remove();

      if (!mounted) return;
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(context, MainNavigation.routeName, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, Onboarding.routeName, (route) => false);
      }
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE55B), Color(0xFFF2BC40), Color(0xFFFFA63F)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
