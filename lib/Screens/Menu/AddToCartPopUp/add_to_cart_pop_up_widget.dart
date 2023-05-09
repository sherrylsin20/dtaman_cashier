import 'package:dtaman_cashier/Screens/Menu/menu_service.dart';
import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:dtaman_cashier/Widgets/FlexibleWidthButton/flexible_width_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddToCartPopUpWidget extends StatefulWidget {
  final dynamic item;
  final Function refreshParent;
  const AddToCartPopUpWidget(
      {Key? key, required this.item, required this.refreshParent})
      : super(key: key);

  @override
  State<AddToCartPopUpWidget> createState() => _AddToCartPopUpWidgetState();
}

class _AddToCartPopUpWidgetState extends State<AddToCartPopUpWidget> {
  TextEditingController notesTextEditingController = TextEditingController();
  int amount = 0;
  bool isTakeaway = false;
  bool showError = false;
  List cartItems = [];

  @override
  void initState() {
    super.initState();
    cartItems = getCurrentCart();
  }

  void addAmount() {
    setState(() {
      amount++;
      showError = false;
    });
  }

  void substractAmount() {
    if (amount > 0) {
      setState(() {
        amount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: Get.size.width * 0.4,
      decoration: BoxDecoration(
        color: Get.theme.highlightColor,
        borderRadius: BorderRadius.circular(20),
      ),
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
            Text(widget.item['name'], style: Get.theme.textTheme.headline1),
            const SizedBox(
              height: 6,
            ),
            Text(
              currencyWithSymbolFormatter(widget.item['price']),
              style: Get.theme.textTheme.headline2,
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
                      onTap: () => substractAmount(),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
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
                      style: Get.theme.textTheme.bodyText1,
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    InkWell(
                      onTap: () => addAmount(),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
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
                        style: Get.theme.textTheme.bodyText1!.apply(
                            color: isTakeaway
                                ? Get.theme.primaryColor
                                : Get.theme.dividerColor),
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
                  style: Get.theme.textTheme.subtitle1,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Notes',
              style: Get.theme.textTheme.bodyText1,
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
                filled: true,
                fillColor: Get.theme.backgroundColor,
                hintText: 'Example: tidak pakai sayur, pedas banget',
                hintStyle: Get.theme.textTheme.bodyText2,
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
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                FlexibleWidthButtonWidget(
                    buttonText: 'Add to cart',
                    textColor: Get.theme.highlightColor,
                    buttonColor: Get.theme.primaryColor,
                    onButtonTap: () {
                      if (amount == 0) {
                        setState(() {
                          showError = true;
                        });
                        return;
                      }

                      var itemDetails = mapToCart(widget.item, amount,
                          isTakeaway, notesTextEditingController.text);
                      addItemToCart(itemDetails);

                      widget.refreshParent();
                      Get.back();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
