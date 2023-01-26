import 'package:consumable_replacement_notification/firebase/auth/google_auth.dart';
import 'package:consumable_replacement_notification/pages/welcom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
    //required List actions
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GoogleFirebaseAuth googleFirebaseAuth = GoogleFirebaseAuth();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          googleFirebaseAuth.signoutWithGoogle().then((value) =>
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                  (route) => false));
        },
        icon: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return const Center(
              child: Text('Home'),
            );
          },
        ),
      ),
    );
  }
}
