import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qurban_mart/components/network_image_with_loader.dart';
import 'package:qurban_mart/constants.dart';
import 'package:qurban_mart/controller/cart_controller.dart';
import 'package:qurban_mart/models/cart_model.dart';
import 'package:qurban_mart/values/dialog_utils.dart';
import 'package:qurban_mart/values/output_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class CartItem extends StatelessWidget {
  final Cart data;
  final VoidCallback? press;
  final ButtonStyle? style;

  const CartItem({
    super.key,
    required this.data,
    this.press,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    final NumberFormat currencyFormat = NumberFormat.decimalPattern('id');

    Future<void> openWhatsAppOrCall(String phoneNumber, String message) async {
      final whatsappUrl = Uri.parse(
          'https://wa.me/62$phoneNumber?text=${Uri.encodeComponent(message)}');
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

    Future<void> onBatalPesanan(Cart cart) async {
      await dialogShow(
          context: context,
          title: "Konfirmasi",
          content: Text("Apakah anda yakin ingin membatalkan pesanan?"),
          actions: [
            TextButton(
              child: const Text("Tidak"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Ya"),
              onPressed: () {
                Navigator.of(context).pop();
                cartController.batalPesanan(cart);
              },
            ),
          ]);
    }

    return OutlinedButton(
        onPressed: press,
        child: Row(
          children: [
            SizedBox(
              width: 120, // atur sesuai kebutuhan
              height: 180,
              child: NetworkImageWithLoader(data.image.toString(),
                  radius: defaultBorderRadious),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama : ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    data.nama.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Harga : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Rp. ${currencyFormat.format(data.harga)} / biji",
                    style: const TextStyle(
                      color: Color(0xFF31B0D8),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Text(
                  //   "Total bayar : ",
                  //   style: const TextStyle(
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 12,
                  //   ),
                  // ),
                  // Row(
                  //   children: [
                  //     // Gunakan Flexible agar teks bisa membungkus jika panjang
                  //     Flexible(
                  //       child: Container(
                  //         padding: const EdgeInsets.all(6),
                  //         decoration: BoxDecoration(
                  //           color: Colors.green,
                  //           borderRadius: BorderRadius.circular(8),
                  //         ),
                  //         child: Text(
                  //           "Rp. ${currencyFormat.format(data.harga! * data.jumlah!)}  /  ${data.jumlah} Biji",
                  //           style: const TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 10,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //           overflow: TextOverflow.ellipsis,
                  //           maxLines: 2,
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 8), // Spasi antar elemen

                  //     // Hindari Spacer agar tombol tidak mendorong teks
                  //     Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         IconButton(
                  //           icon: const Icon(Icons.chat,
                  //               size: 20, color: Colors.green),
                  //           onPressed: () {
                  //             openWhatsAppOrCall(noHp,
                  //                 'Halo, saya tertarik dengan produk ini.');
                  //           },
                  //         ),
                  //         IconButton(
                  //           icon: const Icon(Icons.location_on,
                  //               size: 20, color: Colors.red),
                  //           onPressed: () {
                  //             openMaps(lokasi.latitude, lokasi.longitude);
                  //           },
                  //         ),
                  //         IconButton(
                  //           icon: const Icon(Icons.cancel,
                  //               size: 20, color: Colors.red),
                  //           onPressed: () {
                  //             onBatalPesanan(data);
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  const Text(
                    "Total bayar : ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Rp. ${currencyFormat.format(data.harga! * data.jumlah!)}  /  ${data.jumlah} Biji",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chat,
                            size: 20, color: Colors.green),
                        onPressed: () {
                          openWhatsAppOrCall(data.noHp!,
                              'Halo, saya tertarik dengan produk ini.');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.location_on,
                            size: 20, color: Colors.red),
                        onPressed: () {
                          openMaps(lokasi.latitude, lokasi.longitude);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel,
                            size: 20, color: Colors.red),
                        onPressed: () {
                          onBatalPesanan(data);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
