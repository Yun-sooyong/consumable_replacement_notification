import 'package:consumable_replacement_notification/firebase/auth/google_auth.dart';
import 'package:consumable_replacement_notification/pages/welcom_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    //required List actions
  });

  @override
  Widget build(BuildContext context) {
    GoogleFirebaseAuth googleFirebaseAuth = GoogleFirebaseAuth();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          googleFirebaseAuth.signoutWithGoogle().then((value) =>
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                  (route) => false));
        },
        child: const Icon(Icons.add),
      ),
      // IconButton(
      //   onPressed: () {
      //     googleFirebaseAuth.signoutWithGoogle().then((value) =>
      //         Navigator.pushAndRemoveUntil(
      //             context,
      //             MaterialPageRoute(builder: (context) => const WelcomePage()),
      //             (route) => false));
      //   },
      //   icon: const Icon(Icons.add),
      // ),
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
