import 'package:consumable_replacement_notification/firebase/auth/google_auth.dart';
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
      floatingActionButton: IconButton(
        onPressed: () {
          googleFirebaseAuth.logoutWithGoogle();
        },
        icon: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: ListView.builder(
          itemCount: 1,
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
