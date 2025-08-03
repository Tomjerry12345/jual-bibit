import 'package:admin_qurban_mart/components/button/icon_button_component.dart';
import 'package:admin_qurban_mart/controllers/cart_controller.dart';
import 'package:admin_qurban_mart/models/Cart.dart';
import 'package:admin_qurban_mart/values/confirm_dialog.dart';
import 'package:admin_qurban_mart/values/position_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class BelumTerjual extends StatelessWidget {
  final List<Cart> data;
  const BelumTerjual(this.data, {Key? key}) : super(key: key);

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
                  label: Text("Total"),
                ),
                DataColumn(label: Text("Action")),
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

DataRow recentFileDataRow(Cart data, BuildContext context) {
  final CartController cartController = Get.put(CartController());

  void onBatalPesanan(Cart cart) {
    showConfirmDialog(
        context: context,
        title: "Konfirmasi",
        message: "Apakah anda yakin ingin membatalkan pesanan ini?",
        onConfirm: () async {
          cartController.batalPesanan(cart);
        });
  }

  Future<void> onUpdateStatusPesanan(Cart cart) async {
    showConfirmDialog(
        context: context,
        title: "Konfirmasi",
        message: "Apakah anda telah menyelesaikan pesanan ini?",
        onConfirm: () async {
          cartController.updateStatusPenjualan(
              cart, StatusPenjualan.terjual.deskripsi);
        });
  }

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
      DataCell(Text("Rp. ${data.harga}")),
      DataCell(Text(data.jumlah.toString())),
      DataCell(Text("Rp. ${data.harga! * data.jumlah!}")),
      DataCell(
        Row(
          children: [
            IconButtonComponent(
              Icons.check,
              color: iconColor,
              onPressed: () => onUpdateStatusPesanan(data),
            ),
            H(8),
            IconButtonComponent(
              Icons.cancel,
              color: Colors.red,
              onPressed: () => onBatalPesanan(data),
            ),
          ],
        ),
      ),
    ],
  );
}
