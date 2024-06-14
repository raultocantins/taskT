import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_planner/main.dart';
import 'package:task_planner/src/features/tasks/domain/entities/task_entity.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PushNotification {
  FlutterLocalNotificationsPlugin? notificationPlugin;
  PushNotification(
      {required FlutterLocalNotificationsPlugin
          flutterLocalNotificationsPlugin}) {
    notificationPlugin = flutterLocalNotificationsPlugin;
  }

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation(
        await FlutterTimezone.getLocalTimezone(),
      ),
    );
    await notificationPlugin?.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
    await notificationPlugin
        ?.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await notificationPlugin
        ?.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          critical: true,
          provisional: true,
          sound: true,
        );
  }

  Future<void> onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to
    //another page
    showDialog(
      context: NavigatorKey.navigatorKey.currentState!.context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ''),
        content: Text(body ?? ''),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Future<void> onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  Future<void> showScheduledLocalNotification(
      {required int id,
      required String title,
      required String body,
      required String payload,
      required DateTime date}) async {
    const platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'task',
        'scheduled',
        groupKey: 'com.task_planner.notifications',
        channelDescription: 'channel to task notifications',
        importance: Importance.max,
        priority: Priority.max,
        ticker: 'ticker',
      ),
      iOS: DarwinNotificationDetails(),
    );
    ();
    final scheduledDate = tz.TZDateTime.from(date, tz.local);

    await notificationPlugin?.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelScheduledNotification(TaskEntity task) async {
    await notificationPlugin?.cancel(task.id!);
  }
}
