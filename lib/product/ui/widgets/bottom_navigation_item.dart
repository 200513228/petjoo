import 'package:flutter/material.dart';

class BottomNavigationItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final Function() onTap;

  const BottomNavigationItem(this.icon, this.isSelected, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarThemeData theme =
        Theme.of(context).bottomNavigationBarTheme;
    return Expanded(
        child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: isSelected ? null : onTap,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TweenAnimationBuilder(
                  tween: ColorTween(
                      begin: isSelected
                          ? theme.unselectedItemColor ?? Colors.grey
                          : theme.selectedItemColor ?? Colors.blue,
                      end: isSelected
                          ? theme.selectedItemColor ?? Colors.blue
                          : theme.unselectedItemColor ?? Colors.grey),
                  duration: const Duration(milliseconds: 300),
                  builder: (_, Color? color, __) => Icon(icon, color: color))
            ])));
  }
}