import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormTextBoxWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  final Function onChangedText;
  final TextInputType inputType;
  const FormTextBoxWidget(
      {Key? key,
      required this.textEditingController,
      required this.label,
      required this.onChangedText,
      required this.inputType})
      : super(key: key);

  @override
  State<FormTextBoxWidget> createState() => _FormTextBoxWidgetState();
}

class _FormTextBoxWidgetState extends State<FormTextBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontFamily: 'Lato',
            color: Get.theme.disabledColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: TextField(
                  controller: widget.textEditingController,
                  cursorColor: Get.theme.primaryColor,
                  onChanged: (value) => widget.onChangedText(value),
                  keyboardType: widget.inputType,
                  style: Get.theme.textTheme.bodyText2!.apply(
                    color: Get.theme.shadowColor
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Get.theme.backgroundColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.clear_outlined,
                          size: 18,
                          color: Get.theme.dividerColor,
                        ),
                        onPressed: () => widget.textEditingController.clear(),
                      )),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
