import 'package:dtaman_cashier/Screens/EditMenu/edit_menu_service.dart';
import 'package:dtaman_cashier/Widgets/FlexibleWidthButton/flexible_width_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DeleteMenuItemPopUpWidget extends StatefulWidget {
  final Function refreshParent;
  final dynamic item;
  const DeleteMenuItemPopUpWidget(
      {Key? key, required this.refreshParent, required this.item})
      : super(key: key);

  @override
  State<DeleteMenuItemPopUpWidget> createState() =>
      _DeleteMenuItemPopUpWidgetState();
}

class _DeleteMenuItemPopUpWidgetState extends State<DeleteMenuItemPopUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: Get.size.width * 0.4,
      decoration: BoxDecoration(
        color: Get.theme.highlightColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hapus item\n${widget.item['name']} ?',
            style: Get.theme.textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 36,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              FlexibleWidthButtonWidget(
                  buttonText: 'Hapus',
                  textColor: Get.theme.highlightColor,
                  buttonColor: Get.theme.errorColor,
                  onButtonTap: () {
                    deleteItem(widget.item);

                    Fluttertoast.showToast(
                        msg: 'Item ${widget.item['name']} berhasil dihapus',
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Get.theme.primaryColor,
                        textColor: Get.theme.highlightColor);

                    widget.refreshParent();
                    Get.back();
                  }),
              const SizedBox(
                width: 12,
              ),
              FlexibleWidthButtonWidget(
                  buttonText: 'Cancel',
                  textColor: Get.theme.highlightColor,
                  buttonColor: Get.theme.disabledColor,
                  onButtonTap: () {
                    Get.back();
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
