import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:qurban_mart/constants.dart';
import 'package:qurban_mart/firebase_options.dart';
import 'package:qurban_mart/route/route_constants.dart';
import 'package:qurban_mart/theme/app_theme.dart';
import 'package:qurban_mart/route/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: baseUrl,
    anonKey: apiKey,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Penjualan bibit',
      theme: AppTheme.lightTheme(context),
      // Dark theme is inclided in the Full template
      themeMode: ThemeMode.light,
      onGenerateRoute: router.generateRoute,
      // initialRoute: onbordingScreenRoute,
      initialRoute: entryPointScreenRoute,
    );
  }
}
