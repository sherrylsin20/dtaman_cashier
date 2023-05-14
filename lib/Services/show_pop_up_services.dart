import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showPopup(BuildContext context, Widget popUp) {
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext builder) {
        return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            color: Colors.transparent,
            height: Get.size.height,
            child: Center(child: popUp));
      });
}
