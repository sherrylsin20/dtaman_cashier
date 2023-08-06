import 'dart:developer';

import 'package:dtaman_cashier/Screens/SavedOrders/SavedCart/SavedCartItemList/saved_cart_item_list_widget.dart';
import 'package:dtaman_cashier/Screens/SavedOrders/fixtures.dart';
import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:dtaman_cashier/Widgets/FlexibleWidthButton/flexible_width_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedCartWidget extends StatefulWidget {
  const SavedCartWidget({Key? key}) : super(key: key);

  @override
  State<SavedCartWidget> createState() => _SavedCartWidgetState();
}

class _SavedCartWidgetState extends State<SavedCartWidget> {
  int currentOrderIndex = 0;
  dynamic currentOrder;

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
    });
  }

  void refresh(value) {
    setState(() {
      currentOrderIndex = value;
    });
    loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsetsDirectional.all(12),
        height: Get.size.height,
        color: Get.theme.highlightColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Order', style: Get.theme.textTheme.headline1),
            const SizedBox(
              height: 12,
            ),
            Divider(
              height: 1.75,
              color: Get.theme.dividerColor,
            ),
            const SizedBox(
              height: 12,
            ),
            SavedCartItemListWidget(
              order: currentOrder,
              refresh: refresh,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Total',
                  style: Get.theme.textTheme.bodyText1,
                ),
                Text(
                  currencyWithSymbolFormatter(20000),
                  style: Get.theme.textTheme.headline1,
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                FlexibleWidthButtonWidget(
                    buttonText: 'Apply Current Order',
                    textColor: Get.theme.highlightColor,
                    buttonColor: Get.theme.primaryColor,
                    onButtonTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
