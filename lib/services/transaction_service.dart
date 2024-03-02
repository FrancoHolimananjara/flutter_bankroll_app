// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

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
