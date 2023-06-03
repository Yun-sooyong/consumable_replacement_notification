import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:consumable_replacement_notification/main.dart';
import 'package:consumable_replacement_notification/pages/home_page.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        )
      ],
      debug: true,
    );

    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      MyApp.navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    }
  }

  static Future<void> showNotification({
    required final int id,
    required final String title,
    required final String body,
    final DateTime? dateTime,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
    final bool repeat = false,
    final int month = 1,
  }) async {
    assert(!scheduled || (scheduled && dateTime != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              // timezone: 시간대 구역
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
              repeats: repeat,
            )
          : null,
    );

    // await AwesomeNotifications().createNotification(
    //   content: NotificationContent(
    //     id: id,
    //     channelKey: 'high_importance_channel',
    //     title: '매분 알림',
    //     body: '매분 00초가 되면 알람이 울림',
    //     actionType: actionType,
    //     notificationLayout: notificationLayout,
    //     summary: summary,
    //     category: category,
    //     payload: payload,
    //     bigPicture: bigPicture,
    //   ),
    //   actionButtons: actionButtons,
    //   schedule: scheduled
    //       ? NotificationCalendar(
    //           second: 0,
    //           repeats: true,
    //           timeZone:
    //               await AwesomeNotifications().getLocalTimeZoneIdentifier(),
    //         )
    //       : null,
    // );

    // await AwesomeNotifications().createNotification(
    //   content: NotificationContent(
    //     id: id,
    //     channelKey: 'high_importance_channel',
    //     title: '매분 알림',
    //     body: '매분 00초가 되면 알람이 울림',
    //     actionType: actionType,
    //     notificationLayout: notificationLayout,
    //     summary: summary,
    //     category: category,
    //     payload: payload,
    //     bigPicture: bigPicture,
    //   ),
    //   actionButtons: actionButtons,
    //   schedule: scheduled
    //       ? NotificationCalendar.fromDate(date: dateTime!, repeats: true)
    //       : null,
    // );
  }
}
