import 'package:flutter/material.dart';

import 'bottom_navigation_item.dart';

class BottomNavigationBarX extends StatelessWidget {
  final int currentIndex;
  final Color? color;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final Function(int index)? onTap;
  final List<IconData> children;

  const BottomNavigationBarX({Key? key, this.currentIndex = 0, this.borderRadius = BorderRadius.zero, this.color, this.height = 56, this.onTap, this.children = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height + MediaQuery.of(context).padding.bottom,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color ?? theme.bottomNavigationBarTheme.backgroundColor,
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _createItems(context),
      ),
    );
  }

  List<Widget> _createItems(BuildContext context) {
    List<Widget> items = [];
    for (int i = 0; i < children.length; i++) {
      items.add(BottomNavigationItem(children[i], currentIndex == i, () => onTap!(i)));
    }

    return items;
  }
}
