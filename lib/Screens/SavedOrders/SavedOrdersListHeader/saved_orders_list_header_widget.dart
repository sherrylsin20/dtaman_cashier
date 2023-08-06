import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedOrdersListHeaderWidget extends StatefulWidget {
  const SavedOrdersListHeaderWidget({Key? key}) : super(key: key);

  @override
  State<SavedOrdersListHeaderWidget> createState() =>
      _SavedOrdersListHeaderWidgetState();
}

class _SavedOrdersListHeaderWidgetState
    extends State<SavedOrdersListHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.size.width * 0.55,
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100,
            child: Center(
              child: Text(
                'Time',
                style: Get.theme.textTheme.subtitle1!
                    .apply(color: Get.theme.highlightColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: Center(
              child: Text(
                'Order name',
                style: Get.theme.textTheme.subtitle1!
                    .apply(color: Get.theme.highlightColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Center(
              child: Text(
                'Total',
                style: Get.theme.textTheme.subtitle1!
                    .apply(color: Get.theme.highlightColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Center(
              child: Text(
                'Actions',
                style: Get.theme.textTheme.subtitle1!
                    .apply(color: Get.theme.highlightColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
