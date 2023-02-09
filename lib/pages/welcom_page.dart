//Image by <a href="https://www.freepik.com/free-vector/flat-design-colorful-characters-welcoming_5403010.htm#page=2&query=welcome&position=28&from_view=search&track=sph">Freepik</a>

import 'package:consumable_replacement_notification/firebase/auth/google_auth.dart';
import 'package:consumable_replacement_notification/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageViewController = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.5,
              width: size.width,
              child: PageView(
                // TODO : 이후 수정 필요 [PageView]
                controller: _pageViewController,
                children: [
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.green,
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
              child: SmoothPageIndicator(
                controller: _pageViewController,
                count: 3,
                effect: const WormEffect(
                  dotHeight: 10.0,
                  dotWidth: 10.0,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),

            //구글로 로그인 => 구글 로그인
            SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.05,
              child: OutlinedButton(
                onPressed: () async {
                  await GoogleFirebaseAuth().signinWithGoogle().then(
                        (value) => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        ),
                      );
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
