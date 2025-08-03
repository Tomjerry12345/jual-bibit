import 'package:admin_qurban_mart/components/button/button_component.dart';
import 'package:admin_qurban_mart/components/text/text_component.dart';
import 'package:admin_qurban_mart/components/textfield/textfield_component.dart';
import 'package:admin_qurban_mart/constants.dart';
import 'package:admin_qurban_mart/controllers/maps_controller.dart';
import 'package:admin_qurban_mart/controllers/page_controller.dart';
import 'package:admin_qurban_mart/controllers/product_controller.dart';
import 'package:admin_qurban_mart/models/File.dart';
import 'package:admin_qurban_mart/router/router_constant.dart';
import 'package:admin_qurban_mart/services/firebase_services.dart';
import 'package:admin_qurban_mart/services/supabase_services.dart';
import 'package:admin_qurban_mart/values/position_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

class InputProducts extends StatelessWidget {
  final GetxPageController c = Get.find();
  final ProductController p = Get.put(ProductController());
  final mapsController = Get.put(MapsController());

  final fs = FirebaseServices();
  final ss = SupaBaseServices();

  final List<String> kurbanItems = ['Konsumsi', 'Kurban', "Akikah"];

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final jumlahController = TextEditingController();
  final noHpController = TextEditingController();

  final isLoading = false.obs;

  InputProducts({super.key}); // Observable untuk status loading

  @override
  Widget build(BuildContext context) {
    final prod = p.product.value;

    namaController.text = prod.nama.toString();
    hargaController.text = prod.harga.toString();
    jumlahController.text = prod.jumlah.toString();
    noHpController.text = prod.noHp.toString();

    return ObxValue<Rx<FileModel?>>((file) {
      Future<void> onPickImage() async {
        final mediaInfo = await ImagePickerWeb.getImageInfo();

        if (mediaInfo != null) {
          final image = mediaInfo.data;
          final fileName = mediaInfo.fileName; // Nama file

          file.value = FileModel(image, fileName.toString());
        } else {
          print("No file selected");
        }
      }

      Future<void> onEdit() async {
        final nama = namaController.text;
        final harga = hargaController.text;
        final jumlah = jumlahController.text;
        final noHp = noHpController.text;

        if (nama.isEmpty || harga.isEmpty || jumlah.isEmpty || noHp.isEmpty) {
          Get.snackbar(
            "Error",
            "Semua field harus diisi dan gambar harus dipilih!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        isLoading.value = true; // Set status loading ke true

        try {
          var urlImage = prod.image;

          if (file.value != null) {
            final image = file.value?.file;
            final ext = file.value!.nama.split('.').last;

            final timestamp = DateTime.now().millisecondsSinceEpoch;
            final fileName = "img_$timestamp.$ext";

            urlImage =
                await ss.uploadFile(image!, "uploads", "product", fileName);
          }

          await fs.updateDataSpecifictDoc("produk", prod.id.toString(), {
            "nama": nama,
            "harga": int.parse(harga),
            "jumlah": int.parse(jumlah),
            "noHp": noHp,
            "image": urlImage,
          });

          Get.snackbar(
            "Success",
            "Produk berhasil ditambahkan!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          mapsController.reset();

          c.changePage(managementProductScreenRoute);
        } catch (e) {
          Get.snackbar("Error", "Gagal menambahkan produk: $e",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              maxWidth: 300);
        } finally {
          isLoading.value = false; // Set status loading ke false
        }
      }

      return Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: file.value != null
                  ? Image.memory(
                      file.value!.file!,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      prod.image
                          .toString(), // Gantilah URL dengan gambar default jika tidak ada file
                      fit: BoxFit.cover,
                    ),
            ),
            V(16),
            ButtonComponent(
              "Edit gambar",
              onPressed: onPickImage,
              color: primaryColor,
              size: 12,
            ),
            const SizedBox(
              height: 24,
            ),
            TextfieldComponent(
              controller: namaController,
              hintText: "Nama",
              size: 14,
            ),
            V(16),
            Row(
              children: [
                Expanded(
                    child: TextfieldComponent(
                  controller: hargaController,
                  hintText: "Harga",
                  size: 14,
                  inputType: TextInputType.number,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      // bottom: 12,
                      left: 16,
                    ), // Padding untuk jarak horizontal
                    child: Text(
                      'Rp.',
                      style: TextStyle(
                          color: inputTextColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
                H(16),
                Expanded(
                  child: TextfieldComponent(
                      controller: jumlahController,
                      hintText: "Jumlah",
                      size: 14,
                      inputType: TextInputType.number),
                )
              ],
            ),
            V(16),
            TextfieldComponent(
              controller: noHpController,
              hintText: "855555",
              size: 14,
              inputType: TextInputType.phone,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 8), // Padding untuk jarak horizontal
                child: Text(
                  '+62',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            V(24),
            Obx(() {
              return Container(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: isLoading.value
                      ? null
                      : onEdit, // Disable button while loading
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                  ),
                  child: isLoading.value
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text("Loading..."),
                          ],
                        )
                      : const TextComponent(
                          "Ubah",
                          color: Colors.white,
                          size: 14,
                        ),
                ),
              );
            }),
          ],
        ),
      );
    }, Rx<FileModel?>(null));
  }
}
