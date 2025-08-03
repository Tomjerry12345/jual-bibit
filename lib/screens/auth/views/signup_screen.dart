import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qurban_mart/controller/auth_controller.dart';
import 'package:qurban_mart/screens/auth/views/components/sign_up_form.dart';
import 'package:qurban_mart/route/route_constants.dart';
import 'package:qurban_mart/values/output_utils.dart';
import 'package:qurban_mart/values/position_utils.dart';

import '../../../constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    void showImageSourceActionSheet(
        BuildContext context, AuthController controller) {
      showModalBottomSheet(
        context: context,
        builder: (context) => SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  controller.pickImage(source: ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  controller.pickImage(source: ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let’s get started!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Please enter your valid data in order to create an account.",
                  ),
                  const SizedBox(height: defaultPadding),
                  Obx(() {
                    return Center(
                      child: GestureDetector(
                        onTap: () =>
                            showImageSourceActionSheet(context, authController),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          backgroundImage: authController
                                  .selectedImagePath.value.isNotEmpty
                              ? FileImage(
                                  File(authController.selectedImagePath.value))
                              : null,
                          child: authController.selectedImagePath.value.isEmpty
                              ? Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Theme.of(context).iconTheme.color,
                                )
                              : null,
                        ),
                      ),
                    );
                  }),
                  V(24),
                  SignUpForm(formKey: _formKey),
                  const SizedBox(height: defaultPadding * 2),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          try {
                            _formKey.currentState?.save();
                            authController.onClickSignup().then((_) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  entryPointScreenRoute,
                                  ModalRoute.withName(signUpScreenRoute));
                            }).catchError((e) {
                              showSnackbar("Terjadi kesalahan!", e.toString(),
                                  StatusSnackbar.error);
                            });
                          } catch (e) {
                            showSnackbar("Terjadi kesalahan!", e.toString(),
                                StatusSnackbar.error);
                          }
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (authController.isLoading.value)
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                          const SizedBox(width: 8),
                          const Text("Continue"),
                        ],
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Do you have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, logInScreenRoute);
                        },
                        child: const Text("Log in"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
