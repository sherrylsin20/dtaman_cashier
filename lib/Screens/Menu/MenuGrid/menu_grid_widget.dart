import 'dart:developer';

import 'package:dtaman_cashier/Screens/Menu/MenuItemCard/menu_item_card_widget.dart';
import 'package:dtaman_cashier/Widgets/EmptyList/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuGridWidget extends StatefulWidget {
  final List menuItems;
  final Function() refreshParent;
  final bool isMenuEmpty;
  const MenuGridWidget(
      {Key? key,
      required this.menuItems,
      required this.refreshParent,
      required this.isMenuEmpty})
      : super(key: key);

  @override
  State<MenuGridWidget> createState() => _MenuGridWidgetState();
}

class _MenuGridWidgetState extends State<MenuGridWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: Get.size.width * 0.55,
      padding: const EdgeInsets.all(24),
      child: widget.isMenuEmpty
          ? const EmptyListWidget()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.6),
              itemCount: widget.menuItems.length,
              itemBuilder: (context, index) {
                dynamic currentMenuItem = widget.menuItems[index];
                return MenuItemCardWidget(
                    item: currentMenuItem,
                    refreshMenuState: widget.refreshParent);
              },
            ),
    ));
  }
}
