// // ignore_for_file: no_leading_underscores_for_local_identifiers

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class CustomNotification {
//   static FlutterLocalNotificationsPlugin localNotification =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initLocalNotification() async {
//     AndroidInitializationSettings initSettingsAndroid =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//     DarwinInitializationSettings initSettingsIOS =
//         const DarwinInitializationSettings(
//       requestSoundPermission: false,
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//     );

//     InitializationSettings _initSettings = InitializationSettings(
//       android: initSettingsAndroid,
//       iOS: initSettingsIOS,
//     );

//     await localNotification.initialize(_initSettings);
//   }

//   final NotificationDetails _details = const NotificationDetails(
//     android: AndroidNotificationDetails('왈!', '짖어서 알려주는 개'),
//     iOS: DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     ),
//   );

//   tz.TZDateTime _timeZoneSetting(int periodDate, DateTime baseDate) {
//     tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
//     tz.TZDateTime _now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, _now.year, baseDate.month, baseDate.day);
//     if (scheduledDate.isBefore(_now)) {
//       scheduledDate = tz.TZDateTime(
//           tz.local, _now.year, baseDate.month + periodDate, baseDate.day);
//     }

//     return scheduledDate;
//   }

//   tz.TZDateTime _testTimeZoneSetting() {
//     tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
//     tz.TZDateTime _now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, _now.year, _now.month, _now.day, _now.second);
//     if (scheduledDate.isBefore(_now)) {
//       scheduledDate = scheduledDate.add(const Duration(seconds: 10));
//     }
//     return scheduledDate;
//   }

//   Future<void> testNotification({
//     required int id,
//     required String body,
//     //required int periodDate,
//     //required DateTime baseDate,
//   }) async {
//     await localNotification.zonedSchedule(
//       id,
//       '왈왈!',
//       body,
//       _testTimeZoneSetting(),
//       _details,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.wallClockTime,
//       androidAllowWhileIdle: true,
//       //matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
//       matchDateTimeComponents: DateTimeComponents.dateAndTime,
//     );
//   }

//   Future<void> selectedDateNotification({
//     required int id,
//     required String body,
//     required int periodDate,
//     required DateTime baseDate,
//   }) async {
//     FlutterLocalNotificationsPlugin _localNotification =
//         FlutterLocalNotificationsPlugin();

//     await _localNotification.zonedSchedule(
//       id,
//       '왈왈!',
//       body,
//       _timeZoneSetting(periodDate, baseDate),
//       _details,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//     );
//   }

//   Future<void> deleteNotification(id) async {
//     FlutterLocalNotificationsPlugin _localNotification =
//         FlutterLocalNotificationsPlugin();
//     await _localNotification.cancel(id);
//   }
// }


// // class LocalNotification {
// //   LocalNotification._();

// //   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();

// //   static initialize() async {
// //     AndroidInitializationSettings initailizationSettingsAndroid =
// //         const AndroidInitializationSettings('mipmap/ic_launcher');

// //     DarwinInitializationSettings initializationSettingsIOS =
// //         const DarwinInitializationSettings(
// //       requestAlertPermission: false,
// //       requestBadgePermission: false,
// //       requestSoundPermission: false,
// //     );

// //     InitializationSettings initializationSettings = InitializationSettings(
// //       android: initailizationSettingsAndroid,
// //       iOS: initializationSettingsIOS,
// //     );

// //     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// //   }

// //   static void requestPermission() {
// //     flutterLocalNotificationsPlugin
// //         .resolvePlatformSpecificImplementation<
// //             IOSFlutterLocalNotificationsPlugin>()
// //         ?.requestPermissions(
// //           alert: true,
// //           badge: true,
// //           sound: true,
// //         );
// //   }

// // // TODO 기간을 계산해서 호출
// //   static Future<void> sampleNotification({
// //     required String title,
// //     required int type,
// //   }) async {
// //     tz.initializeTimeZones();
// //     //tz.setLocalLocation(tz.getLocation('Korea'));

// //     const AndroidNotificationDetails androidPlatformChannelSpecifics =
// //         AndroidNotificationDetails(
// //       '대신알려주는 게', // 채널 id
// //       '게로부터의 알람', // 채널 이름
// //       //channelDescription: 'channel description',
// //       importance: Importance.max, // 중요도
// //       priority: Priority.max, // 우선순위
// //       ticker: '알람이 왔어요~', // 상태바에 표시될 텍스트
// //       showWhen: false,
// //     );
// //     const NotificationDetails platformChannelSpecifics = NotificationDetails(
// //         android: androidPlatformChannelSpecifics,
// //         iOS: DarwinNotificationDetails(
// //           badgeNumber: 1,
// //         ));
// //     await flutterLocalNotificationsPlugin.periodicallyShow(
// //       0,
// //       '대신 알려주는 게가 알려드립니다.', // 알람 제목
// //       '기념일 또는 소모품 교체 주기가 되었습니다.', // 알람 내용
// //       RepeatInterval.everyMinute, // 알람 반복 간격
// //       platformChannelSpecifics,
// //       androidAllowWhileIdle: true, // 안드로이드 배터리절약 모드에서도 알람 전송
// //       payload: 'alarm_payload', // 알람과 함께 전달할 데이터
// //     );
// //   }

// //   static Future<void> repeatNotification({
// //     required DateTime baseTime,
// //     required int repeatInterval,
// //   }) async {
// //     DateTime now = DateTime.now();
// //     var diff = baseTime.difference(now);
// //     int diffDays = diff.inDays;

// //     // 날짜가 이미 지났다면 현재 년 + 1
// //     if (diffDays < 0) {
// //       baseTime = DateTime(baseTime.year + 1, baseTime.month, baseTime.day);
// //       var nextDiff = baseTime.difference(now);
// //       diffDays = nextDiff.inDays;
// //     }

// //     const AndroidNotificationDetails androidPlatformChannelSpecifics =
// //         AndroidNotificationDetails(
// //       '대신알려주는 게', // 채널 id
// //       '게로부터의 알람', // 채널 이름
// //       //channelDescription: 'channel description',
// //       importance: Importance.max, // 중요도
// //       priority: Priority.max, // 우선순위
// //       ticker: '알람이 왔어요~', // 상태바에 표시될 텍스트
// //       showWhen: false,
// //     );
// //     const NotificationDetails platformChannelSpecifics = NotificationDetails(
// //       android: androidPlatformChannelSpecifics,
// //       iOS: DarwinNotificationDetails(
// //         badgeNumber: 1,
// //       ),
// //     );

// //     tz.TZDateTime getNextDate(DateTime baseTime, int repeatInterval) {
// //       var now = tz.TZDateTime.now(tz.local);
// //       var baseDateInLocalTimeZone =
// //           tz.TZDateTime(tz.local, baseTime.year, baseTime.month, baseTime.day);
// //       if (now.isAfter(baseDateInLocalTimeZone)) {
// //         baseDateInLocalTimeZone = tz.TZDateTime(
// //             tz.local, baseTime.year + 1, baseTime.month, baseTime.day);
// //       }
// //       final nextNotificationDate =
// //           baseDateInLocalTimeZone.add(Duration(days: 7 * repeatInterval));
// //       return nextNotificationDate;
// //     }

// //     await flutterLocalNotificationsPlugin.zonedSchedule(
// //       0,
// //       '대신 알려주는 게',
// //       '알람 내용',
// //       getNextDate(baseTime, repeatInterval),
// //       platformChannelSpecifics,
// //       uiLocalNotificationDateInterpretation:
// //           UILocalNotificationDateInterpretation.absoluteTime,
// //       androidAllowWhileIdle: true,
// //       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
// //     );
// //   }

// //   ///
// //   ///
// //   /// TODO
// //   /// NOTE
// //   /// 1. 항목을 삭제해도 알람이 계속 울림
// //   /// 2. sample notification이 계속 울리는데 아마 년도를 계속 올려서 그럴 가능성이 높음
// //   /// 3. test notification의 알람이 안울림
// //   ///
// //   ///
// //   ///
// //   ///
// //   ///

// //   static Future<void> testNotification({
// //     required DateTime baseTime,
// //     //required int repeatInterval,
// //   }) async {
// //     DateTime now = DateTime.now();
// //     var diff = baseTime.difference(now);
// //     int diffDays = diff.inDays;

// //     // 날짜가 이미 지났다면 현재 년 + 1
// //     if (diffDays < 0) {
// //       baseTime = DateTime(baseTime.year + 1, baseTime.month, baseTime.day);
// //       var nextDiff = baseTime.difference(now);
// //       diffDays = nextDiff.inDays;
// //     }

// //     const AndroidNotificationDetails androidPlatformChannelSpecifics =
// //         AndroidNotificationDetails(
// //       '알람 테스트', // 채널 id
// //       '테스트 알람', // 채널 이름
// //       //channelDescription: 'channel description',
// //       importance: Importance.max, // 중요도
// //       priority: Priority.max, // 우선순위
// //       ticker: '알람이 왔어요~', // 상태바에 표시될 텍스트
// //       showWhen: false,
// //     );
// //     const NotificationDetails platformChannelSpecifics = NotificationDetails(
// //       android: androidPlatformChannelSpecifics,
// //       iOS: DarwinNotificationDetails(
// //         badgeNumber: 1,
// //       ),
// //     );

// //     tz.TZDateTime getNextDate(DateTime baseTime) {
// //       var now = tz.TZDateTime.now(tz.local);
// //       var baseDateInLocalTimeZone =
// //           tz.TZDateTime(tz.local, baseTime.year, baseTime.month, baseTime.day);
// //       if (now.isAfter(baseDateInLocalTimeZone)) {
// //         baseDateInLocalTimeZone = tz.TZDateTime(
// //             tz.local, baseTime.year + 1, baseTime.month, baseTime.day);
// //       }
// //       final nextNotificationDate =
// //           baseDateInLocalTimeZone.add(const Duration(seconds: 5));
// //       return nextNotificationDate;
// //     }

// //     await flutterLocalNotificationsPlugin.zonedSchedule(
// //       0,
// //       '대신 알려주는 게',
// //       '알람 내용',
// //       getNextDate(baseTime),
// //       platformChannelSpecifics,
// //       uiLocalNotificationDateInterpretation:
// //           UILocalNotificationDateInterpretation.absoluteTime,
// //       androidAllowWhileIdle: true,
// //       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
// //     );
// //   }
// // }
