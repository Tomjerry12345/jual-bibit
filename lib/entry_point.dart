import 'package:animations/animations.dart';
import 'package:get/get.dart';
import 'package:qurban_mart/controller/auth_controller.dart';
import 'package:qurban_mart/controller/produk_controller.dart';
import 'package:qurban_mart/route/route_constants.dart';
import 'package:qurban_mart/screens/checkout/views/cart_screen.dart';
import 'package:qurban_mart/screens/home/views/home_screen.dart';
import 'package:qurban_mart/screens/profile/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qurban_mart/constants.dart';
import 'package:qurban_mart/theme/colors.dart';
import 'package:qurban_mart/values/output_utils.dart';
// import 'package:ecommerce_zoo/route/screen_export.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final authController = Get.put(AuthController());
  final produkController = Get.put(ProdukController());

  final List _pages = const [
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;

  Future<void> _loadUserName() async {
    authController.getCurrentUser();
    logO(authController.currentUser.value);
  }

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return Obx(() {
      _loadUserName();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: const SizedBox(),
          leadingWidth: 0,
          centerTitle: false,
          title: Text(
            "Jual Bibit",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
          // SvgPicture.asset(
          //   "assets/logo/Shoplon.svg",
          //   colorFilter: ColorFilter.mode(
          //       Theme.of(context).iconTheme.color!, BlendMode.srcIn),
          //   height: 20,
          //   width: 100,
          // )
          ,
          actions: [
            (authController.currentUser.value == "")
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            logInScreenRoute,
                            ModalRoute.withName(entryPointScreenRoute));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Colors.transparent, // Menghapus background
                        padding:
                            EdgeInsets.zero, // Menghilangkan padding default
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        // body: _pages[_currentIndex],
        body: PageTransitionSwitcher(
          duration: defaultDuration,
          transitionBuilder: (child, animation, secondAnimation) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondAnimation,
              child: child,
            );
          },
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: defaultPadding / 2),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              if (index != _currentIndex) {
                produkController.reset();
                if (index == 1 || index == 2) {
                  if ((authController.currentUser.value == "")) {
                    Navigator.pushNamedAndRemoveUntil(context, logInScreenRoute,
                        ModalRoute.withName(entryPointScreenRoute));
                    return;
                  }
                }
                setState(() {
                  _currentIndex = index;
                });
              }
            },
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF101015),
            type: BottomNavigationBarType.fixed,
            // selectedLabelStyle: TextStyle(color: primaryColor),
            selectedFontSize: 12,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                icon: svgIcon("assets/icons/Shop.svg"),
                activeIcon:
                    svgIcon("assets/icons/Shop.svg", color: primaryColor),
                label: "Shop",
              ),
              BottomNavigationBarItem(
                icon: svgIcon("assets/icons/Bag.svg"),
                activeIcon:
                    svgIcon("assets/icons/Bag.svg", color: primaryColor),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: svgIcon("assets/icons/Profile.svg"),
                activeIcon:
                    svgIcon("assets/icons/Profile.svg", color: primaryColor),
                label: "Profile",
              ),
            ],
          ),
        ),
      );
    });
  }
}
