import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

@pragma("vm:entry-point")
Future<void> backgroundHandler(NotificationResponse message) async {}

class NotificationService {
  static String? _initPayload;

  static getInitNotificationPayload() {
    final p = _initPayload;
    _initPayload = null;
    return p;
  }

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> init() async {
    try {
      final AndroidInitializationSettings androidInit =
          AndroidInitializationSettings("@mipmap/ic_launcher");

      final DarwinInitializationSettings iosInit = DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true);

      final InitializationSettings initializationSettings =
          InitializationSettings(iOS: iosInit, android: androidInit);

      await _notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse: backgroundHandler,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          final payload =
              jsonDecode(response.payload ?? "") as Map<String, dynamic>;
          if (response.payload!.isNotEmpty) {
            Get.toNamed(payload['route_name'], arguments: {
              "id": payload['id'],
            });
          }
        },
      );

      final onLanuchDetail =
          await _notificationsPlugin.getNotificationAppLaunchDetails();

      if (onLanuchDetail?.didNotificationLaunchApp ?? false) {
        final resp = onLanuchDetail!.notificationResponse;
        final payload = resp!.payload;

        if (payload != null) {
          _initPayload = payload;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error Init Noti: $e");
      }
    }
  }

  static Future<void> createNotification(
      {required String title,
      required String body,
      required String payload}) async {
    try {
      final AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails("default_channel_id", "Default Channel",
              importance: Importance.max, priority: Priority.high);
      final NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await _notificationsPlugin.show(
          generateId(), payload: payload, title, body, notificationDetails);
    } catch (e) {
      if (kDebugMode) {
        print("Error create Notification: $e");
      }
    }
  }

  static int generateId() =>
      DateTime.now().millisecondsSinceEpoch.remainder(10000);
}
