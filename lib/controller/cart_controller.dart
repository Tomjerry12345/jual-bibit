import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qurban_mart/constants.dart';
import 'package:qurban_mart/controller/auth_controller.dart';
import 'package:qurban_mart/controller/maps_controller.dart';
import 'package:qurban_mart/models/cart_model.dart';
import 'package:qurban_mart/models/product_model.dart';
import 'package:qurban_mart/services/firebase_services.dart';
import 'package:qurban_mart/values/output_utils.dart';

class CartController extends GetxController {
  var cartData = Rx<List<Cart>>([]);

  final _fs = FirebaseServices();
  final authController = Get.put(AuthController());
  final mapController = Get.put(MapsController());

  var loading = false.obs;
  Rxn<XFile> buktiPembayaran = Rxn<XFile>();

  var jumlahBeli = 0.obs;

  @override
  void onInit() {
    final authController = Get.find<AuthController>();
    final username = authController.currentUser.value;
    getDataCart(username);
    super.onInit();
  }

  void reset() {
    cartData.value = [];
  }

  void resetBuktiPembayaran() {
    loading.value = false;
    buktiPembayaran.value = null;
  }

  void getDataCart(String username) async {
    final snapCart = await _fs.getDataCollection2ByQuery("cart", "pembeli",
        username, "statusPenjualan", StatusPenjualan.belumTerjual.deskripsi);

    List<Cart> listCart = [];

    for (var e in snapCart) {
      final dataCart = Cart.fromMap(e.data());

      listCart.add(dataCart);
    }

    cartData.value = listCart;
  }

  Future<void> addToCart(Product product, String user) async {
    final checkDuplikat = await _fs.getDataCollection3ByQuery(
        "cart",
        "idProduk",
        product.id,
        "pembeli",
        user,
        "statusPenjualan",
        StatusPenjualan.belumTerjual.deskripsi);

    if (checkDuplikat.isNotEmpty) {
      showSnackbar("Pesan!", "Produk telah di simpan!", StatusSnackbar.error);
      return;
    }

    if (jumlahBeli.value > product.jumlah!) {
      showSnackbar("Pesan!", "Jumlah beli melebihi jumlah barang!",
          StatusSnackbar.error);
      return;
    }

    Cart cart = Cart(
        idProduk: product.id.toString(),
        pembeli: user,
        nama: product.nama,
        statusPenjualan: StatusPenjualan.belumTerjual.deskripsi,
        image: product.image,
        jumlah: jumlahBeli.value,
        harga: product.harga);

    await _fs.addDataCollection("cart", cart.toMap());

    await _fs.updateDataSpecifictDoc("produk", product.id.toString(),
        {"jumlah": product.jumlah! - jumlahBeli.value});

    showSnackbar("Pesan!", "Berhasil tambah produk!", StatusSnackbar.success);
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

  Future<void> updateBuktiPembayaran(
      {required String? id,
      required BuildContext context,
      String? idProduk}) async {
    // final ImagePicker _picker = ImagePicker();
    // final XFile? image = await _picker.pickImage(source: source);

    final valBuktiPembayaran = buktiPembayaran.value;

    if (valBuktiPembayaran != null) {
      loading.value = true;

      File file = File(valBuktiPembayaran.path);
      String fileName =
          "${authController.currentUser.value}_${DateTime.now().millisecondsSinceEpoch}.png";

      logO("fileName", m: fileName);

      final urlImage = await _fs.uploadFile(file, fileName, "cart");
      await _fs.updateDataSpecifictDoc("produk", idProduk!, {
        "idCart": id,
        "buktiPembayaran": urlImage,
        "statusPembayaran": StatusPembayaran.pembayaranDiProses.deskripsi,
        "isPemesan": true,
        "lokasiPengiriman": mapController.latLng.value != null
            ? GeoPoint(
                mapController.latLng.value!.latitude,
                mapController.latLng.value!.longitude,
              )
            : null,
      });

      loading.value = false;

      resetBuktiPembayaran();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      Get.snackbar("Error", "No image selected");
    }
  }
}
