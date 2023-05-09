import 'dart:developer';

import 'package:dtaman_cashier/Screens/Menu/AddToCartPopUp/add_to_cart_pop_up_widget.dart';
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
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 24,
                  color: Get.theme.shadowColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              widget.item['availability'] ? 'Available' : 'Not Available',
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 18,
                  color: widget.item['availability']
                      ? Get.theme.focusColor
                      : Get.theme.errorColor,
                  fontWeight: FontWeight.bold),
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
                  style: TextStyle(
                    color: Get.theme.shadowColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.item['availability']
                        ? showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext builder) {
                              return Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  color: Colors.transparent,
                                  height: Get.size.height,
                                  child: Center(
                                    child: AddToCartPopUpWidget(
                                        item: widget.item,
                                        refreshParent: widget.refreshMenuState),
                                  ));
                            })
                        : null;
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: widget.item['availability']
                            ? Get.theme.primaryColor
                            : Get.theme.disabledColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
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
