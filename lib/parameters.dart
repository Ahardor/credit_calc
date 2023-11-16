library parameters;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefs;

class AppColors {
  static var darkColor = const Color(0xFF1C1C1E);
  static var buttonColor = const Color(0xFFFF3B30);
  static var textColor = const Color(0xFFFFFFFF);
  static var secondTextColor = const Color(0xFFC7C7CC);
  static var thirdTextColor = const Color(0xFF858585);
  static var secondBgColor = const Color(0xFFFcFcFc);
  static var accentColor = const Color(0xFF34C759);
}

Function updateHomeList = () {};

const CreditType = ["Vehicle", "Personal", "Home"];

Map<String, double> calcPayments({
  double interestRate = 0,
  double creditAmount = 0,
  int creditPeriod = 0,
  double notaryServices = 0,
  double depositCost = 0,
}) {
  var monthlyRate = (interestRate / 100) / 12;
  var result = <String, double>{};

  result["Monthly payments"] = interestRate == 0
      ? creditAmount / creditPeriod
      : creditAmount *
          (monthlyRate +
              monthlyRate / (pow((1 + monthlyRate), creditPeriod) - 1));
  result["Total payments"] = result["Monthly payments"]! * creditPeriod;
  result["Full cost of credit"] =
      result["Monthly payments"]! + notaryServices + depositCost;
  result["Overpayment"] = result["Total payments"]! - creditAmount;

  return result;
}

class Credit {
  Credit({
    this.creditAmount = 0,
    this.interestRate = 0,
    this.creditPeriod = 0,
    this.notaryServices = 0,
    this.depositCost = 0,
    this.history = const [],
    this.type = 0,
  });
  int type;
  double interestRate;
  double creditAmount;
  int creditPeriod;
  double notaryServices;
  double depositCost;
  List<double> history;
}
