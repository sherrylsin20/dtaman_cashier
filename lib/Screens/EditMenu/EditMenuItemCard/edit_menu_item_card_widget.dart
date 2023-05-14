import 'package:dtaman_cashier/Screens/EditMenu/DeleteMenuItemPopUp/delete_menu_item_pop_up_widget.dart';
import 'package:dtaman_cashier/Screens/EditMenu/UpdateMenuItemPopUp/update_menu_item_pop_up_widget.dart';
import 'package:dtaman_cashier/Screens/EditMenu/edit_menu_service.dart';
import 'package:dtaman_cashier/Services/show_pop_up_services.dart';
import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditMenuItemCardWidget extends StatefulWidget {
  final dynamic item;
  final int index;
  final Function refreshParent;
  const EditMenuItemCardWidget(
      {Key? key,
      required this.item,
      required this.index,
      required this.refreshParent})
      : super(key: key);

  @override
  State<EditMenuItemCardWidget> createState() => _EditMenuItemCardWidgetState();
}

String _getAvailability(bool availability) {
  return availability ? 'Available' : 'Not Available';
}

class _EditMenuItemCardWidgetState extends State<EditMenuItemCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 240,
      decoration: BoxDecoration(
          color: Get.theme.highlightColor,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
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
              height: 6,
            ),
            Text(
              currencyWithSymbolFormatter(widget.item['price']),
              style: Get.theme.textTheme.headline1!
                  .apply(color: Get.theme.shadowColor, fontWeightDelta: 900),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Switch(
                      value: widget.item['availability'],
                      onChanged: (value) {
                        var updatedItem = widget.item;

                        updatedItem['availability'] = value;
                        updateItem(updatedItem);
                        setState(() {});
                      },
                      activeColor: Get.theme.primaryColor,
                      inactiveThumbColor: Get.theme.disabledColor,
                    ),
                    Text(
                      _getAvailability(widget.item['availability']),
                      style: Get.theme.textTheme.bodyText2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showPopup(
                            context,
                            DeleteMenuItemPopUpWidget(
                                refreshParent: widget.refreshParent,
                                item: widget.item));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Get.theme.errorColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Icon(
                            Icons.delete_rounded,
                            size: 28,
                            color: Get.theme.highlightColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      onTap: () {
                        showPopup(
                            context,
                            UpdateMenuItemPopUpWidget(
                                refreshParent: widget.refreshParent,
                                item: widget.item,
                                index: widget.index));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Get.theme.disabledColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Icon(
                            Icons.edit_rounded,
                            size: 28,
                            color: Get.theme.highlightColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
