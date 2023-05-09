import 'package:get_storage/get_storage.dart';

final getStorage = GetStorage('order');

List getCurrentCart() {
  return getStorage.read('currentCart') ?? [];
}

String _formatOrderNotes(notes, isTakeaway) {
  String takeawayNotes = isTakeaway ? 'TAKEAWAY' : '';
  String orderNotes = notes.isNotEmpty && isTakeaway ? ', $notes' : '$notes';

  return '$takeawayNotes$orderNotes';
}

Map<String, dynamic> mapToCart(
    dynamic item, int amount, bool isTakeaway, String notes) {
  return {
    'item': item,
    'amount': amount,
    'isTakeaway': isTakeaway,
    'notes': _formatOrderNotes(notes, isTakeaway),
    'total': item['price'] * amount
  };
}

void addItemToCart(item) {
  List currentCart = getStorage.read('currentCart') ?? [];

  currentCart.add(item);
  getStorage.write('currentCart', currentCart);
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
