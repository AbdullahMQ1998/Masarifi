import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';





class NotificationApi{

  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );

  }

  static Future init({bool initScheduled = false}) async {
    final IOS = IOSInitializationSettings();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android,iOS: IOS);
    await _notification.initialize(
      settings,
      onSelectNotification:  (payload) async {
onNotifications.add(payload);
      },
    );

    if(initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }

  }

  static Future showNotification({
  int id = 0,
  String title,
  String body,
  String payload,
}) async => _notification.show(
    id,
    title,
    body,
    await _notificationDetails(),
    payload: payload,
);


  static void showScheduledNotification({
    int id = 0,
    String title,
    String body,
    String payload,
    int hours,
    int min,
  }) async {
      _notification.zonedSchedule(
        id,// choose for each notification an index that is unique
        title,
        body,
        _scheduleDaily(Time(hours,min)),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );





  }


  static tz.TZDateTime _scheduleDaily(Time time){
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
        tz.local,
      now.year,
      now.month,
      now.day,
        time.hour,
      time.minute,
      time.second
    );
    return scheduledDate.isBefore(now) ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;
  }


}