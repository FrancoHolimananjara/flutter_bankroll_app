// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

import 'package:bankroll_app/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  String id;
  int amount;
  String action;
  String to;
  DateTime date;
  bool failed;
  String of;

  Transaction({
    required this.id,
    required this.amount,
    required this.action,
    required this.to,
    required this.date,
    required this.failed,
    required this.of,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["_id"],
        amount: json["amount"],
        action: json["action"],
        to: json["to"],
        date: DateTime.parse(json["date"]),
        failed: json["failed"],
        of: json["of"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "action": action,
        "to": to,
        "date": date.toIso8601String(),
        "failed": failed,
        "of": of,
      };
}

class TransactionService {
  Future<List<Transaction>> getAllTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("access-token");
    try {
      http.Response res = await http.get(
        Uri.parse('${Constant.uri}/transaction'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body)['transactions'];
        final List<Transaction> transactionList = data.map((transaction) {
          return Transaction.fromJson(transaction);
        }).toList();
        return transactionList;
      } else if (res.statusCode == 404) {
        // Si aucun élément n'est trouvé, retourner une liste vide
        return [];
      } else {
        throw Exception("Failed on fetching: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed on fetching: $e");
    }
  }
}
