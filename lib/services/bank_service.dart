import 'dart:convert';

import 'package:bankroll_app/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Bankroll {
  final String typeOfGame;
  final int bank;

  const Bankroll({
    required this.typeOfGame,
    required this.bank,
  });

  factory Bankroll.fromJson(Map<String, dynamic> json) {
    return Bankroll(
      typeOfGame: json['typeOfGame'],
      bank: json['bank'] ?? 0,
    );
  }
}

class BankrollService {
  Future<Bankroll> getBankroll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("access-token");
    try {
      http.Response res = await http.get(
        Uri.parse('${Constant.uri}/bankroll'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        final Bankroll data = jsonDecode(res.body)['bankroll'];
        print(data);
        return data;
      } else {
        throw Exception("Failed on fetching: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed on fetching: $e");
    }
  }
}
