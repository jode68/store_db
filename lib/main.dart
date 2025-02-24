import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_db/bindings/binding.dart';
import 'package:store_db/routes/routes.dart';
import 'package:store_db/utils/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.appTheme(true),
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      initialRoute: Routes.homePage,
      getPages: Routes.routes,
    );
  }
}
