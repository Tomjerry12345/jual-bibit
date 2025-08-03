import 'package:admin_qurban_mart/components/header/header_component.dart';
import 'package:admin_qurban_mart/components/text/text_component.dart';
import 'package:admin_qurban_mart/controllers/page_controller.dart';
import 'package:admin_qurban_mart/models/PostionTab.dart';
import 'package:admin_qurban_mart/models/Products.dart';
import 'package:admin_qurban_mart/responsive.dart';
import 'package:admin_qurban_mart/router/router_constant.dart';
import 'package:admin_qurban_mart/screens/product/components/list_product.dart';

import 'package:admin_qurban_mart/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class ProductScreen extends StatelessWidget {
  final GetxPageController c = Get.find();
  final isActivateTab1 = true.obs;
  final isActivateTab2 = false.obs;

  final fs = FirebaseServices();

  ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: fs.getDataStreamCollection("produk"),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            final docs = snapshot.data?.docs;

            List<Product> data = [];

            if (docs!.isNotEmpty) {
              data = docs.map((doc) {
                return Product.fromMap(doc.data());
              }).toList();
            }

            return SafeArea(
              child: SingleChildScrollView(
                primary: false,
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    HeaderComponent(
                      title: "Produk",
                    ),
                    SizedBox(height: defaultPadding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              // MyFiles(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "List produk",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontSize: 20,
                                          color: Colors
                                              .green, // timpa warna putih default
                                        ),
                                  ),
                                  ElevatedButton.icon(
                                    style: TextButton.styleFrom(
                                      backgroundColor: buttonColor,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: defaultPadding * 1.5,
                                        vertical: defaultPadding /
                                            (Responsive.isMobile(context)
                                                ? 2
                                                : 1),
                                      ),
                                    ),
                                    onPressed: () {
                                      c.changePage(tambahProductScreenRoute);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    label: TextComponent(
                                      "Tambah produk",
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: defaultPadding),

                              ListProduct(data),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }

  Widget TabButton(BuildContext context, String text, PositionTab position,
      bool isActivate, Function()? onPressed) {
    return ElevatedButton(
      style: TextButton.styleFrom(
        backgroundColor: isActivate ? tabActivateColor : tabNotactivateColor,
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding * 1.5,
          vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                position == PositionTab.left ? 12 : 0,
              ),
              topRight: Radius.circular(
                position == PositionTab.right ? 12 : 0,
              )),
        ),
      ),
      onPressed: onPressed,
      child: TextComponent(
        text,
        color: Colors.white,
        size: 14,
      ),
    );
  }
}
