import 'dart:async';
import 'package:consumable_replacement_notification/pages/home_page.dart';
import 'package:consumable_replacement_notification/pages/welcom_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    Timer(
      const Duration(milliseconds: 1500),
      () {
        //print(result);
        result == null
            ? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
                (route) => false)
            : Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(
        // TODO Add Brand Icon
        child: SizedBox(
          height: 100,
          width: 100,
          child: Placeholder(),
        ),
      ),
    );
  }
}
