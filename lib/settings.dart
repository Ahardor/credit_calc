import 'package:credit_calc/parameters.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: () {}, // TODO
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/Notif.png",
                    width: 30,
                    color: AppColors.buttonColor,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Set reminders",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed("/policy"), // Политика конфиденциальности
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/Shield.png",
                    width: 30,
                    color: AppColors.buttonColor,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Privacy policy",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed("/terms"), // Пользовательское соглашение
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/Doc.png",
                    width: 30,
                    color: AppColors.buttonColor,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Terms of use",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {}, // TODO
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/Ticket.png",
                    width: 30,
                    color: AppColors.buttonColor,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Subscription information",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {}, // TODO
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/Star.png",
                    width: 30,
                    color: AppColors.buttonColor,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Rate our app in the AppStore",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
