import 'package:consumable_replacement_notification/firebase/auth/google_auth.dart';
import 'package:consumable_replacement_notification/pages/welcom_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    GoogleFirebaseAuth googleFirebaseAuth = GoogleFirebaseAuth();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                // alter 사용해서 로그아웃 확인 or 앱 종료
              },
            ),
            centerTitle: true,
            title: const Text('logo'),
            elevation: 0.0,
            backgroundColor: Theme.of(context).colorScheme.background,
            bottom: TabBar(
              labelColor: Theme.of(context).colorScheme.tertiary,
              indicatorColor: Theme.of(context).colorScheme.tertiary,
              tabs: const [
                Tab(text: '전체'),
                Tab(text: '소모품'),
                Tab(text: '기념일'),
                Tab(text: '정비'),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            onPressed: () {
              googleFirebaseAuth.signoutWithGoogle().then(
                    (value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomePage(),
                      ),
                      (route) => false,
                    ),
                  );
            },
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TabBarView(
              children: [
                ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const Text('Item');
                    }),
                ListView(),
                ListView(),
                ListView(),
              ],
            ),
          )),
    );
  }
}
