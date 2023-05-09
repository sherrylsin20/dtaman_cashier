import 'package:dtaman_cashier/Screens/Menu/Cart/CartItem/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CartItemListWidget extends StatefulWidget {
  static final GlobalKey<_CartItemListWidgetState> globalKey = GlobalKey();
  final Function refreshParent;
  CartItemListWidget({Key? key, required this.refreshParent})
      : super(key: globalKey);

  @override
  State<CartItemListWidget> createState() => _CartItemListWidgetState();
}

class _CartItemListWidgetState extends State<CartItemListWidget> {
  final getStorage = GetStorage('order');

  void refreshList() {
    widget.refreshParent();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      child: ListView.builder(
        itemCount: getStorage.read('currentCart')?.length ?? 0,
        itemBuilder: (context, index) {
          var currentItem = getStorage.read('currentCart')[index];

          return CartItemWidget(
            item: currentItem,
            index: index,
            refreshParent: refreshList,
          );
        },
      ),
    ));
  }
}
