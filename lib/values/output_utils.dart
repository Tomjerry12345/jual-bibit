import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

void logO(t, {dynamic m = ""}) {
  m == "" ? print("[d] $t") : print("[d] $t: $m");
}

enum StatusSnackbar { success, error }

void showSnackbar(String title, String message, StatusSnackbar status) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor:
        status == StatusSnackbar.success ? Colors.green : Colors.red,
    colorText: Colors.white,
  );
}
