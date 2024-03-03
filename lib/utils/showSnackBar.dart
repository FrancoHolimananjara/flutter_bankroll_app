// ignore_for_file: file_names

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, bool status, String txt) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: status ? Colors.green[400] : Colors.red[400],
      content: Text(txt),
    ),
  );
}
