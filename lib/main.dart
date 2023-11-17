import 'package:credit_calc/add_credit.dart';
import 'package:credit_calc/add_payment.dart';
import 'package:credit_calc/credit_history.dart';
import 'package:credit_calc/credit_info.dart';
import 'package:credit_calc/credit_schedule.dart';
import 'package:credit_calc/edit_credit.dart';
import 'package:credit_calc/home.dart';
import 'package:credit_calc/parameters.dart';
import 'package:credit_calc/settings.dart';
import 'package:credit_calc/start.dart';
import 'package:credit_calc/terms.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences
      .getInstance(); // Инициализация локального хранилища
  // prefs.clear();

  runApp(const MainApp()); // Запуск приложения
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var startWatched =
        prefs.getBool("start"); // Проверка просмотра стартового экрана

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: startWatched == null || !startWatched
          ? "/start"
          : "/main", // Начальная страница
      // Маршруты экранов
      routes: {
        "/start": (context) => const StartWidget(), // Стартовая страница
        "/terms": (context) =>
            const TermsWidget(), // Страница с пользовательским соглашением
        "/policy": (context) =>
            const PolicyWidget(), // Страница с политикой конфиденциальности
        "/main": (context) => const HomeWidget(), // Главная страница
        "/add": (context) => const AddCredit(), // Страница добавления кредита
        "/info": (context) =>
            const CreditInfo(), // Страница информации о кредите
        "/addPayment": (context) => AddPayment(), // Страница добавления платежа
        "/schedule": (context) =>
            CreditSchedule(), // Страница графика платежей
        "/history": (context) =>
            const CreditHistory(), // Страница истории платежей
        "/editCredit": (context) =>
            const EditCredit(), // Страница редактирования кредита
        "/settings": (context) => const Settings(), // Страница настроек
      },
      // Глобальные настройки дизайна приложения
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
    );
  }
}
