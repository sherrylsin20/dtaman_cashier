import 'dart:developer';

import 'package:dtaman_cashier/Screens/Menu/Cart/CartItem/cart_item_widget.dart';
import 'package:dtaman_cashier/Screens/SavedOrders/SavedCart/SavedCartItem/saved_cart_item_widget.dart';
import 'package:dtaman_cashier/Screens/SavedOrders/fixtures.dart';
import 'package:flutter/material.dart';

class SavedCartItemListWidget extends StatefulWidget {
  final Function refresh;
  final dynamic order;
  const SavedCartItemListWidget(
      {Key? key, required this.refresh, required this.order})
      : super(key: key);

  @override
  State<SavedCartItemListWidget> createState() =>
      _SavedCartItemListWidgetState();
}

class _SavedCartItemListWidgetState extends State<SavedCartItemListWidget> {
  int currentOrderIndex = 0;
  dynamic currentOrder;
  List items = [];

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  void loadOrders() async {
    // Map<String, dynamic> savedOrdersData = await loadSavedOrders();

    setState(() {
      var orderResponse = orders['orders'] ?? [];
      currentOrder = orderResponse[currentOrderIndex];
      items = currentOrder['items'];
    });
  }

  void refresh(value) {
    setState(() {
      currentOrderIndex = value;
    });
    widget.refresh(value);
    loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var currentItem = items[index];
          return SavedCartItemWidget(
            item: currentItem,
            index: index,
            refreshParent: refresh,
          );
        },
      ),
    ));
  }
}
