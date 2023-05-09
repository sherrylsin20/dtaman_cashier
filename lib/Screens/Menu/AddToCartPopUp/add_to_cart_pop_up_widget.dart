import 'dart:developer';

import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddToCartPopUpWidget extends StatefulWidget {
  final dynamic item;
  final Function() refreshParent;
  const AddToCartPopUpWidget(
      {required this.item, required this.refreshParent, Key? key})
      : super(key: key);

  @override
  State<AddToCartPopUpWidget> createState() => _AddToCartPopUpWidgetState();
}

class _AddToCartPopUpWidgetState extends State<AddToCartPopUpWidget> {
  bool isTakeaway = false;
  int amount = 0;
  bool showError = false;
  TextEditingController notesTextEditingController = TextEditingController();
  final getStorage = GetStorage('order');
  List cartItems = [];

  @override
  void initState() {
    super.initState();
    cartItems = getStorage.read('currentCart') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 24),
      width: Get.size.width * 0.4,
      decoration: BoxDecoration(
          color: Get.theme.highlightColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.clear_outlined,
                  size: 32,
                  color: Get.theme.shadowColor,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              widget.item['name'],
              style: TextStyle(
                fontFamily: 'Lato',
                color: Get.theme.shadowColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              currencyWithSymbolFormatter(widget.item['price']),
              style: TextStyle(
                fontFamily: 'Lato',
                color: Get.theme.errorColor,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => {
                        if (amount > 0)
                          {
                            setState(
                              () {
                                amount--;
                              },
                            )
                          }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Icon(
                            Icons.remove_outlined,
                            color: Get.theme.highlightColor,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Text(
                      amount.toString(),
                      style: TextStyle(
                          color: Get.theme.shadowColor,
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    InkWell(
                      onTap: () => {
                        setState((() {
                          amount++;
                          showError = false;
                        }))
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Icon(
                            Icons.add_outlined,
                            color: Get.theme.highlightColor,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => {
                    setState(() {
                      isTakeaway = !isTakeaway;
                    })
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: isTakeaway
                                    ? Get.theme.primaryColor
                                    : Get.theme.dividerColor,
                                width: 2),
                            color: Get.theme.highlightColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Icon(
                            isTakeaway ? Icons.check_rounded : null,
                            color: Get.theme.primaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Take away',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            color: isTakeaway
                                ? Get.theme.primaryColor
                                : Get.theme.dividerColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: showError,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Text(
                  'Jumlah tidak boleh kosong',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Get.theme.errorColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Notes',
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  color: Get.theme.shadowColor,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: notesTextEditingController,
              maxLines: 4,
              minLines: 4,
              cursorColor: Get.theme.primaryColor,
              decoration: InputDecoration(
                  hintText: 'Example: tidak pakai sayur, pedas banget',
                  hintStyle: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                      color: Get.theme.disabledColor),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Get.theme.backgroundColor),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      log(amount.toString());
                      var notes = isTakeaway
                          ? 'TAKE AWAY${notesTextEditingController.text.isNotEmpty ? ', ${notesTextEditingController.text}' : ''}'
                          : notesTextEditingController.text;
                      if (amount > 0) {
                        Map<String, dynamic> itemDetails = {
                          'item': widget.item,
                          'amount': amount,
                          'isTakeaway': isTakeaway,
                          'notes': notes,
                          'total': widget.item['price'] * amount
                        };
                        log(itemDetails.toString());
                        cartItems.add(itemDetails);
                        getStorage.write('currentCart', cartItems);
                        widget.refreshParent();
                        Get.back();
                        return;
                      }
                      setState(() {
                        showError = true;
                      });
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              color: Get.theme.highlightColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
