import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:grocery_app/controllers/localization_controller.dart';
import 'package:grocery_app/firebase_options.dart';
import 'package:grocery_app/generated/l10n.dart';
import 'package:grocery_app/pages/main_page.dart';
import 'package:grocery_app/pages/order_detail_page.dart';
import 'package:grocery_app/services/notification/fcm_service.dart';
import 'package:grocery_app/services/notification/notification_service.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'pages/welcome_page.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  final WidgetsBinding instance = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: instance);
  FlutterNativeSplash.remove();
  if(!Platform.isIOS){
    await FcmService.init();
  }
  await NotificationService.init();
  Get.put(LocalizationController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _tokenStorage = TokenStorage();

  Future<void> checkIsLogined() async {
    final token = await _tokenStorage.getToken();
    if (kDebugMode) {
      print("access token: $token");
    }
    if (token != null) {
      Get.offAll(() => MainPage());
    } else {
      Get.offAll(() => WelcomePage());
    }
  }

  @override
  void initState() {
    super.initState();
    checkIsLogined();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        final data = message.data;
        final id = data['id'];
        final routeName = data['route_name'];

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.toNamed(routeName, arguments: {"id": id});
        });
      }
    });

    final payload = NotificationService.getInitNotificationPayload();

    if (payload != null) {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      final id = data['id'];
      final routeName = data['route_name'];

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.toNamed(routeName, arguments: {"id": id});
      });
    }
  }

  final localizationController = Get.find<LocalizationController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        locale: localizationController.currectLocale.value,
        supportedLocales: [Locale("en"), Locale("km")],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        getPages: [
          GetPage(name: "/order_detail_page", page: () => OrderDetailPage())
        ],
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        theme: ThemeData(
            fontFamily: 'Gilroy',
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
                scrolledUnderElevation: 0.0, elevation: 0, color: Colors.white),
            inputDecorationTheme: InputDecorationTheme(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffE2E2E2))),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffE2E2E2))),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffE2E2E2)))),
            bottomSheetTheme:
                BottomSheetThemeData(backgroundColor: Colors.transparent)),
      );
    });
  }
}
