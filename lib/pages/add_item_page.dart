import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

Future<dynamic> showStatefulWidgetBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
      context: context,
      builder: (_) {
        return const StatefulSheet();
      });
}

class StatefulSheet extends StatefulWidget {
  const StatefulSheet({super.key});

  @override
  State<StatefulSheet> createState() => _StatefulSheet();
}

class _StatefulSheet extends State<StatefulSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController explaneController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    explaneController.dispose();
    super.dispose();
  }

  String title = '';
  String explane = '';
  late int kinds;
  //late Date startDate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.55,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '분류',
                  style: textStyle(),
                ),
                ToggleSwitch(
                  minWidth: 80.0,
                  cornerRadius: 20.0,
                  activeBgColors: [
                    [Colors.amber[800]!],
                    [Colors.amber[800]!]
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: 1,
                  totalSwitches: 2,
                  labels: const ['소모품', '기념일'],
                  radiusStyle: true,
                  onToggle: (index) {
                    kinds = index!;
                    print('switched to: $kinds');
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '이름',
                  style: textStyle(),
                ),
                Text(
                  title,
                ),
                TextButton(
                  child: const Text('입력 하기'),
                  onPressed: () {
                    showDialogForTextField(0, titleController);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '설명',
                  style: textStyle(),
                ),
                Text(
                  explane,
                ),
                TextButton(
                  child: const Text('입력 하기'),
                  onPressed: () {
                    showDialogForTextField(1, explaneController);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '날짜 선택',
                  style: textStyle(),
                ),
                TextButton(
                  child: const Text('선택 하기'),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '반복 간격',
                  style: textStyle(),
                ),
                TextButton(
                  child: const Text('선택 하기'),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: size.width * 0.42,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '취소',
                      style: TextStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: size.width * 0.42,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('저장'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      fontSize: 16,
    );
  }

  dynamic showDialogForTextField(int value, TextEditingController controller) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: value == 0
              ? const Text(
                  '[소모품/기념일]이름을 입력하세요',
                  style: TextStyle(fontSize: 19),
                )
              : const Text(
                  '내용을 입력하세요',
                  style: TextStyle(fontSize: 19),
                ),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  value == 0
                      ? title = controller.text
                      : explane = controller.text;
                });
                //print(title);
                controller.clear();
                Navigator.pop(context);
              },
              child: const Text('완료'),
            )
          ],
        );
      },
    );
  }
}
