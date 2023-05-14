import 'package:dtaman_cashier/Screens/EditMenu/edit_menu_service.dart';
import 'package:dtaman_cashier/Utilities/string_formatter.dart';
import 'package:dtaman_cashier/Widgets/FlexibleWidthButton/flexible_width_button_widget.dart';
import 'package:dtaman_cashier/Widgets/FormTextBox/form_text_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UpdateMenuItemPopUpWidget extends StatefulWidget {
  final Function refreshParent;
  final dynamic item;
  final int index;
  const UpdateMenuItemPopUpWidget(
      {Key? key,
      required this.refreshParent,
      required this.item,
      required this.index})
      : super(key: key);

  @override
  State<UpdateMenuItemPopUpWidget> createState() =>
      _UpdateMenuItemPopUpWidgetState();
}

class _UpdateMenuItemPopUpWidgetState extends State<UpdateMenuItemPopUpWidget> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();
  bool showNameError = false;
  bool showPriceError = false;

  @override
  void initState() {
    super.initState();

    nameTextEditingController.text = widget.item['name'];
    priceTextEditingController.text =
        onlyNumbersCurrencyFormatter(widget.item['price']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
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
                icon: Icon(
                  Icons.clear_outlined,
                  size: 32,
                  color: Get.theme.shadowColor,
                ),
                onPressed: () => Get.back(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            FormTextBoxWidget(
              textEditingController: nameTextEditingController,
              label: 'Name',
              onChangedText: (value) {
                setState(() {
                  showNameError = false;
                });
              },
              inputType: TextInputType.text,
            ),
            const SizedBox(
              height: 3,
            ),
            Visibility(
              visible: showNameError,
              child: Text(
                'Nama tidak boleh kosong',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Get.theme.errorColor,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            FormTextBoxWidget(
              textEditingController: priceTextEditingController,
              label: 'Price',
              onChangedText: (value) {
                setState(() {
                  showPriceError = false;
                });
                int price = numberFormatter(value);
                String formattedPrice = onlyNumbersCurrencyFormatter(price);
                priceTextEditingController.value = TextEditingValue(
                    text: formattedPrice,
                    selection: TextSelection.fromPosition(
                        TextPosition(offset: formattedPrice.length)));
              },
              inputType: TextInputType.number,
            ),
            const SizedBox(
              height: 3,
            ),
            Visibility(
              visible: showPriceError,
              child: Text(
                'Harga tidak boleh kosong',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Get.theme.errorColor,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              children: [
                FlexibleWidthButtonWidget(
                    buttonText: 'Update item',
                    textColor: Get.theme.highlightColor,
                    buttonColor: Get.theme.primaryColor,
                    onButtonTap: () {
                      bool isNameEmpty = nameTextEditingController.text.isEmpty;
                      bool isPriceEmpty =
                          priceTextEditingController.text.isEmpty;
                      if (isNameEmpty) {
                        setState(() {
                          showNameError = true;
                        });
                      }
                      if (isPriceEmpty) {
                        setState(() {
                          showPriceError = true;
                        });
                      }

                      if (!isNameEmpty && !isPriceEmpty) {
                        var item = mapMenuItem(
                            nameTextEditingController.text,
                            numberFormatter(priceTextEditingController.text),
                            true);
                        updateItem(item);

                        Fluttertoast.showToast(
                            msg: 'Success updating ${widget.item['name']}',
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Get.theme.primaryColor,
                            textColor: Get.theme.highlightColor);

                        widget.refreshParent();
                        Get.back();
                        return;
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
