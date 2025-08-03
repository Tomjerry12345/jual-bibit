import 'package:admin_qurban_mart/components/header/header_component.dart';
import 'package:admin_qurban_mart/constants.dart';
import 'package:admin_qurban_mart/controllers/page_controller.dart';
import 'package:admin_qurban_mart/router/router_constant.dart';
import 'package:admin_qurban_mart/screens/product/tambah/components/input_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahProducts extends StatelessWidget {
  const TambahProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final GetxPageController c = Get.find();
    void onClickBack() {
      c.changePage(managementProductScreenRoute);
    }

    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            HeaderComponent(
              title: "Tambah produk",
              onClickBack: onClickBack,
            ),
            SizedBox(height: defaultPadding),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: InputProducts(),
            )
          ],
        ),
      ),
    );
  }
}
