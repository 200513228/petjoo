import 'package:flutter/material.dart';

class RadioTile<T> extends StatelessWidget {
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final String text;
  final T value;
  final T? groupValue;
  final void Function(T? value)? onChanged;

  const RadioTile(
      {Key? key,
      required this.text,
      required this.value,
      this.groupValue,
      this.onChanged,
      this.borderRadius,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: borderRadius),
      child: Material(
          color: color ?? Colors.transparent,
          child: InkWell(
              onTap: onChanged == null ? () {} : () => onChanged!(value),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Row(children: [
                    Expanded(
                        flex: 2,
                        child:
                            Text(text, maxLines: 1, style: Theme.of(context).textTheme.bodyText1)),
                    Flexible(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Radio<T>(
                                  value: value,
                                  groupValue: groupValue,
                                  onChanged: onChanged,
                                ))))
                  ])))));
}
