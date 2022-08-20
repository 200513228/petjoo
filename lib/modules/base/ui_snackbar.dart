import 'package:flutter/material.dart';

SnackBar uiSnackBar(String data) {
  return SnackBar(
    content: Text(data),
    duration: const Duration(seconds: 3),
  );
}
