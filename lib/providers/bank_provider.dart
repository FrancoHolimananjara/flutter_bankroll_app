import 'package:bankroll_app/services/bank_service.dart';
import 'package:flutter/material.dart';

class BankProvider extends ChangeNotifier {
  Bankroll _bank = Bankroll(bank: 0, typeOfgame: '');

  Bankroll get bank => _bank;

  void setBank(dynamic bank) {
    _bank = Bankroll.fromJson(bank);
    notifyListeners();
  }

  void setBankrollFromModel(Bankroll bank) {
    _bank = bank;
    notifyListeners();
  }
}
