import 'dart:developer';

import 'package:dtaman_cashier/Screens/PageView/page_view_screen.dart';
import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  await GetStorage.init();
  await loadMenu();

  runApp(const CashierApp());
}

Future<void> loadMenu() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.remove('menu');
  String menuResponse = sharedPreferences.getString('menu') ?? '';

  if (menuResponse.isEmpty) {
    String menuFromFile =
        await rootBundle.loadString('assets/fixtures/menuFixtures.json');
    sharedPreferences.setString('menu', menuFromFile);
  }
}

class CashierApp extends StatelessWidget {
  const CashierApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'DTaman Cashier',
        theme: ThemeData(
          primaryColor: const Color(0xFF48AAAD),
          highlightColor: Colors.white,
          shadowColor: const Color(0xFF202020),
          dividerColor: const Color(0xFF565656),
          disabledColor: const Color(0xFFB9B9B9),
          focusColor: const Color(0xFF7BD56C),
          errorColor: const Color(0xFFF74141),
          backgroundColor: const Color(0xFFE6E6E6),
          cardColor: const Color(0xFFE6E6E6),
          textTheme: TextTheme(
            headline1: TextStyle(
                fontFamily: 'Lato',
                color: Get.theme.shadowColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            headline2: TextStyle(
                fontFamily: 'Lato',
                color: Get.theme.errorColor,
                fontSize: 32,
                fontWeight: FontWeight.w900),
            bodyText1: TextStyle(
                fontFamily: 'Lato',
                color: Get.theme.shadowColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            bodyText2: TextStyle(
                fontFamily: 'Lato',
                color: Get.theme.disabledColor,
                fontSize: 16),
            subtitle1: TextStyle(
                fontFamily: 'Lato',
                color: Get.theme.errorColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            caption: TextStyle(
                fontFamily: 'Lato', color: Get.theme.shadowColor, fontSize: 16),
          ),
        ),
        home: const PageViewScreen());
  }
}
