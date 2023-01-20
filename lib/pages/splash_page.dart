import 'dart:async';
import 'package:consumable_replacement_notification/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';

/// 스플래시 스크린을 하나 만들던지 홈페이지에 화면을 덮어 씌우고 시간이 지나면 보이도록 하던지 선택
///
///
///

class SplahPage extends StatefulWidget {
  const SplahPage({super.key});

  @override
  State<SplahPage> createState() => _SplahPageState();
}

class _SplahPageState extends State<SplahPage> {
  @override
  void initState() {
    super.initState();
    User? result = FirebaseAuth.instance.currentUser;
    Timer(const Duration(milliseconds: 1500), () {
      print(result);
      result == null
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false)
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        child: Center(
          child: Text('Splash Attack'),
        ),
      ),
    );
    // return WillPopScope(
    //   onWillPop: () async => false,
    //   child: Scaffold(
    //     backgroundColor: Colors.amber[200],
    //     body: const Center(
    //       child: Text(
    //         'SPLASH SCREEN',
    //         style: TextStyle(fontSize: 30),
    //       ),
    //     ),
    //   ),
    // );
  }
}
