extension StringExtension on String {
  bool isNumeric() => double.tryParse(this) != null;
}
