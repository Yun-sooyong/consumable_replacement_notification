import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';

import '../models/picker_data.dart';

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

  String? title;
  String? explane;
  int? classifi;
  DateTime? date;
  String? periods;

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
                    [Theme.of(context).colorScheme.primary],
                    [Theme.of(context).colorScheme.primary],
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Theme.of(context).colorScheme.background,
                  inactiveFgColor: Theme.of(context).unselectedWidgetColor,
                  initialLabelIndex: 1,
                  totalSwitches: 2,
                  labels: const ['소모품', '기념일'],
                  radiusStyle: true,
                  onToggle: (index) {
                    classifi = index!;
                    print('switched to: $classifi');
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
                  title == null ? '' : title!,
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
                  explane == null ? '' : explane!,
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
                Text(date == null
                    ? ''
                    : DateFormat('yyyy년 MM월 dd일').format(date!)),
                TextButton(
                  child: const Text('선택 하기'),
                  onPressed: () {
                    //showPickerArray(context);
                    showPickerDate(context);
                  },
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
                Text(periods == null ? '' : periods.toString()),
                TextButton(
                  child: const Text('선택 하기'),
                  onPressed: () {
                    showPickerArray(context);
                  },
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
                // TODO 전부 입력이 된게 확인이 되면 저장을 눌렀을때 firestore에 저장
                SizedBox(
                  height: 50,
                  width: size.width * 0.42,
                  child: ElevatedButton(
                    onPressed: title == null ||
                            explane == null ||
                            date == null ||
                            periods == null
                        ? null
                        : () {},
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

  showPickerArray(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    Picker(
        adapter: PickerDataAdapter<String>(
          pickerData: const JsonDecoder().convert(pickerData),
          isArray: true,
        ),
        hideHeader: true,
        backgroundColor: theme.background,
        height: 230,
        itemExtent: 50,
        textScaleFactor: 1.1,
        title: const Text("(교체/기념)할 날짜를 선택해주세요"),
        selectedTextStyle: TextStyle(color: theme.primary),
        containerColor: Colors.amber,
        cancelText: '취소',
        confirmText: '선택',
        onConfirm: (Picker picker, List value) {
          setState(() {
            periods = value.toString();
          });
          print(
              '${value[0].toString()}년 ${value[1].toString()}개월 ${(value[2]).toString()}주 마다');
        }).showDialog(context);
  }

  showPickerDate(BuildContext context) {
    Picker(
      hideHeader: true,
      adapter: DateTimePickerAdapter(),
      title: const Text("Select Data"),
      selectedTextStyle: const TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List value) {
        setState(() {
          date = (picker.adapter as DateTimePickerAdapter).value;
        });
        //print((picker.adapter as DateTimePickerAdapter).value);
      },
    ).showDialog(context);
  }
}
