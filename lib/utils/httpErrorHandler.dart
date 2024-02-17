import 'dart:convert';

import 'package:bankroll_app/utils/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response response,
  required BuildContext context,
}) {
  showSnackBar(context, jsonDecode(response.body)['success'],
      jsonDecode(response.body)['message']);
}
