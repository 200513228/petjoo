import 'package:flutter/material.dart';

class DropdownX<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final Object? hintValue;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry? borderRadius;
  final List<DropdownMenuItem<T>>? items;
  final String? Function(T?)? validator;
  final Function(T?)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final String? label;
  final Color? color;

  const DropdownX(
      {Key? key,
      this.items,
      this.margin = EdgeInsets.zero,
      this.borderRadius,
      this.hint = "",
      this.hintValue,
      this.contentPadding,
      this.value,
      this.validator,
      this.color,
      this.onChanged,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: margin,
      decoration: BoxDecoration(
          color: color ?? theme.colorScheme.surface,
          borderRadius: borderRadius ?? BorderRadius.circular(15)),
      child: DropdownButtonFormField<T>(
          dropdownColor: color ?? theme.colorScheme.surface,
          elevation: 0,
          validator: validator,
          hint: Text(
            hint,
            style: theme.inputDecorationTheme.labelStyle,
          ),
          decoration: InputDecoration(
            fillColor: color ?? theme.colorScheme.surface,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            label: label != null ? Text(label!) : null,
          ),
          value: value == hintValue ? null : value,
          items: items,
          isExpanded: true,
          onChanged: onChanged),
    );
  }
}
