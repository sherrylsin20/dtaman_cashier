import 'dart:developer';

import 'package:dtaman_cashier/Screens/SavedOrders/SavedCart/SavedCartItem/saved_cart_item_widget.dart';
import 'package:dtaman_cashier/Screens/SavedOrders/SavedCart/saved_cart_widget.dart';
import 'package:dtaman_cashier/Screens/SavedOrders/SavedOrdersList/saved_orders_list_widget.dart';
import 'package:dtaman_cashier/Screens/SavedOrders/SavedOrdersListHeader/saved_orders_list_header_widget.dart';
import 'package:dtaman_cashier/Screens/SavedOrders/fixtures.dart';
import 'package:dtaman_cashier/Screens/SavedOrders/saved_orders_service.dart';
import 'package:dtaman_cashier/Widgets/SearchBox/search_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedOrdersScreen extends StatefulWidget {
  const SavedOrdersScreen({Key? key}) : super(key: key);

  @override
  State<SavedOrdersScreen> createState() => _SavedOrdersScreenState();
}

class _SavedOrdersScreenState extends State<SavedOrdersScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  List savedOrders = [];
  List filteredOrders = [];
  int currentOrderIndex = 0;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  void loadOrders() async {
    List savedOrdersData = await loadSavedOrders();

    setState(() {
      savedOrders = savedOrdersData;
      filteredOrders = savedOrdersData;
    });
  }

  void filterOrders(input) {
    setState(() {
      filteredOrders = savedOrders
          .where((order) =>
              order['name'].toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  void onClearSearch() {
    setState(() {
      filteredOrders = savedOrders;
    });
  }

  void refresh() {
    loadOrders();
    setState(() {});
  }

  void setSelectedOrder(value) {
    log(value.toString());
    setState(() {
      currentOrderIndex = value;
    });
    // SavedCartItemWidget.globalKey.currentState!.refresh(currentOrderIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: SizedBox(
            width: Get.size.width * 0.55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SearchBoxWidget(
                      searchTextEditingController: searchTextEditingController,
                      onChangeText: filterOrders,
                      onClearText: onClearSearch),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SavedOrdersListHeaderWidget()),
                SavedOrdersListWidget(
                    orderItems: filteredOrders,
                    refreshParent: refresh,
                    isOrderEmpty: filteredOrders.isEmpty,
                    onSelect: setSelectedOrder,
                    currentSelectedIndex: currentOrderIndex),
              ],
            ),
          ),
        ),
        SavedCartWidget()
      ],
    );
  }
}
