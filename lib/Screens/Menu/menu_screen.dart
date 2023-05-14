import 'package:dtaman_cashier/Screens/Menu/Cart/CartItemList/cart_item_list_widget.dart';
import 'package:dtaman_cashier/Screens/Menu/Cart/cart_widget.dart';
import 'package:dtaman_cashier/Screens/Menu/MenuGrid/menu_grid_widget.dart';
import 'package:dtaman_cashier/Services/load_menu_services.dart';
import 'package:dtaman_cashier/Widgets/SearchBox/search_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  List menuItems = [];
  List filteredMenus = [];

  @override
  void initState() {
    super.initState();
    loadMenuItems();
  }

  void loadMenuItems() async {
    Map<String, dynamic> menuData = await loadMenu();

    setState(() {
      menuItems = menuData['menu'];
      filteredMenus = menuData['menu'];
    });
  }

  void filterMenu(input) {
    setState(() {
      filteredMenus = menuItems
          .where((item) =>
              item['name'].toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  void onClearSearch() {
    setState(() {
      filteredMenus = menuItems;
    });
  }

  void refresh() {
    loadMenuItems();
    setState(() {});
    CartItemListWidget.globalKey.currentState!.refreshList();
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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SearchBoxWidget(
                      searchTextEditingController: searchTextEditingController,
                      onChangeText: filterMenu,
                      onClearText: onClearSearch),
                ),
                MenuGridWidget(
                  menuItems: filteredMenus,
                  refreshParent: refresh,
                  isMenuEmpty: filteredMenus.isEmpty,
                ),
              ],
            ),
          ),
        ),
        const CartWidget()
      ],
    );
  }
}
