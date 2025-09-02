
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SnacbarUtils {
  static void showSnacbar({String? title, String? message, bool isError = false}) {
    Get.snackbar(
      title ?? (isError ? "Error" : "Success"),
      message ?? (isError ? "An error occurred" : "Operation successful"),
      backgroundColor: isError ? const Color(0xFFFFCDD2) : const Color(0xFFC8E6C9),
      colorText: isError ? const Color(0xFFD32F2F) : const Color(0xFF388E3C),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 8.0,
      duration: const Duration(seconds: 3),
      icon: Icon(
        isError ? Icons.error : Icons.check_circle,
        color: isError ? const Color(0xFFD32F2F) : const Color(0xFF388E3C),
      ),
    );
  }
}
