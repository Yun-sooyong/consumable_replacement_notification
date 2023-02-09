import 'dart:convert';

/// 분류, 이름, 설명, 교체 주기, 교체 날짜
/// 분류 : 소모품, 기념일, 정비로 나뉘고 사용자에게는 보이지 않음 > 탭을 나누기 위해 추가
/// 이름 : 교체할 소모품이나 기념일 이름
/// 설명 : 교체에 필요한 부품이나 도구 등을 적어놓음
/// 교체 주기 : 등록시 설정한 교체 주기
/// 교체 날짜 : 교체하기로 지정한 날짜
///

class Item {
  String title;
  String explane;
  int classifi;
  String replaceDate;
  String periods;
  Item({
    required this.title,
    required this.explane,
    required this.classifi,
    required this.replaceDate,
    required this.periods,
  });

  Item copyWith({
    String? title,
    String? explane,
    int? classifi,
    String? replaceDate,
    String? periods,
  }) {
    return Item(
      title: title ?? this.title,
      explane: explane ?? this.explane,
      classifi: classifi ?? this.classifi,
      replaceDate: replaceDate ?? this.replaceDate,
      periods: periods ?? this.periods,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'explane': explane,
      'classifi': classifi,
      'replaceDate': replaceDate,
      'periods': periods,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      title: map['title'] ?? '',
      explane: map['explane'] ?? '',
      classifi: map['classifi']?.toInt() ?? 0,
      replaceDate: map['replaceDate'] ?? '',
      periods: map['periods'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(title: $title, explane: $explane, classifi: $classifi, replaceDate: $replaceDate, periods: $periods)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.title == title &&
        other.explane == explane &&
        other.classifi == classifi &&
        other.replaceDate == replaceDate &&
        other.periods == periods;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        explane.hashCode ^
        classifi.hashCode ^
        replaceDate.hashCode ^
        periods.hashCode;
  }
}
