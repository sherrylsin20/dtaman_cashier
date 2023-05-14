import 'package:dtaman_cashier/Screens/PageView/SideMenuButton/side_menu_button_widget.dart';
import 'package:dtaman_cashier/Screens/PageView/page_view_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenuWidget extends StatefulWidget {
  final Function setActivePage;
  const SideMenuWidget({Key? key, required this.setActivePage})
      : super(key: key);

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.1,
      color: Get.theme.highlightColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Get.size.height * 0.8,
            color: Get.theme.highlightColor,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: List<Widget>.generate(menuOptions.length, (index) {
                  dynamic currentMenuOption = menuOptions[index];
                  return InkWell(
                    onTap: () => setState(() {
                      _selectedIndex = index;
                      widget.setActivePage(index);
                    }),
                    child: SideMenuButtonWidget(
                      icon: currentMenuOption['icon'],
                      subtitle: currentMenuOption['subtitle'],
                      isSelected: _selectedIndex == index,
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
}
