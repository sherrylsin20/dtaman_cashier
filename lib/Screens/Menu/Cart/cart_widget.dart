import 'package:dtaman_cashier/Screens/Menu/Cart/CartItemList/cart_item_list_widget.dart';
import 'package:dtaman_cashier/Screens/Menu/menu_service.dart';
import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:dtaman_cashier/Widgets/FlexibleWidthButton/flexible_width_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  void refresh() {
    setState(() {});
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Current order', style: Get.theme.textTheme.headline1),
                InkWell(
                  onTap: () {
                    clearCart();
                    setState(() {});
                  },
                  child:
                      Text('Clear order', style: Get.theme.textTheme.subtitle1),
                ),
              ],
            ),
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
            CartItemListWidget(refreshParent: refresh),
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
                  currencyWithSymbolFormatter(getTotal()),
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
                    buttonText: 'Save Order',
                    textColor: Get.theme.highlightColor,
                    buttonColor: Get.theme.disabledColor,
                    onButtonTap: () {}),
                const SizedBox(
                  width: 12,
                ),
                FlexibleWidthButtonWidget(
                    buttonText: 'Pay',
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
