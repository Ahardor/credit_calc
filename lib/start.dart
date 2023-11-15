import 'package:credit_calc/parameters.dart';
import 'package:flutter/material.dart';

class StartWidget extends StatefulWidget {
  const StartWidget({super.key});

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

class _StartWidgetState extends State<StartWidget> {
  int currentIndex = 1;
  final heads = [
    "Calculate Your Credit",
    "We value your feedback",
    "Compare Loan Options"
  ];

  final desc = [
    "Input your credit amount, interest rate, and loan term to instantly calculate your monthly payments. This is a valuable tool for managing your finances.",
    "Every day we are getting better due to your ratings and reviews — that helps us protect your accounts.",
    "Explore different credit scenarios to find the one that aligns with your financial goals. Compare various loan amounts, interest rates, and terms.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 600,
            color: Colors.white,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/img/Start$currentIndex.png",
                // height: 600,
              ),
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                Text(
                  heads[currentIndex - 1],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text(
                    desc[currentIndex - 1],
                    style: TextStyle(
                        color: AppColors.secondTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (currentIndex < 3) {
                          currentIndex++;
                        } else {
                          prefs.setBool("start", true);
                          Navigator.of(context).pushReplacementNamed("/main");
                        }
                      });
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 25,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.buttonColor,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 25,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex > 1
                            ? AppColors.buttonColor
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 25,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex > 2
                            ? AppColors.buttonColor
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed("/terms"),
                      child: Text(
                        "Terms of Use",
                        style: TextStyle(
                            color: AppColors.secondTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 1,
                      color: AppColors.secondTextColor,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed("/policy"),
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(
                            color: AppColors.secondTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
