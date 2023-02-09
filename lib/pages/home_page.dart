import 'package:consumable_replacement_notification/firebase/auth/google_auth.dart';
import 'package:consumable_replacement_notification/firebase/firestore/firestore.dart';
import 'package:consumable_replacement_notification/pages/welcom_page.dart';
import 'package:consumable_replacement_notification/pages/widgets/add_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> tabList = const [
    Tab(text: '전체'),
    Tab(text: '소모품'),
    Tab(text: '기념일'),
  ];

  late FireStoreDB fireStore;
  late User? userInfo;
  GoogleFirebaseAuth googleFirebaseAuth = GoogleFirebaseAuth();

  @override
  void initState() {
    userInfo = FirebaseAuth.instance.currentUser;
    fireStore = FireStoreDB(userInfo!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              // TODO Drawer 로 수정 필요
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
          ),
          centerTitle: true,
          title: const Text('logo'),
          elevation: 0.0,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.secondary,
            indicatorColor: Theme.of(context).colorScheme.secondary,
            tabs: tabList,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            addSheet(context, size.height * 0.8);
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(padding: const EdgeInsets.all(14.0), child: _body()),
      ),
    );
  }

  // _body
  Widget _body() {
    return StreamBuilder(
      stream: fireStore.read(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          final value = snapshot.data?.docs;
          return TabBarView(
            children: [
              ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return _viewCard(Text(value[index]['title']));
                  }),
              ListView(),
              ListView(),
            ],
          );
        }
      },
    );
  }

  Widget _viewCard(Text text) {
    return Card(
      shadowColor: Theme.of(context).colorScheme.shadow,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      color: Theme.of(context).colorScheme.surface,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: ListTile(
        title: text,
      ),
    );
  }

  // Widget _appBar() {
  //   return Widget();
  // }
}
