import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedOrdersItemWidget extends StatefulWidget {
  final dynamic order;
  final Function refreshParent;
  final bool isSelected;
  const SavedOrdersItemWidget(
      {Key? key,
      required this.order,
      required this.refreshParent,
      required this.isSelected})
      : super(key: key);

  @override
  State<SavedOrdersItemWidget> createState() => _SavedOrdersItemWidgetState();
}

class _SavedOrdersItemWidgetState extends State<SavedOrdersItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: Get.size.width * 0.55,
      decoration: BoxDecoration(
        color: Get.theme.highlightColor,
        border: widget.isSelected
            ? Border.all(
                width: 2,
                color: Get.theme.primaryColor,
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 100,
            child: Center(
              child: Text(
                widget.order['timestamp'],
                style: Get.theme.textTheme.caption,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: Center(
              child: Text(
                widget.order['name'],
                style: Get.theme.textTheme.caption,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Center(
              child: Text(
                currencyWithSymbolFormatter(widget.order['total']),
                style: Get.theme.textTheme.caption,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Get.theme.errorColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.delete_rounded,
                        color: Get.theme.highlightColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Get.theme.focusColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.edit_rounded,
                        color: Get.theme.highlightColor,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
