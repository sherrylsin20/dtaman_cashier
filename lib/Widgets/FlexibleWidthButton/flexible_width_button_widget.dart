import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexibleWidthButtonWidget extends StatefulWidget {
  final String buttonText;
  final Color textColor;
  final Color buttonColor;
  final Function onButtonTap;

  const FlexibleWidthButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.textColor,
      required this.buttonColor,
      required this.onButtonTap})
      : super(key: key);

  @override
  State<FlexibleWidthButtonWidget> createState() =>
      _FlexibleWidthButtonWidgetState();
}

class _FlexibleWidthButtonWidgetState extends State<FlexibleWidthButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => widget.onButtonTap(),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: widget.buttonColor,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: Text(
            widget.buttonText,
            style:
                Get.theme.textTheme.headline1!.apply(color: widget.textColor),
          )),
        ),
      ),
    );
  }
}
