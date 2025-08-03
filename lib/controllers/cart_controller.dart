import 'package:admin_qurban_mart/models/Cart.dart';
import 'package:admin_qurban_mart/services/firebase_services.dart';
import 'package:admin_qurban_mart/values/output_utils.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _fs = FirebaseServices();

  final product = Cart().obs;

  setProduct(Cart p) {
    product.value = p;
  }

  Future<void> batalPesanan(Cart cart) async {
    try {
      await _fs.deleteDoc("cart", cart.id!);

      final docProduk = await _fs.getDataDoc("produk", cart.idProduk!);
      final dataProduk = docProduk.data();

      if (dataProduk != null) {
        int jumlahLama = dataProduk["jumlah"] ?? 0;

        await _fs.updateDataSpecifictDoc("produk", cart.idProduk!, {
          "jumlah": jumlahLama + cart.jumlah!,
        });
      }

      showSnackbar(
          "Pesan!", "Pesanan berhasil dibatalkan", StatusSnackbar.success);
    } catch (e) {
      showSnackbar(
          "Error", "Gagal membatalkan pesanan: $e", StatusSnackbar.error);
    }
  }

  Future<void> updateStatusPenjualan(Cart cart, String statusPenjualan) async {
    try {
      await _fs.updateDataSpecifictDoc("cart", cart.id!, {
        "statusPenjualan": statusPenjualan,
      });

      showSnackbar("Pesan!", "Status penjualan berhasil di update",
          StatusSnackbar.success);
    } catch (e) {
      showSnackbar(
          "Error", "Gagal update status penjualan: $e", StatusSnackbar.error);
    }
  }
}
