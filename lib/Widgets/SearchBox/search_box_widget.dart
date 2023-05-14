import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBoxWidget extends StatefulWidget {
  final TextEditingController searchTextEditingController;
  final Function onChangeText;
  final Function onClearText;
  const SearchBoxWidget(
      {Key? key,
      required this.searchTextEditingController,
      required this.onChangeText,
      required this.onClearText})
      : super(key: key);

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 60,
            child: TextField(
              controller: widget.searchTextEditingController,
              onChanged: (input) {
                widget.onChangeText(input);
              },
              cursorColor: Get.theme.primaryColor,
              style: Get.theme.textTheme.bodyText1,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Get.theme.highlightColor,
                  hintText: 'Search',
                  hintStyle: Get.theme.textTheme.bodyText1!.apply(
                    color: Get.theme.disabledColor
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear_outlined,
                      size: 32,
                      color: Get.theme.dividerColor,
                    ),
                    onPressed: () {
                      widget.searchTextEditingController.clear();
                      widget.onClearText();
                    },
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
