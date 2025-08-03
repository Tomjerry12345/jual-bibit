import 'package:admin_qurban_mart/constants.dart';
import 'package:admin_qurban_mart/controllers/MenuAppController.dart';
import 'package:admin_qurban_mart/controllers/auth_controller.dart';
import 'package:admin_qurban_mart/screens/login/login_page.dart';
import 'package:admin_qurban_mart/screens/main/main_screen.dart';
import 'package:admin_qurban_mart/services/firebase_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: baseUrl,
    anonKey: apiKey,
  );
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  final fs = FirebaseServices();

  final authController = Get.put(AuthController());

  @override
  initState() {
    super.initState();
  }

  void onClickLogin(isLogin) {
    setState(() {
      this.isLogin = isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: textColor),
          // textTheme: GoogleFonts.poppinsTextTheme()
          //     .copyWith(
          //       titleMedium: GoogleFonts.poppins(
          //         fontSize: 20,
          //         color: Colors.green,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     )
          //     .apply(bodyColor: Colors.white),
          // canvasColor: secondaryColor,
          // listTileTheme: ListTileThemeData(
          //   selectedColor: Colors.white,
          //   selectedTileColor:
          //       Colors.white.withOpacity(0.2), // Background color when selected
          // ),
        ),
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => MenuAppController(),
              ),
            ],
            child: Obx(() {
              authController.getIsLogging();
              return authController.isLogging.value
                  ? MainScreen()
                  : const LoginPage();
            })));
  }
}
