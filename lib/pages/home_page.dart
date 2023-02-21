import 'package:consumable_replacement_notification/firebase/auth/google_auth.dart';
import 'package:consumable_replacement_notification/firebase/firestore/firestore.dart';
import 'package:consumable_replacement_notification/pages/add_item_page.dart';
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
  List<Widget> tabList = const [
    Tab(text: '전체'),
    Tab(text: '소모품'),
    Tab(text: '기념일'),
  ];

  late FireStoreUsage _fireStore;
  GoogleFirebaseAuth googleFirebaseAuth = GoogleFirebaseAuth();

  @override
  void initState() {
    _fireStore = FireStoreUsage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: _appBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            showStatefulWidgetBottomSheet(context);
          },
          child: const Icon(Icons.add),
        ),
        body: _body(),
      ),
    );
  }

  //AppBar
  AppBar _appBar() {
    return AppBar(
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
      //backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      bottom: TabBar(
        labelColor: Theme.of(context).colorScheme.primary,
        indicatorColor: Theme.of(context).colorScheme.primary,
        tabs: tabList,
      ),
    );
  }

  // _body
  // TODO 필드의 classifi에 맞게 list를 만들어서 출력
  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: StreamBuilder(
        stream: _fireStore.read(),
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
                    return _viewCard(value: value[index]);
                  },
                ),
                ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    if (value[index]['classifi'] == 0) {
                      return _viewCard(value: value[index]);
                    }
                    return const SizedBox();
                  },
                ),
                ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    if (value[index]['classifi'] == 1) {
                      return _viewCard(value: value[index]);
                    }
                    return const SizedBox();
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // main view card
  Widget _viewCard({required var value}) {
    const List<String> list = ['수정', '삭제'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        borderOnForeground: true,
        shadowColor: Theme.of(context).colorScheme.shadow,
        color: Theme.of(context).colorScheme.surface,
        elevation: 7.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            title: Text(value['title']),
            subtitle: Text(value['explane']),
            trailing: DropdownButton<String>(
              icon: const Icon(Icons.more_vert),
              elevation: 4,
              underline: Container(height: 0),
              onChanged: (value) {
                setState(() {
                  if (value == '수정') {}
                  if (value == '삭제') {
                    FireStoreUsage().delete();
                  }
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
