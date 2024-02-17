import 'dart:convert';

import 'package:bankroll_app/utils/constant.dart';
import 'package:bankroll_app/utils/httpErrorHandler.dart';
import 'package:bankroll_app/utils/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void register(
      {required BuildContext context,
      required Map<String, dynamic> formData}) async {
    try {
      http.Response res = await http.post(
        Uri.parse("${Constant.uri}/api/auth/register"),
        body: jsonEncode(formData),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandler(response: res, context: context);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, false, e.toString());
    }
  }
}
