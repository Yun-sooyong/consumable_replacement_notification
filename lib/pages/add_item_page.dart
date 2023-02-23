import 'dart:convert';

import 'package:consumable_replacement_notification/firebase/firestore/firestore.dart';
import 'package:consumable_replacement_notification/models/item_model.dart';
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
  int classifi = 0;
  DateTime? date;
  String periods = ' 년 개월 주';
  DateTime? periodsTime;

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
                  initialLabelIndex: classifi,
                  totalSwitches: 2,
                  labels: const ['소모품', '기념일'],
                  radiusStyle: true,
                  onToggle: (index) {
                    // TODO 함수로 정리해서 깔끔하게 해볼것!
                    setState(() {
                      classifi = index!;
                      if (classifi == 1) {
                        periods = '1년';
                      } else {
                        periods = ' 년 개월 주';
                      }
                    });
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
                Text(periods.toString()),
                TextButton(
                  onPressed: classifi == 1
                      ? null
                      : () {
                          showPickerArray(context);
                        },
                  child: const Text('선택 하기'),
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
                    onPressed: title == null ||
                            explane == null ||
                            date == null ||
                            periods == ' 년 개월 주'
                        ? null
                        : () {
                            // TODO 저장
                            Item item = Item(
                              title: title!,
                              explane: explane!,
                              classifi: classifi,
                              date: date!,
                              period: periods,
                            );

                            FireStoreUsage().write(item);

                            Navigator.pop(context);
                          },
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

  //TODO 글자수 제한 50자 + sheet에서 글자수가 크기를 넘어가면 ...으로 표시
  dynamic showDialogForTextField(int value, TextEditingController controller) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: value == 0
              ? Text(
                  '${classifi == 0 ? '소모품' : '기념일'} 이름을 입력하세요',
                  style: const TextStyle(fontSize: 19),
                )
              : const Text(
                  '내용을 입력하세요',
                  style: TextStyle(fontSize: 19),
                ),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () {
                controller.clear();
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
        // adapter 를 DateTimePickerAdapter 교체하고 커스텀 ??
        adapter: PickerDataAdapter<String>(
          pickerData: const JsonDecoder().convert(pickerData),
          isArray: true,
        ),
        hideHeader: true,
        backgroundColor: theme.background,
        height: 230,
        itemExtent: 50,
        textScaleFactor: 1.1,
        title: const Text("교체할 주기를 선택해주세요"),
        selectedTextStyle: TextStyle(color: theme.primary),
        //containerColor: Colors.amber,
        cancelText: '취소',
        confirmText: '선택',
        onConfirm: (Picker picker, List value) {
          setState(() {
            periods =
                '${value[0].toString() == '0' ? '' : '${value[0].toString()}년'} ${value[1].toString() == '0' ? '' : '${value[1].toString()}개월'} ${value[2].toString() == '0' ? '' : '${value[2].toString()}주'}';
          });
          // TODO 계산을 위해 year / month / week 로 따로 저장할 수도 있음
        }).showDialog(context);
  }

  showPickerDate(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    int currentYear = int.parse(DateFormat('yyyy').format(DateTime.now()));

    Picker(
      hideHeader: true,
      adapter: DateTimePickerAdapter(
        //type: 7,
        customColumnType: [1, 2],
        months: MonthsList_KO,
        yearBegin: currentYear,
        yearEnd: currentYear,
        monthSuffix: '월',
        daySuffix: '일',
      ),
      height: 230,
      itemExtent: 50,
      textScaleFactor: 1.1,
      title: const Text("날짜를 지정해주세요"),
      backgroundColor: theme.background,
      selectedTextStyle: TextStyle(color: theme.primary),
      onConfirm: (Picker picker, List value) {
        setState(() {
          date = (picker.adapter as DateTimePickerAdapter).value;
        });
      },
      cancelText: '취소',
      confirmText: '확인',
    ).showDialog(context);
  }
}
