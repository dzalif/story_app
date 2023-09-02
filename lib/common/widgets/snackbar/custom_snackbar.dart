import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showError(
      BuildContext context, String? message) {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 1500),
      backgroundColor: Colors.red,
      content: Text(message ?? 'Unknown error'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccess(
      BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 1000),
      backgroundColor: Colors.green,
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void show(
      BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 1000),
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}