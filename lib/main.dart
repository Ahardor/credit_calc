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
      },
      theme: ThemeData(fontFamily: "Satoshi"),
      // home: const Scaffold(
      //   body: Center(
      //     child: Text('Hello World!'),
      //   ),
      // ),
    );
  }
}
