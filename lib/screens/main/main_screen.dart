import 'package:admin_qurban_mart/controllers/MenuAppController.dart';
import 'package:admin_qurban_mart/controllers/auth_controller.dart';
import 'package:admin_qurban_mart/controllers/page_controller.dart';
import 'package:admin_qurban_mart/responsive.dart';
import 'package:admin_qurban_mart/router/router.dart';
import 'package:admin_qurban_mart/router/router_constant.dart';
import 'package:admin_qurban_mart/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:provider/provider.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  final GetxPageController c = Get.put(GetxPageController());

  final fs = FirebaseServices();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Future<void> onLogout() async {
      authController.logOut();
    }

    void onTapDrawer(int i) {
      if (i == 0) {
        c.changePage(managementProductScreenRoute);
      } else if (i == 1) {
        c.changePage(managementTransaksiScreenRoute);
      } else if (i == 2) {
        c.changePage(managementCustomerScreenRoute);
      } else if (i == 3) {
        onLogout();
      }

      c.changeIndexPage(i);
    }

    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: Obx(() => SideMenu(
            index: c.index.value,
            onTapDrawer: onTapDrawer,
          )),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: Obx(() => SideMenu(
                      index: c.index.value,
                      onTapDrawer: onTapDrawer,
                    )),
              ),
            Expanded(
              flex: 5,
              child: Obx(() => generateRoute(c.page.value)),
            ),
          ],
        ),
      ),
    );
  }
}
