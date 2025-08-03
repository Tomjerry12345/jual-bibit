import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qurban_mart/components/product/product_card.dart';
import 'package:qurban_mart/controller/produk_controller.dart';
import 'package:qurban_mart/models/product_model.dart';
import 'package:qurban_mart/route/route_constants.dart';
import 'package:qurban_mart/screens/home/views/components/search_form.dart';
import 'package:flutter/material.dart';
import 'package:qurban_mart/constants.dart';
import 'package:qurban_mart/services/firebase_services.dart';
import 'package:qurban_mart/values/output_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fs = FirebaseServices();
    final produkController = Get.find<ProdukController>();

    return Scaffold(
      body: Obx(() {
        final kategori = produkController.kategori.value;
        final cari = produkController.cari.value;
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: kategori != "All Categories"
                ? fs.getDataQueryStream("produk", "kategori", kategori)
                : cari != ""
                    ? fs.onSearching("produk", "nama", cari)
                    : fs.getDataStreamCollection("produk"),
            builder: (context, snapshot) {
              final docs = snapshot.data?.docs;

              List<Product> data = [];

              if (docs != null) {
                data = docs
                    .map((doc) {
                      return Product.fromMap(doc.data());
                    })
                    .where((product) =>
                        product.statusPembayaran !=
                        StatusPembayaran.pembayaranBerhasil.deskripsi)
                    .toList();
              }

              return SafeArea(
                child: CustomScrollView(
                  slivers: [
                    // const SliverToBoxAdapter(
                    //     child: OffersCarouselAndCategories()),
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding, vertical: defaultPadding),
                      sliver: SliverToBoxAdapter(
                        child: SearchForm(),
                      ),
                    ),
                    SliverPadding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      sliver: SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double maxWidth = constraints.maxWidth;
                              double itemWidth =
                                  (maxWidth - defaultPadding) / 2;

                              return Wrap(
                                spacing: defaultPadding,
                                runSpacing: defaultPadding,
                                children: List.generate(data.length, (index) {
                                  return SizedBox(
                                    width: itemWidth,
                                    child: ProductCard(
                                      image: data[index].image.toString(),
                                      title: data[index].nama.toString(),
                                      price: data[index].harga,
                                      jumlah: data[index].jumlah,
                                      press: () {
                                        int? jumlahProduk = data[index].jumlah;
                                        if (jumlahProduk == null ||
                                            jumlahProduk == 0) {
                                          // Bisa tambahkan snackbar atau dialog jika mau beri feedback
                                          showSnackbar("Pesan!", "Produk habis",
                                              StatusSnackbar.error);
                                          return;
                                        }
                                        produkController.reset();
                                        Navigator.pushNamed(
                                            context, productDetailsScreenRoute,
                                            arguments: data[index]);
                                      },
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
