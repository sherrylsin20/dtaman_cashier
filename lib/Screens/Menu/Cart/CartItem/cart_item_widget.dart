import 'package:dtaman_cashier/Screens/Menu/menu_service.dart';
import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CartItemWidget extends StatefulWidget {
  final Map<String, dynamic> item;
  final int index;
  final Function refreshParent;
  const CartItemWidget(
      {Key? key,
      required this.item,
      required this.index,
      required this.refreshParent})
      : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  Map<String, dynamic> itemDetails = {};

  @override
  void initState() {
    super.initState();
    itemDetails = widget.item['item'];
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              removeItemFromCart(widget.index);
              widget.refreshParent();
              setState(() {});
            },
            backgroundColor: Get.theme.errorColor,
            icon: Icons.delete_rounded,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {
              widget.refreshParent();
              setState(() {});
            },
            backgroundColor: Get.theme.primaryColor,
            icon: Icons.edit_rounded,
            label: 'Edit',
          ),
        ],
      ),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 40,
                  child: Text('${widget.item['amount'].toString()} x',
                      style: Get.theme.textTheme.bodyText1!
                          .apply(color: Get.theme.disabledColor)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    child: Text(itemDetails['name'],
                        style: Get.theme.textTheme.bodyText1),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                    width: 100,
                    child: Text(
                      onlyNumbersCurrencyFormatter(widget.item['total']),
                      textAlign: TextAlign.right,
                      style: Get.theme.textTheme.bodyText1,
                    )),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Visibility(
              visible: widget.item['notes'].isNotEmpty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 52,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        widget.item['notes'],
                        style: Get.theme.textTheme.bodyText1!
                            .apply(color: Get.theme.disabledColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
