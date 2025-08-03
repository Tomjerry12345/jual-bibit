import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:qurban_mart/constants.dart';
import 'package:qurban_mart/controller/auth_controller.dart';
import 'package:qurban_mart/route/route_constants.dart';
import 'package:qurban_mart/values/output_utils.dart';

import 'components/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final authController = Get.put(AuthController());

    // final _prefs = SharedPreferences.getInstance();

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // ⬅️ Vertikal tengah
                crossAxisAlignment:
                    CrossAxisAlignment.center, // ⬅️ Horizontal tengah
                children: [
                  const SizedBox(height: 32),
                  Image.asset(
                    "assets/images/logo.jpg",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Penjualan bibit di CV ADMI karya!",
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        const Text(
                          "Masuk dengan data yang Anda masukkan saat pendaftaran.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: defaultPadding),
                        LogInForm(formKey: _formKey),
                        const SizedBox(height: defaultPadding),
                        Obx(() {
                          return ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  _formKey.currentState?.save();

                                  authController.onClickLogin().then((_) async {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        entryPointScreenRoute,
                                        ModalRoute.withName(logInScreenRoute));
                                  }).catchError((e) {
                                    showSnackbar("Terjadi kesalahan!",
                                        e.toString(), StatusSnackbar.error);
                                  });
                                } catch (e) {
                                  showSnackbar("Terjadi kesalahan!",
                                      e.toString(), StatusSnackbar.error);
                                }
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (authController.isLoading.value)
                                  const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                const SizedBox(width: 8),
                                const Text("Log in"),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: defaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Belum punya akun?"),
                            TextButton(
                              onPressed: () {
                                authController.clearInput();
                                Navigator.pushNamed(context, signUpScreenRoute);
                              },
                              child: const Text("Daftar"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
