import 'package:dtaman_cashier/Screens/EditMenu/AddNewMenuItemPopUp/add_new_menu_item_pop_up_widget.dart';
import 'package:dtaman_cashier/Screens/EditMenu/EditMenuGrid/edit_menu_grid_widget.dart';
import 'package:dtaman_cashier/Services/load_menu_services.dart';
import 'package:dtaman_cashier/Services/show_pop_up_services.dart';
import 'package:dtaman_cashier/Widgets/FlexibleWidthButton/flexible_width_button_widget.dart';
import 'package:dtaman_cashier/Widgets/SearchBox/search_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditMenuScreen extends StatefulWidget {
  const EditMenuScreen({Key? key}) : super(key: key);

  @override
  State<EditMenuScreen> createState() => _EditMenuScreenState();
}

class _EditMenuScreenState extends State<EditMenuScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    child: SearchBoxWidget(
                        searchTextEditingController:
                            searchTextEditingController,
                        onChangeText: filterMenu,
                        onClearText: onClearSearch),
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                FlexibleWidthButtonWidget(
                    buttonText: 'Add new item',
                    textColor: Get.theme.highlightColor,
                    buttonColor: Get.theme.primaryColor,
                    onButtonTap: () {
                      showPopup(context,
                          AddNewMenuItemPopUpWidget(refreshParent: refresh));
                    })
              ],
            ),
          ),
          EditMenuGridWidget(
            menuItems: filteredMenus,
            refreshParent: refresh,
            isMenuEmpty: filteredMenus.isEmpty,
          ),
        ],
      ),
    );
  }
}
