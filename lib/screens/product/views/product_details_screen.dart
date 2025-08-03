import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurban_mart/components/cart_button.dart';
import 'package:qurban_mart/constants.dart';
import 'package:qurban_mart/controller/auth_controller.dart';
import 'package:qurban_mart/controller/cart_controller.dart';
import 'package:qurban_mart/models/product_model.dart';
import 'package:qurban_mart/route/route_constants.dart';
import 'package:qurban_mart/values/output_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/product_images.dart';
import 'components/product_list_tile.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final authController = Get.find<AuthController>();

    Future<void> openWhatsAppOrCall(String phoneNumber, String message) async {
      final whatsappUrl = Uri.parse(
          'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');
      final phoneUrl = Uri.parse('tel:$phoneNumber');

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(phoneUrl)) {
        await launchUrl(phoneUrl, mode: LaunchMode.externalApplication);
      } else {
        logO('Could not launch WhatsApp or Phone');
      }
    }

    Future<void> openMaps(double latitude, double longitude) async {
      final url = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<void> onSimpan() async {
      if (authController.currentUser.value == "") {
        showSnackbar("Terjadi kesalahan!",
            "Login terlebih dahulu untuk memesan!", StatusSnackbar.error);
        authController.onLogout();
        Navigator.pushNamedAndRemoveUntil(context, logInScreenRoute,
            ModalRoute.withName(entryPointScreenRoute));
        return;
      }

      await cartController.addToCart(product, authController.currentUser.value);
      Navigator.pushNamedAndRemoveUntil(context, entryPointScreenRoute,
          ModalRoute.withName(productDetailsScreenRoute));
    }

    return Obx(() {
      double totalHarga =
          cartController.jumlahBeli.value * product.harga!.toDouble();
      return Scaffold(
        bottomNavigationBar: CartButton(
          title: "Simpan",
          subTitle: "Total bayar",
          price: totalHarga,
          press: onSimpan,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                floating: true,
              ),
              ProductImages(
                images: [product.image.toString()],
              ),
              ProductListTile(
                title: "Total produk",
                value: "${product.jumlah} bibit",
              ),
              ProductListTile(
                title: "No hp",
                value: noHp,
                isShowBottomBorder: true,
                press: () {
                  openWhatsAppOrCall(
                      noHp, 'Halo, saya tertarik dengan produk ini.');
                },
              ),
              ProductListTile(
                title: "Lokasi",
                value: "",
                isShowBottomBorder: true,
                press: () {
                  openMaps(lokasi.latitude, lokasi.longitude);
                },
              ),
              ProductListTile(
                title: "Harga",
                value: "Rp. ${product.harga}",
              ),
              ProductListTile(
                  title: "Jumlah beli",
                  value: "",
                  isShowBottomBorder: true,
                  trailing: Padding(
                    padding: EdgeInsets.all(8),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 40, // lebar awal (minimum)
                        maxWidth:
                            100, // batas maksimal supaya tidak melebihi layar
                      ),
                      child: IntrinsicWidth(
                        child: TextFormField(
                          onChanged: (jumlahBeliStr) {
                            int jumlahInput = int.tryParse(jumlahBeliStr) ?? 0;

                            if (jumlahInput > product.jumlah!) {
                              // Jika lebih dari stok produk
                              // Tampilkan pesan
                              FocusScope.of(context).unfocus();
                              showSnackbar(
                                  "Pesan!",
                                  "Jumlah beli melebihi stok (${product.jumlah})",
                                  StatusSnackbar.error);
                            }

                            cartController.jumlahBeli.value = jumlahInput;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "0",
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
