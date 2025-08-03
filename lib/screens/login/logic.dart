import 'package:admin_qurban_mart/constants.dart';
import 'package:admin_qurban_mart/controllers/auth_controller.dart';
import 'package:admin_qurban_mart/services/firebase_services.dart';
import 'package:admin_qurban_mart/values/output_utils.dart';
import 'package:admin_qurban_mart/values/share_reference_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logic {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final fs = FirebaseServices();

  final authController = Get.find<AuthController>();

  Future<void> onLogin() async {
    final username = this.username.text;
    final password = this.password.text;

    if (username.isEmpty || password.isEmpty) {
      showSnackbar("Terjadi kesalahan !",
          "Username atau password tidak boleh kosong!", StatusSnackbar.error);
      return;
    }

    final data = await fs.getDataCollection("admin");

    final admin = data[0].data();

    final fsUsername = admin["username"];
    final fsPassword = admin["password"];

    if (fsUsername == username && fsPassword == password) {
      authController.login();
    } else {
      showSnackbar("Terjadi kesalahan !", "Username atau kata sandi salah",
          StatusSnackbar.error);
    }

    // if (username == "admin" && password == "55555") {
    //   // navigatePush(context, MainScreen(), isRemove: true);
    // } else {
    //   showToast("Username atau kata sandi salah");
    // }
  }
}
