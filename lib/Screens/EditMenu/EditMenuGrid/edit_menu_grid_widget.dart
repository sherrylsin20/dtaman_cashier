import 'package:dtaman_cashier/Screens/EditMenu/EditMenuItemCard/edit_menu_item_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/EmptyList/empty_list_widget.dart';

class EditMenuGridWidget extends StatefulWidget {
  final List menuItems;
  final Function refreshParent;
  final bool isMenuEmpty;

  const EditMenuGridWidget(
      {Key? key,
      required this.menuItems,
      required this.refreshParent,
      required this.isMenuEmpty})
      : super(key: key);

  @override
  State<EditMenuGridWidget> createState() => _EditMenuGridWidgetState();
}

class _EditMenuGridWidgetState extends State<EditMenuGridWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: widget.isMenuEmpty
                ? const EmptyListWidget()
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1.5),
                    itemCount: widget.menuItems.length,
                    itemBuilder: (context, index) {
                      var currentMenuItem = widget.menuItems[index];
                      return EditMenuItemCardWidget(
                          item: currentMenuItem,
                          index: index,
                          refreshParent: widget.refreshParent);
                      ;
                    },
                  )
            // : GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 3,
            //         mainAxisSpacing: 12,
            //         crossAxisSpacing: 12,
            //         childAspectRatio: 1),
            //     itemCount: widget.menuItems.length,
            //     itemBuilder: (context, index) {
            //       dynamic currentMenuItem = widget.menuItems[index];
            //       return EditMenuItemCardWidget(
            //           item: currentMenuItem,
            //           index: index,
            //           refreshParent: widget.refreshParent);
            //     },
            //   ),
            ));
  }
}
