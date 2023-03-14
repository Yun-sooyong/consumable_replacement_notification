import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  LocalNotification._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static initialize() async {
    AndroidInitializationSettings initailizationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initailizationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void requestPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

// TODO 기간을 계산해서 호출
  static Future<void> sampleNotification({
    required String title,
    required int type,
  }) async {
    tz.initializeTimeZones();
    //tz.setLocalLocation(tz.getLocation('Korea'));
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '대신알려주는 게',
      '게로부터의 알람',
      //channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: DarwinNotificationDetails(
          badgeNumber: 1,
        ));
    // await flutterLocalNotificationsPlugin.show(
    //   0,
    //   title,
    //   type == 0
    //       ? '소모품 교체주기가 되었습니다. \n소모품을 교체해 주세요.'
    //       : '기념일이 다가옵니다.\n즐거운 하루되세요.',
    //   platformChannelSpecifics,
    //   //payload: 'item x',
    // );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      type == 0
          ? '소모품 교체주기가 되었습니다. \n소모품을 교체해 주세요.'
          : '기념일이 다가옵니다.\n즐거운 하루되세요.',
      // 입력된 기간 후 자동으로 입력
      // TODO 한번만 실행되는데 반복해서 할 방법을 찾기
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}
