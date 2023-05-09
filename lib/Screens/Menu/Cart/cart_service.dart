import 'dart:developer';

import 'package:get_storage/get_storage.dart';

final getStorage = GetStorage('order');

List getCurrentCart() {
  return getStorage.read('currentCart') ?? [];
}

void removeItemFromCart(index) {
  List currentCart = getStorage.read('currentCart');

  currentCart.removeAt(index);
  getStorage.write('currentCart', currentCart);
}

void clearCart() {
  getStorage.remove('currentCart');
}

int getTotal() {
  double total = 0;
  int currentCartLength = getStorage.read('currentCart')?.length ?? 0;

  if (currentCartLength != 0) {
    for (int x = 0; x < currentCartLength; x++) {
      Map<String, dynamic> currentItem = getStorage.read('currentCart')[x];
      total += currentItem['total'];
    }
    return total.toInt();
  }
  return 0;
}
