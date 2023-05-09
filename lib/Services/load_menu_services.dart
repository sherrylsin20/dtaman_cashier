import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> loadMenu() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final String menuResponse = sharedPreferences.getString('menu')!;
  
  return await json.decode(menuResponse);
}
