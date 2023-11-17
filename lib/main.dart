import 'package:credit_calc/add_credit.dart';
import 'package:credit_calc/add_payment.dart';
import 'package:credit_calc/credit_info.dart';
import 'package:credit_calc/home.dart';
import 'package:credit_calc/parameters.dart';
import 'package:credit_calc/start.dart';
import 'package:credit_calc/terms.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  // prefs.clear();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var startWatched = prefs.getBool("start");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: startWatched == null || !startWatched ? "/start" : "/main",
      routes: {
        "/start": (context) => const StartWidget(),
        "/terms": (context) => const TermsWidget(),
        "/policy": (context) => const PolicyWidget(),
        "/main": (context) => const MainWidget(),
        "/add": (context) => const AddEditCredit(),
        "/info": (context) => const CreditInfo(),
        "/addPayment": (context) => AddPayment(),
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.thirdTextColor,
          elevation: 0.4,
          toolbarHeight: 80,
          centerTitle: true,
          shadowColor: null,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        fontFamily: "Satoshi",
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.only(left: 10, right: 10, top: 22, bottom: 22),
          labelStyle: TextStyle(
            color: AppColors.thirdTextColor,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: TextStyle(
            color: AppColors.thirdTextColor,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.secondTextColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.buttonColor,
            ),
          ),
          prefixStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          suffixStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // home: const Scaffold(
      //   body: Center(
      //     child: Text('Hello World!'),
      //   ),
      // ),
    );
  }
}
