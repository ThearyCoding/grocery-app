import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:grocery_app/pages/main_page.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'pages/welcome_page.dart';
import 'package:get/get.dart';

void main() {
  final WidgetsBinding instance = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: instance);
  FlutterNativeSplash.remove();
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

    if (token != null) {
      Get.off(() => MainPage());
    } else {
      Get.off(() => WelcomePage());
    }
  }

  @override
  void initState() {
    super.initState();
    checkIsLogined();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
  }
}


