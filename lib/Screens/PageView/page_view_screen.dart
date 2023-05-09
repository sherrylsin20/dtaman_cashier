import 'dart:developer';

import 'package:dtaman_cashier/Screens/PageView/SideMenu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController _pageController = PageController();
  final List<dynamic> pageItems = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setActivePage(index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: Get.theme.colorScheme.secondary,
          height: Get.height,
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SideMenuWidget(setActivePage: setActivePage),
              // Expanded(
              //   child: Container(
              //     height: Get.size.height,
              //     color: Get.theme.colorScheme.secondary,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
