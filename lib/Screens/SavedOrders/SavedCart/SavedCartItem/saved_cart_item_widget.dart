import 'dart:developer';

import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedCartItemWidget extends StatefulWidget {
  // static final GlobalKey<_SavedCartItemWidgetState> globalKey = GlobalKey();
  final Map<String, dynamic> item;
  final int index;
  final Function refreshParent;
  const SavedCartItemWidget(
      {Key? key,
      required this.item,
      required this.index,
      required this.refreshParent})
      : super(key: key);

  @override
  State<SavedCartItemWidget> createState() => _SavedCartItemWidgetState();
}

class _SavedCartItemWidgetState extends State<SavedCartItemWidget> {
  dynamic currentItem;
  dynamic itemDetails;

  @override
  void initState() {
    super.initState();
    currentItem = widget.item;
    itemDetails = currentItem['item'];
  }

  void refresh(value) {
    log('test');
    widget.refreshParent(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  child: Text(itemDetails['name'] ?? '',
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
    );
  }
}
