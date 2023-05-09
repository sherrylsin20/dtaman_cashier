import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenuButtonWidget extends StatefulWidget {
  final IconData icon;
  final String subtitle;
  final bool isSelected;
  const SideMenuButtonWidget(
      {Key? key,
      required this.icon,
      required this.subtitle,
      required this.isSelected})
      : super(key: key);

  @override
  State<SideMenuButtonWidget> createState() => _SideMenuButtonWidgetState();
}

class _SideMenuButtonWidgetState extends State<SideMenuButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
                color: widget.isSelected
                    ? Get.theme.primaryColor
                    : Get.theme.highlightColor,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Icon(widget.icon,
                size: 48,
                color: widget.isSelected
                    ? Get.theme.highlightColor
                    : Get.theme.disabledColor)),
        const SizedBox(
          height: 6,
        ),
        Text(
          widget.subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
              color: widget.isSelected
                  ? Get.theme.primaryColor
                  : Get.theme.disabledColor),
        )
      ],
    );
  }
}
