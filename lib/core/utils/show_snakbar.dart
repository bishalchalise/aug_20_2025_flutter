// core/utils/show_snakbar.dart
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar
    ..showSnackBar(SnackBar(content: Text(message)));
}
