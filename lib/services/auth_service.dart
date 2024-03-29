import 'dart:convert';

import 'package:bankroll_app/providers/user_provider.dart';
import 'package:bankroll_app/screens/authentication/login/login_screen.dart';
import 'package:bankroll_app/screens/authentication/otp/otp_verification_screen.dart';
import 'package:bankroll_app/utils/constant.dart';
import 'package:bankroll_app/utils/httpErrorHandler.dart';
import 'package:bankroll_app/utils/navigation_menu.dart';
import 'package:bankroll_app/utils/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void register(
      {required BuildContext context,
      required Map<String, dynamic> formData}) async {
    try {
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse("${Constant.uri}/auth/register"),
        body: jsonEncode(formData),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, jsonDecode(res.body)['success'],
                jsonDecode(res.body)['message']);
            final userId = jsonDecode(res.body)['data']['userId'];
            final email = jsonDecode(res.body)['data']['email'];
            navigator.pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => OtpVerificationScreen(
                          userId: userId,
                          email: email,
                        )),
                (route) => false);
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, false, e.toString());
    }
  }

  void login(
      {required BuildContext context,
      required Map<String, dynamic> formData}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse("${Constant.uri}/auth/login"),
        body: jsonEncode(formData),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(jsonDecode(res.body));
          await prefs.setString(
            "access-token",
            jsonDecode(res.body)['token'],
          );
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const NavigationMenu()),
              (route) => false);
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, false, e.toString());
      print(e.toString());
    }
  }

  void verifyOtp(
      {required BuildContext context,
      required String id,
      required Map<String, dynamic> formData}) async {
    try {
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse("${Constant.uri}/auth/verify/$id"),
        body: jsonEncode(formData),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, jsonDecode(res.body)['success'],
              jsonDecode(res.body)['message']);
          navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, false, e.toString());
    }
  }
}
