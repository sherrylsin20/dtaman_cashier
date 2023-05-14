import 'dart:developer';

import 'package:dtaman_cashier/Screens/Menu/AddToCartPopUp/add_to_cart_pop_up_widget.dart';
import 'package:dtaman_cashier/Services/show_pop_up_services.dart';
import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuItemCardWidget extends StatefulWidget {
  final dynamic item;
  final Function() refreshMenuState;
  const MenuItemCardWidget(
      {Key? key, required this.item, required this.refreshMenuState})
      : super(key: key);

  @override
  State<MenuItemCardWidget> createState() => _MenuItemCardWidgetState();
}

class _MenuItemCardWidgetState extends State<MenuItemCardWidget> {
  String _getAvailability(bool availability) {
    return availability ? 'Available' : 'Not Available';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 240,
      decoration: BoxDecoration(
          color: Get.theme.highlightColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              widget.item['name'],
              style: Get.theme.textTheme.headline1,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              _getAvailability(widget.item['availability']),
              style: Get.theme.textTheme.bodyText1!.apply(
                  color: widget.item['availability']
                      ? Get.theme.focusColor
                      : Get.theme.errorColor),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  currencyWithSymbolFormatter(widget.item['price']),
                  style: Get.theme.textTheme.headline1,
                ),
                InkWell(
                  onTap: () {
                    widget.item['availability']
                        ? showPopup(
                            context,
                            AddToCartPopUpWidget(
                                item: widget.item,
                                refreshParent: widget.refreshMenuState))
                        : null;
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: widget.item['availability']
                            ? Get.theme.primaryColor
                            : Get.theme.disabledColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Icon(
                        Icons.add_outlined,
                        size: 32,
                        color: Get.theme.highlightColor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
