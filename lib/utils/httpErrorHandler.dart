import 'dart:convert';

import 'package:bankroll_app/utils/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response response,
  required BuildContext context,
}) {
  switch (response.statusCode) {
    case 200:
      showSnackBar(context, jsonDecode(response.body)['success'],
          jsonDecode(response.body)['message']);
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['success'],
          jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['success'],
          jsonDecode(response.body)['message']);
      break;
    default:
      showSnackBar(
          context, jsonDecode(response.body)['success'], response.body);
  }
}
