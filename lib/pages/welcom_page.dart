//Image by <a href="https://www.freepik.com/free-vector/flat-design-colorful-characters-welcoming_5403010.htm#page=2&query=welcome&position=28&from_view=search&track=sph">Freepik</a>

import 'package:consumable_replacement_notification/firebase/auth/google_auth.dart';
import 'package:consumable_replacement_notification/pages/home_page.dart';
import 'package:consumable_replacement_notification/pages/login_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.5,
              width: size.width,
              color: Colors.orange,
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            // 시작하기 => 로그인 페이지
            SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.05,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade200),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    side:
                        MaterialStateProperty.all<BorderSide>(BorderSide.none)),
                child: const Text('시작하기'),
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            //구글로 로그인 => 구글 로그인
            SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.05,
              child: OutlinedButton(
                onPressed: () {
                  GoogleFirebaseAuth()
                      .signinWithGoogle()
                      .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          ));
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.black,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(width: 0.1, color: Colors.black87)),
                ),
                child: const Text('구글로 로그인'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
