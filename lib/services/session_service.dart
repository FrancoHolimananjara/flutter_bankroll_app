import 'dart:convert';

import 'package:bankroll_app/utils/constant.dart';
import 'package:bankroll_app/utils/httpErrorHandler.dart';
import 'package:bankroll_app/utils/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  final DateTime start;
  final DateTime end;
  final int buyin;
  final int buyout;
  final String place;

  const Session({
    required this.start,
    required this.end,
    required this.buyin,
    required this.buyout,
    required this.place,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
        start: json['start'],
        end: json['end'],
        buyin: json['buyin'],
        buyout: json['buyout'],
        place: json['place']);
  }
}

class SessionService {
  void addNewSession({
    required BuildContext context,
    required Map<String, dynamic> formData,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("access-token");
      http.Response res = await http.post(
        Uri.parse('${Constant.uri}/session'),
        body: jsonEncode(formData),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, jsonDecode(res.body)['success'],
              jsonDecode(res.body)['message']);
        },
      );
    } on Exception catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, false, e.toString());
    }
  }
}
