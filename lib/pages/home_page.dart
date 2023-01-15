import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container();
          },
        ),
      ),
    );
  }
}
