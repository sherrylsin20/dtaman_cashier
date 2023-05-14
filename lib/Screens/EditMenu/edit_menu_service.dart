import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> mapMenuItem(String name, int price, bool availability) {
  return {'name': name, 'price': price, 'availability': availability};
}

void updateItem(item) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  String menu = sharedPreferences.getString('menu') ?? '';
  Map<String, dynamic> currentMenu = json.decode(menu);
  List menuList = currentMenu['menu'] ?? [];

  int updatedIndex = menuList.indexWhere((menuItem) => menuItem['name'] == item['name']);
  menuList[updatedIndex] = item;
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

void deleteItem(item) async {
  log(item.toString());
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  String menu = sharedPreferences.getString('menu') ?? '';
  Map<String, dynamic> currentMenu = json.decode(menu);
  List<dynamic> menuList = currentMenu['menu'] ?? [];

  menuList.removeWhere((menuItem) => menuItem['name'] == item['name']);
  currentMenu['menu'] = menuList;

  sharedPreferences.setString('menu', json.encode(currentMenu));
}
