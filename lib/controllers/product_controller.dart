import 'package:admin_qurban_mart/models/Products.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final product = Product().obs;

  setProduct(Product p) {
    product.value = p;
  }
}
