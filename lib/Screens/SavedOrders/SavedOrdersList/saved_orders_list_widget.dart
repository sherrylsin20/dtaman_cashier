import 'package:dtaman_cashier/Screens/SavedOrders/SavedOrdersItem/saved_orders_item_widget.dart';
import 'package:dtaman_cashier/Widgets/EmptyList/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedOrdersListWidget extends StatefulWidget {
  final List orderItems;
  final Function refreshParent;
  final bool isOrderEmpty;
  final Function onSelect;
  final int currentSelectedIndex;
  const SavedOrdersListWidget(
      {Key? key,
      required this.orderItems,
      required this.refreshParent,
      required this.isOrderEmpty,
      required this.onSelect,
      required this.currentSelectedIndex})
      : super(key: key);

  @override
  State<SavedOrdersListWidget> createState() => _SavedOrdersListWidgetState();
}

class _SavedOrdersListWidgetState extends State<SavedOrdersListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: Get.size.width * 0.55,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: widget.isOrderEmpty
            ? const EmptyListWidget()
            : ListView.builder(
                itemCount: widget.orderItems.length,
                itemBuilder: (context, index) {
                  dynamic currentOrderItem = widget.orderItems[index];
                  return InkWell(
                    onTap: () => widget.onSelect(index),
                    child: SavedOrdersItemWidget(
                      order: currentOrderItem,
                      refreshParent: widget.refreshParent,
                      isSelected: index == widget.currentSelectedIndex,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
