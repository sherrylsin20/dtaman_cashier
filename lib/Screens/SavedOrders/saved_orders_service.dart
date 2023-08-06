import 'dart:convert';
import 'dart:developer';

import 'package:dtaman_cashier/Screens/SavedOrders/fixtures.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getStorage = GetStorage('savedOrders');

dynamic getSelectedOrder(index) {
  return getStorage.read('order')[index] ?? {};
}

Future<List> loadSavedOrders() async {
  // final SharedPreferences sharedPreferences =
  //     await SharedPreferences.getInstance();
  // final String orderResponse = sharedPreferences.getString('savedOrders') ?? '';
  Map<String, dynamic> orderResponse = orders;
 
  if (orderResponse.isNotEmpty) {
    getStorage.write('order', orderResponse['orders']);
    log(orderResponse['orders'].toString());
    return orderResponse['orders'];
  }
  return [];
}
