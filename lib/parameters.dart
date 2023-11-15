library parameters;

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
}

const CreditType = ["Vehicle", "Personal", "Home"];
