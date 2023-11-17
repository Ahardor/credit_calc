library parameters;

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefs;

class AppColors {
  static var darkColor = const Color(0xFF1C1C1E);
  static var buttonColor = const Color(0xFFFF3B30);
  static var buttonSecondColor = const Color(0xFFFBF4F4);
  static var textColor = const Color(0xFFFFFFFF);
  static var mainTextColor = const Color(0xFFDEDEDE);
  static var secondTextColor = const Color(0xFFC7C7CC);
  static var thirdTextColor = const Color(0xFF858585);
  static var secondBgColor = const Color(0xFFFcFcFc);
  static var accentColor = const Color(0xFF34C759);
}

Function updateHomeList = () {};

const CreditType = ["Vehicle", "Personal", "Home"];

String formatDate(DateTime dt) {
  return DateFormat("dd.MM.yyyy").format(dt);
}

String formatDateTime(DateTime dt) {
  return DateFormat("dd.MM.yyyy HH:mm").format(dt);
}

DateTime dateFromString(String s) {
  return DateFormat("dd.MM.yyyy").parse(s);
}

class Credit {
  Credit({
    required this.creditAmount,
    required this.interestRate,
    required this.creditPeriod,
    required this.notaryServices,
    required this.depositCost,
    this.history = const [],
    required this.type,
    required this.date,
    required this.index,
  }) {
    countPayments();
  }

  Credit.fromJson({
    required Map<String, dynamic> json,
    required this.index,
  }) {
    creditAmount = json["creditAmount"];
    interestRate = json["interestRate"];
    creditPeriod = json["creditPeriod"];
    notaryServices = json["notaryServices"];
    depositCost = json["depositCost"];
    type = json["type"];
    date = json["date"];
    history = [for (var i in json["history"]) Payment.fromJson(json: i)];

    countPayments();
  }

  void save() {
    var i = prefs.getStringList("credits")!;
    i[index] = toString();
    prefs.setStringList("credits", i);

    updateHomeList();
  }

  void countPayments() {
    var monthlyRate = (interestRate / 100) / 12;

    monthlyPayment = interestRate == 0
        ? creditAmount / creditPeriod
        : creditAmount *
            (monthlyRate +
                monthlyRate / (pow((1 + monthlyRate), creditPeriod) - 1));
    totalPayment = monthlyPayment * creditPeriod;
    fullCost = totalPayment + notaryServices + depositCost;
    overpayment = totalPayment - creditAmount;
  }

  late int type;
  late double interestRate;
  late double creditAmount;
  late int creditPeriod;
  late double notaryServices;
  late double depositCost;
  late String date;

  int index;

  late List<Payment> history;

  late double monthlyPayment;
  late double totalPayment;
  late double fullCost;
  late double overpayment;

  @override
  String toString() {
    return '{"type": $type, "interestRate": $interestRate, "date": "$date", "creditAmount": $creditAmount, "creditPeriod": $creditPeriod, "notaryServices": $notaryServices, "depositCost": $depositCost, "history": $history}';
  }
}

class Payment {
  Payment({
    this.amount = 0,
    this.date = "",
  });

  Payment.fromJson({
    required Map<String, dynamic> json,
  }) {
    amount = json["amount"];
    date = json["date"];
  }

  late double amount;
  late String date;

  @override
  String toString() {
    return '{"amount": $amount, "date": "$date"}';
  }
}
