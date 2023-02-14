import 'package:consumable_replacement_notification/firebase/auth/google_auth.dart';
import 'package:consumable_replacement_notification/firebase/firestore/firestore.dart';
import 'package:consumable_replacement_notification/models/item_model.dart';
import 'package:consumable_replacement_notification/pages/add_item_page.dart';
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
  List<Classify> classify = [];
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

    classify.add(Classify('소모품', false));
    classify.add(Classify('기념일', false));

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
            //_addItemSheet(size);
            showStatefulWidgetBottomSheet(context);
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

  Future _addItemSheet(Size size) {
    // TODO 분류를 어떻게 나눌 건가, 날짜 선택을 위한 패키지 선정, 선택된 날짜와 알림 주기를 계산해서 토스트로 출력하고 결과값은 item에 저장해서 list에 표시,
    Item item;
    final TextEditingController titleController = TextEditingController();
    final TextEditingController explaneController = TextEditingController();

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter bottomState) {
            return Container(
              height: size.height * 0.8,
              color: Theme.of(context).colorScheme.background,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('분류'),
                    _customRadio(bottomState),
                    const Text('이름'),
                    TextField(
                      controller: titleController,
                      onEditingComplete: () {},
                    ),
                    const Text('설명'),
                    TextField(
                      controller: explaneController,
                    ),
                    const Text('날짜 선택'),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromWidth(size.width),
                      ),
                      child: const Text('날짜 선택'),
                    ),
                    const Text('알람 주기'),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromWidth(size.width),
                      ),
                      child: const Text('날짜 선택'),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size.fromWidth(size.width * 0.42),
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('취소'),
                          ),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size.fromWidth(size.width * 0.42),
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                            ),
                            onPressed: titleController.text == '' ||
                                    explaneController.text == ''
                                ? null
                                : () {
                                    //item = Item(title: titleController.text, explane: explaneController.text);
                                  },
                            child: const Text('저장'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget _customRadio(StateSetter bottomState) {
    return SizedBox(
      height: 40,
      width: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: classify.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              bottomState(
                () {
                  setState(() {
                    for (var element in classify) {
                      element.isSelected = false;
                    }
                    classify[index].isSelected = true;
                  });
                },
              );
            },
            child: CustomRadio(classify[index]),
          );
        },
      ),
    );
  }

  // Widget _appBar() {
  //   return Widget();
  // }
}
