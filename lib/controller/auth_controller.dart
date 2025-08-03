import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qurban_mart/constants.dart';
import 'package:qurban_mart/models/user_model.dart';
import 'package:qurban_mart/services/firebase_services.dart';
import 'package:qurban_mart/services/supabase_services.dart';
import 'package:qurban_mart/values/output_utils.dart';
import 'package:qurban_mart/values/share_reference_utils.dart';

class AuthController extends GetxController {
  var username = ''.obs;
  var namaLengkap = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs; // Status loading
  var selectedImagePath = ''.obs;
  var loadingUploadImage = false.obs;

  var currentUser = ''.obs;

  final _fs = FirebaseServices();
  final _refs = SharedPreferenceUtils();
  final _ss = SupaBaseServices();

  void clearInput() {
    username.value = '';
    namaLengkap.value = '';
    password.value = '';
    selectedImagePath.value = '';
  }

  Future<void> pickImage({required ImageSource source}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    logO("image", m: image?.path);

    if (image != null) {
      selectedImagePath.value = image.path;
    } else {
      Get.snackbar("Error", "No image selected");
    }
  }

  Future<void> editImage(
      {required ImageSource source, required String id}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      loadingUploadImage.value = true;

      File file = File(image.path);
      String fileName =
          "${username.value}_${DateTime.now().millisecondsSinceEpoch}.png";

      final urlImage = await _fs.uploadFile(file, fileName, "user");

      await _fs.updateDataSpecifictDoc("user", id, {
        "image": urlImage,
      });

      loadingUploadImage.value = false;
    } else {
      Get.snackbar("Error", "No image selected");
    }
  }

  Future<void> onClickLogin() async {
    try {
      isLoading.value = true; // Set loading true saat mulai proses
      final hashedPassword =
          sha256.convert(utf8.encode(password.value)).toString();
      final getUsername = await _fs.getDataCollectionByQuery(
          "user", "username", username.value);

      if (getUsername.isNotEmpty) {
        final res = getUsername.first.data();
        final user = UserModel.fromMap(res);

        if (hashedPassword != user.password) {
          throw Exception('Password salah!');
        }

        _refs.setString(KEY_USERNAME, user.username.toString());

        clearInput();
      } else {
        throw Exception('Username tidak terdaftar!');
      }
    } catch (e) {
      logO("error-image", m: e);
      rethrow;
    } finally {
      isLoading.value = false; // Set loading false setelah proses selesai
    }
  }

  Future<void> onClickSignup() async {
    try {
      if (selectedImagePath.value.isNotEmpty) {
        isLoading.value = true; // Set loading true saat mulai proses
        final hashedPassword =
            sha256.convert(utf8.encode(password.value)).toString();
        final checkDuplikat = await _fs.getDataCollectionByQuery(
            "user", "username", username.value);

        if (checkDuplikat.isNotEmpty) {
          throw Exception('Username telah terdaftar');
        }

        File file = File(selectedImagePath.value);
        Uint8List uint8Image = await file.readAsBytes();
        String fileName =
            "${username.value}_${DateTime.now().millisecondsSinceEpoch}.png";

        final urlImage =
            await _ss.uploadFile(uint8Image, "uploads", "user", fileName);

        await _fs.addDataCollection("user", {
          "image": urlImage,
          "username": username.value,
          "namaLengkap": namaLengkap.value,
          "password": hashedPassword,
        });

        _refs.setString(KEY_USERNAME, username.toString());

        clearInput();
      } else {
        throw Exception('Gambar harus di isi!');
      }
    } catch (e) {
      // Tangani kesalahan jika ada
      rethrow;
    } finally {
      isLoading.value = false; // Set loading false setelah proses selesai
    }
  }

  Future<void> updateNamaLengkap(String id, String namaLengkap) async {
    await _fs.updateDataSpecifictDoc("user", id, {
      "namaLengkap": namaLengkap,
    });
  }

  void onLogout() {
    _refs.setString(KEY_USERNAME, "");
  }

  void getCurrentUser() async {
    final current = await _refs.getString(KEY_USERNAME);
    logO("current", m: current);
    currentUser.value = current ?? '';
  }
}
