import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, {bool isError = true, String? title}) {
  Get.closeAllSnackbars();
  Get.snackbar(title ?? "Error", message,
      titleText: Text(
        title ?? (isError ? "Error" : "Success"),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Colors.redAccent : Colors.green);
}