import 'package:admin_qurban_mart/components/button/button_component.dart';
import 'package:admin_qurban_mart/models/Cart.dart';

import 'package:flutter/material.dart';

import '../../../constants.dart';

class TelahTerjual extends StatelessWidget {
  final List<Cart> data;
  const TelahTerjual(this.data, {Key? key}) : super(key: key);

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
                DataColumn(label: Text("Status")),
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
  // final fs = FirebaseServices();
  // final GetxPageController c = Get.find();
  // final ProductController p = Get.put(ProductController());

  // void onClickHapus() {
  //   showConfirmDialog(
  //       context: context,
  //       title: "Hapus",
  //       message: "Apakah anda yakin ingin menghapus data ini?",
  //       onConfirm: () async {
  //         await fs.deleteDoc("produk", data.id.toString());
  //       });
  // }

  // void onView(Product d) {
  //   p.setProduct(d);
  //   c.changePage(viewProductScreenRoute);
  // }

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
      DataCell(ButtonComponent(
        data.statusPenjualan.toString(),
        color: Colors.green,
        onPressed: () {},
      )),
    ],
  );
}
