import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyListWidget extends StatefulWidget {
  const EmptyListWidget({Key? key}) : super(key: key);

  @override
  State<EmptyListWidget> createState() => _EmptyListWidgetState();
}

class _EmptyListWidgetState extends State<EmptyListWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.search_off_rounded,
          color: Get.theme.dividerColor,
          size: 64,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          'Nothing found!',
          style: Get.theme.textTheme.bodyText1!
              .apply(color: Get.theme.dividerColor),
        ),
      ],
    ));
  }
}
