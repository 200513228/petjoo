import 'package:flutter/material.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';

class SearchBar extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final String? hint;
  final Function(String value)? onQueryChanged;
  final Function()? onTap;
  const SearchBar({Key? key, this.hint, this.margin = EdgeInsets.zero, this.onTap, this.onQueryChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextField(
        readOnly: onTap != null,
        onTap: onTap,
        textInputAction: TextInputAction.search,
        onChanged: onQueryChanged,
        decoration: InputDecoration(
            hintText: hint ?? context.localization.search,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: context.theme.iconTheme.color,
            ),
            contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 12)),
      ),
    );
  }
}
