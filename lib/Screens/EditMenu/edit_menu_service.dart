import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> mapMenuItem(String name, int price, bool availability) {
  return {'name': name, 'price': price, 'availability': availability};
}

void updateItem(item, index) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  String menu = sharedPreferences.getString('menu') ?? '';
  Map<String, dynamic> currentMenu = json.decode(menu);
  List menuList = currentMenu['menu'] ?? [];

  menuList[index] = item;
  currentMenu['menu'] = menuList;

  sharedPreferences.setString('menu', json.encode(currentMenu));
}

void addItem(item) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  String menu = sharedPreferences.getString('menu') ?? '';
  Map<String, dynamic> currentMenu = json.decode(menu);
  List<dynamic> menuList = currentMenu['menu'] ?? [];

  menuList.add(item);
  currentMenu['menu'] = menuList;

  sharedPreferences.setString('menu', json.encode(currentMenu));
}

void deleteItem(index) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  String menu = sharedPreferences.getString('menu') ?? '';
  Map<String, dynamic> currentMenu = json.decode(menu);
  List<dynamic> menuList = currentMenu['menu'] ?? [];

  menuList.removeAt(index);
  currentMenu['menu'] = menuList;

  sharedPreferences.setString('menu', json.encode(currentMenu));
}
