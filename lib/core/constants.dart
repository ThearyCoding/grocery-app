import 'package:get/get.dart';

class AppConstants{
  static String baseUrl = GetPlatform.isIOS? "http://localhost:3000/api": "http://10.0.2.2:3000/api";
}