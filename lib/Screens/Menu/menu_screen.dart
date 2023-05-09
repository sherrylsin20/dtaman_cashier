import 'package:dtaman_cashier/Screens/Menu/Cart/cart_service.dart';
import 'package:dtaman_cashier/Screens/Menu/MenuGrid/menu_grid_widget.dart';
import 'package:dtaman_cashier/Screens/Menu/MenuItemCard/menu_item_card_widget.dart';
import 'package:dtaman_cashier/Services/load_menu_services.dart';
import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:dtaman_cashier/Widgets/SearchBox/search_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  List menuItems = [];
  List filteredMenus = [];
  final getStorage = GetStorage('order');
  double totalCart = 0;

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
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchBoxWidget(
                  searchTextEditingController: searchTextEditingController,
                  onChangeText: filterMenu,
                  onClearText: onClearSearch),
              MenuGridWidget(
                menuItems: filteredMenus,
                refreshParent: refresh,
                isMenuEmpty: filteredMenus.isEmpty,
              )
            ],
          ),
        ),
        // Expanded(
        //   child: Container(
        //     padding: const EdgeInsetsDirectional.all(12),
        //     height: Get.size.height,
        //     color: Colors.white,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.max,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisSize: MainAxisSize.max,
        //           children: [
        //             Text(
        //               'Current order',
        //               style: TextStyle(
        //                 fontFamily: 'Lato',
        //                 fontSize: 24,
        //                 color: Get.theme.shadowColor,
        //                 fontWeight: FontWeight.w900,
        //               ),
        //             ),
        //             InkWell(
        //               onTap: () {
        //                 getStorage.remove('currentCart');
        //                 setState(() {});
        //               },
        //               child: Text(
        //                 'Clear order',
        //                 style: TextStyle(
        //                   fontFamily: 'Lato',
        //                   fontSize: 16,
        //                   color: Get.theme.errorColor,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //         const SizedBox(
        //           height: 12,
        //         ),
        //         Divider(
        //           height: 1.75,
        //           color: Get.theme.dividerColor,
        //         ),
        //         const SizedBox(
        //           height: 12,
        //         ),
        //         Expanded(
        //           child: SizedBox(
        //             height: Get.size.height * 0.65,
        //             child: ListView.builder(
        //               itemCount: getStorage.read('currentCart')?.length ?? 0,
        //               itemBuilder: (context, index) {
        //                 Map<String, dynamic> currentItem =
        //                     getStorage.read('currentCart')[index];
        //                 Map<String, dynamic> itemDetails = currentItem['item'];
        //                 totalCart += currentItem['total'];
        //                 return Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     Row(
        //                       mainAxisAlignment: MainAxisAlignment.start,
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       mainAxisSize: MainAxisSize.max,
        //                       children: [
        //                         SizedBox(
        //                           width: 40,
        //                           child: Text(
        //                             '${currentItem['amount'].toString()}x',
        //                             style: TextStyle(
        //                               fontFamily: 'Lato',
        //                               fontSize: 18,
        //                               color: Get.theme.disabledColor,
        //                               fontWeight: FontWeight.bold,
        //                             ),
        //                           ),
        //                         ),
        //                         const SizedBox(
        //                           width: 12,
        //                         ),
        //                         Expanded(
        //                           child: SizedBox(
        //                             child: Text(
        //                               itemDetails['name'].toString(),
        //                               style: TextStyle(
        //                                 fontFamily: 'Lato',
        //                                 fontSize: 18,
        //                                 color: Get.theme.shadowColor,
        //                                 fontWeight: FontWeight.bold,
        //                               ),
        //                             ),
        //                           ),
        //                         ),
        //                         const SizedBox(
        //                           width: 12,
        //                         ),
        //                         SizedBox(
        //                           width: 100,
        //                           child: Text(
        //                             onlyNumbersCurrencyFormatter(
        //                                 currentItem['total']),
        //                             textAlign: TextAlign.right,
        //                             style: TextStyle(
        //                               fontFamily: 'Lato',
        //                               fontSize: 18,
        //                               color: Get.theme.shadowColor,
        //                               fontWeight: FontWeight.bold,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                     const SizedBox(
        //                       height: 6,
        //                     ),
        //                     Row(
        //                       mainAxisAlignment: MainAxisAlignment.start,
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       mainAxisSize: MainAxisSize.max,
        //                       children: [
        //                         const SizedBox(
        //                           width: 40,
        //                         ),
        //                         const SizedBox(
        //                           width: 12,
        //                         ),
        //                         Visibility(
        //                           visible: currentItem['notes'].isNotEmpty,
        //                           child: Expanded(
        //                             child: SizedBox(
        //                               child: Text(
        //                                 currentItem['notes'],
        //                                 style: TextStyle(
        //                                   fontFamily: 'Lato',
        //                                   fontSize: 18,
        //                                   color: Get.theme.disabledColor,
        //                                   fontWeight: FontWeight.bold,
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                     const SizedBox(
        //                       height: 12,
        //                     ),
        //                   ],
        //                 );
        //               },
        //             ),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 12,
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisSize: MainAxisSize.max,
        //           children: [
        //             Text(
        //               'Total',
        //               style: TextStyle(
        //                 fontFamily: 'Lato',
        //                 fontSize: 18,
        //                 color: Get.theme.shadowColor,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             Text(
        //               currencyWithSymbolFormatter(getTotal()),
        //               style: TextStyle(
        //                   fontFamily: 'Lato',
        //                   fontSize: 24,
        //                   color: Get.theme.shadowColor,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //           ],
        //         ),
        //         const SizedBox(
        //           height: 12,
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisSize: MainAxisSize.max,
        //           children: [
        //             InkWell(
        //               onTap: () {},
        //               child: Container(
        //                 height: 60,
        //                 width: 160,
        //                 decoration: BoxDecoration(
        //                   color: Get.theme.disabledColor,
        //                   borderRadius:
        //                       const BorderRadius.all(Radius.circular(20)),
        //                 ),
        //                 child: Center(
        //                   child: Text(
        //                     'Save Order',
        //                     style: TextStyle(
        //                       color: Get.theme.highlightColor,
        //                       fontFamily: 'Lato',
        //                       fontWeight: FontWeight.bold,
        //                       fontSize: 24,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             const SizedBox(
        //               width: 12,
        //             ),
        //             InkWell(
        //               onTap: () {},
        //               child: Container(
        //                 height: 60,
        //                 width: 160,
        //                 decoration: BoxDecoration(
        //                   color: Get.theme.primaryColor,
        //                   borderRadius:
        //                       const BorderRadius.all(Radius.circular(20)),
        //                 ),
        //                 child: Center(
        //                   child: Text(
        //                     'Pay',
        //                     style: TextStyle(
        //                       color: Get.theme.highlightColor,
        //                       fontFamily: 'Lato',
        //                       fontWeight: FontWeight.bold,
        //                       fontSize: 24,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}
