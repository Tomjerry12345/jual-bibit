import 'package:admin_qurban_mart/router/router_constant.dart';
import 'package:get/get.dart';

class GetxPageController extends GetxController {
  var page = managementProductScreenRoute.obs;
  var index = 0.obs;
  changePage(String p) {
    page.value = p;
  }

  changeIndexPage(int i) {
    index.value = i;
  }
}
