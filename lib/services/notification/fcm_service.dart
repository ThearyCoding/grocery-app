import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:grocery_app/services/notification/notification_service.dart';
  @pragma("vm:entry-point")
   Future<void> backgroundHandler(RemoteMessage message) async {}
class FcmService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }
    final token = await FirebaseMessaging.instance.getToken();
    print("fcm token: $token");
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notif = message.notification;
      final data = message.data;
      final title = notif!.title ?? "";
      final body = notif.body ?? "";
      final id = data['id'];
      final route = data['route_name'];
      final payload = {
        "route_name": route,
        "id": id,
      };

      await NotificationService.createNotification(
          title: title, body: body, payload: jsonEncode(payload));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      final data = message.data;
      final id = data['id'];
      final route = data['route_name'];
      print("id: $id");
      
      Get.toNamed(route, arguments: {
        "id": id,
      });
    });
  }
}
