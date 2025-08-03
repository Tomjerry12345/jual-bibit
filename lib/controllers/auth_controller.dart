import 'package:admin_qurban_mart/constants.dart';
import 'package:admin_qurban_mart/values/share_reference_utils.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _refs = SharedPreferenceUtils();

  var isLogging = false.obs;

  void login() {
    _refs.setBool(KEY_ISLOGGING, true);
    getIsLogging();
  }

  void getIsLogging() async {
    final isLog = await _refs.getBool(KEY_ISLOGGING);
    isLogging.value = isLog ?? false;
  }

  void logOut() async {
    _refs.setBool(KEY_ISLOGGING, false);
    getIsLogging();
  }
}
