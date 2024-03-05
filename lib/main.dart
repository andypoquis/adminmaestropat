import 'package:adminmaestropat/app/bindings/auth_binding.dart';
import 'package:adminmaestropat/app/bindings/navigationmenu_binding.dart';
import 'package:adminmaestropat/app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/ui/theme/colors_app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error al inicializar Firebase: $e');
    // Manejar el error de inicialización de Firebase según sea necesario
  }
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.AUTH,
    theme: ThemeData(
        colorScheme: const ColorScheme.light(
            primary: primaryColor,
            onPrimary: primaryColor,
            background: primaryColor,
            primaryContainer: primaryColor),
        primaryColor: primaryColor,
        focusColor: primaryColor,
        primaryColorDark: primaryColor,
        primaryColorLight: primaryColor,
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: primaryColor,
          hoverColor: primaryColor,
          fillColor: primaryColor,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: primaryColor, width: 0, style: BorderStyle.solid)),
        )),
    defaultTransition: Transition.fade,
    initialBinding: AuthBinding(),
    getPages: AppPages.pages,
  ));
}
