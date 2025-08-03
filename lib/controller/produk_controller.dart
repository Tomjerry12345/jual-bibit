import 'package:get/get.dart';

class ProdukController extends GetxController {
  var kategori = 'All Categories'.obs;
  var indexKategori = 0.obs;
  var cari = "".obs;

  void reset() {
    kategori.value = 'All Categories';
    indexKategori.value = 0;
    cari.value = '';
  }
}
