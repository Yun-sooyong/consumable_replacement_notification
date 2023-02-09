import 'package:flutter/material.dart';

dynamic addSheet(BuildContext context, double height) {
  Size size = MediaQuery.of(context).size;
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: height,
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('분류'),
              const SizedBox(
                height: 50,
                child: Placeholder(),
              ),
              const Text('이름'),
              const TextField(),
              const Text('설명'),
              const TextField(),
              const Text('날짜 선택'),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(size.width),
                ),
                child: Text('날짜 선택'),
              ),
              const Text('알람 주기'),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(size.width),
                ),
                child: Text('날짜 선택'),
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(size.width * 0.42),
                    ),
                    onPressed: () {},
                    child: Text('취소'),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(size.width * 0.42),
                    ),
                    onPressed: () {},
                    child: Text('저장'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

void cancel() {}

Text _text(String string) {
  return Text(
    string,
    style: const TextStyle(
      fontSize: 18.0,
    ),
  );
}
