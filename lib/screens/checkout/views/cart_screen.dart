import 'package:get/get.dart';
import 'package:qurban_mart/constants.dart';
import 'package:flutter/material.dart';
import 'package:qurban_mart/controller/auth_controller.dart';
import 'package:qurban_mart/controller/cart_controller.dart';
import 'package:qurban_mart/screens/checkout/views/components/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final authController = Get.find<AuthController>();
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Text(
                    "Produk tersimpan",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                // const TabTransaction(),
              ],
            ),
          ),
          // SliverFillRemaining(hasScrollBody: false, child: DataCart())
          // DataCart()
          Obx(() {
            final username = authController.currentUser.value;
            cartController.getDataCart(username);

            final dataCart = cartController.cartData.value;

            if (dataCart.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(child: Text("Data cart tidak ada")),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = dataCart[index];
                  return Padding(
                    padding: const EdgeInsets.all(defaultPadding - 10),
                    child: CartItem(
                      data: item,
                      // produk: product[index],
                    ),
                  );
                },
                childCount: dataCart.length,
              ),
            );
          })
        ],
      ),
    ));
  }
}
