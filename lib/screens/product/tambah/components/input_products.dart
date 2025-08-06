import 'package:admin_qurban_mart/components/button/button_component.dart';
import 'package:admin_qurban_mart/components/text/text_component.dart';
import 'package:admin_qurban_mart/components/textfield/textfield_component.dart';
import 'package:admin_qurban_mart/constants.dart';
import 'package:admin_qurban_mart/controllers/maps_controller.dart';
import 'package:admin_qurban_mart/controllers/page_controller.dart';
import 'package:admin_qurban_mart/models/File.dart';
import 'package:admin_qurban_mart/models/Products.dart';
import 'package:admin_qurban_mart/router/router_constant.dart';
import 'package:admin_qurban_mart/screens/product/map/maps_screen.dart';
import 'package:admin_qurban_mart/services/firebase_services.dart';
import 'package:admin_qurban_mart/services/supabase_services.dart';
import 'package:admin_qurban_mart/values/position_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

class InputProducts extends StatelessWidget {
  final GetxPageController c = Get.find();
  final mapsController = Get.put(MapsController());
  final fs = FirebaseServices();
  final ss = SupaBaseServices();

  final List<String> kurbanItems = ['Konsumsi', 'Kurban', "Akikah"];

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final jumlahController = TextEditingController();
  final noHpController = TextEditingController();
  final jenisBibitController = TextEditingController();
  final umurBibitController = TextEditingController();
  final asalBibitController = TextEditingController();

  final isLoading = false.obs; // Observable untuk status loading

  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<FileModel?>>((file) {
      // if (mapsController.latLng.value != null) {
      //   final valMaps = mapsController.latLng.value;
      //   latController.text = valMaps!.latitude.toString();
      //   lngController.text = valMaps.longitude.toString();
      // }

      void onPickMaps() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Dialog(
                    insetPadding: const EdgeInsets.symmetric(horizontal: 150),
                    child: Stack(
                      children: [
                        Container(
                            width: double.infinity,
                            height: 620,
                            padding: const EdgeInsets.all(20),
                            child: MapsScreen()),
                      ],
                    ));
              });
            });
      }

      // void onSelectedDropdown(String item) {
      //   logO("item", m: item);
      //   kategoriController.text = item;
      // }

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

      Future<void> onTambah() async {
        final nama = namaController.text;
        final harga = hargaController.text;
        final jumlah = jumlahController.text;
        final noHp = noHpController.text;
        final jenisBibit = jenisBibitController.text;
        final umurBibit = umurBibitController.text;
        final asalBibit = asalBibitController.text;

        if (
            // nama.isEmpty ||
            //   harga.isEmpty ||
            //   jumlah.isEmpty ||
            //   noHp.isEmpty ||
            file.value == null) {
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

        final image = file.value!.file;
        final ext = file.value!.nama.split('.').last;
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = "img_$timestamp.$ext";

        try {
          final urlImage =
              await ss.uploadFile(image!, "uploads", "product", fileName);

          final product = Product(
            image: urlImage,
            nama: nama,
            noHp: noHp,
            harga: int.parse(harga),
            jumlah: int.parse(jumlah),
            jenisBibit: jenisBibit,
            umurBibit: int.parse(umurBibit),
            asalBibit: asalBibit,
          );

          await fs.addDataCollection("produk", product.toMap());

          Get.snackbar(
            "Success",
            "Produk berhasil ditambahkan!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          c.changePage(managementProductScreenRoute);
        } catch (e) {
          Get.snackbar(
            "Error",
            "Gagal menambahkan produk: $e",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } finally {
          isLoading.value = false; // Set status loading ke false
        }
      }

      return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (file.value != null)
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Image.memory(
                  file.value!.file!,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
            V(16),
            ButtonComponent(
              file.value == null ? "Pilih gambar" : "Edit gambar",
              onPressed: onPickImage,
              color: primaryColor,
              size: 12,
            ),
            SizedBox(
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
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
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
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                    top: 9,
                    // bottom: 12,
                    left: 16,
                    right: 4), // Padding untuk jarak horizontal
                child: Text(
                  '+62',
                  style: TextStyle(
                      color: inputTextColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            V(16),
            Row(
              children: [
                Expanded(
                    child: TextfieldComponent(
                  controller: jenisBibitController,
                  hintText: "Jenis bibit",
                  size: 14,
                )),
                H(16),
                Expanded(
                  child: TextfieldComponent(
                    controller: umurBibitController,
                    hintText: "Umur bibit",
                    size: 14,
                    inputType: TextInputType.number,
                  ),
                )
              ],
            ),
            V(16),
            TextfieldComponent(
              controller: asalBibitController,
              hintText: "Asal bibit",
              size: 14,
            ),
            V(24),
            Obx(() {
              return Container(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: isLoading.value
                      ? null
                      : onTambah, // Disable button while loading
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                  ),
                  child: isLoading.value
                      ? Row(
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
                            TextComponent(
                              "Loading...",
                              color: Colors.white,
                              size: 12,
                            ),
                          ],
                        )
                      : TextComponent(
                          "Tambah",
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
