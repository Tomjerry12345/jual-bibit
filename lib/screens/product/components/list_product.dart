import 'package:admin_qurban_mart/components/button/button_component.dart';
import 'package:admin_qurban_mart/components/button/icon_button_component.dart';
import 'package:admin_qurban_mart/controllers/page_controller.dart';
import 'package:admin_qurban_mart/controllers/product_controller.dart';
import 'package:admin_qurban_mart/models/Products.dart';
import 'package:admin_qurban_mart/router/router_constant.dart';
import 'package:admin_qurban_mart/services/firebase_services.dart';
import 'package:admin_qurban_mart/values/confirm_dialog.dart';
import 'package:admin_qurban_mart/values/position_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class ListProduct extends StatelessWidget {
  final List<Product> data;
  const ListProduct(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: const [
                DataColumn(
                  label: Text("Gambar"),
                ),
                DataColumn(
                  label: Text("Nama"),
                ),
                DataColumn(
                  label: Text("Harga"),
                ),
                DataColumn(
                  label: Text("Jumlah"),
                ),
                DataColumn(
                  label: Text("Action"),
                ),
              ],
              rows: List.generate(
                data.length,
                (index) => recentFileDataRow(data[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(Product data, BuildContext context) {
  final fs = FirebaseServices();
  final GetxPageController c = Get.find();
  final ProductController p = Get.put(ProductController());

  void onClickHapus() {
    showConfirmDialog(
        context: context,
        title: "Hapus",
        message: "Apakah anda yakin ingin menghapus data ini?",
        onConfirm: () async {
          await fs.deleteDoc("produk", data.id.toString());
        });
  }

  void onView() {
    p.setProduct(data);
    c.changePage(viewProductScreenRoute);
  }

  print(data.toMap());

  return DataRow(
    cells: [
      DataCell(Image.network(
        data.image!,
        height: 30,
        width: 30,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, color: Colors.red);
        },
      )),
      DataCell(Text(data.nama.toString())),
      DataCell(Text(data.harga.toString())),
      DataCell(Text(data.jumlah.toString())),
      DataCell(
        Row(
          children: [
            IconButtonComponent(
              Icons.visibility_outlined,
              color: iconColor,
              onPressed: onView,
            ),
            H(8),
            IconButtonComponent(
              Icons.delete,
              color: Colors.red,
              onPressed: onClickHapus,
            ),
          ],
        ),
      ),
    ],
  );
}
