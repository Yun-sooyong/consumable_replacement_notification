// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    required this.title,
    required this.explane,
    required this.classifi,
    required this.date,
    required this.period,
  });

  String title;
  String explane;
  int classifi;
  DateTime date;
  String period;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        explane: json["explane"],
        classifi: json["classifi"],
        date: DateTime.parse(json["date"]),
        period: json["period"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "explane": explane,
        "classifi": classifi,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "period": period,
      };
}
