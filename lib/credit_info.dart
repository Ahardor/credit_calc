import 'dart:convert';

import 'package:credit_calc/parameters.dart';
import 'package:flutter/material.dart';

class CreditInfo extends StatefulWidget {
  const CreditInfo({super.key});

  @override
  State<CreditInfo> createState() => _CreditInfoState();
}

class _CreditInfoState extends State<CreditInfo> {
  var outputs = [
    "Total payments",
    "Monthly payments",
    "Full cost of credit",
    "Overpayment",
  ];

  late int index;
  double paid = 0;

  @override
  Widget build(BuildContext context) {
    index = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)["index"];

    var credit = Credit.fromJson(
      json: jsonDecode(
        prefs.getStringList("credits")![index],
      ),
    );

    for (var i in credit.history) {
      paid += i.amount;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Credit info"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.secondTextColor,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 15,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${paid.toStringAsFixed(2)} \$",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${credit.totalPayment.toStringAsFixed(2)} \$",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LinearProgressIndicator(
                    value: paid / credit.totalPayment,
                    minHeight: 5,
                    color: AppColors.accentColor,
                    backgroundColor: AppColors.secondTextColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Paid",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.thirdTextColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "Debt",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.thirdTextColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            for (var i in outputs)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      i,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.thirdTextColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      switch (i) {
                        "Total payments" =>
                          credit.totalPayment.toStringAsFixed(2),
                        "Monthly payments" =>
                          credit.monthlyPayment.toStringAsFixed(2),
                        "Full cost of credit" =>
                          credit.fullCost.toStringAsFixed(2),
                        "Overpayment" => credit.overpayment.toStringAsFixed(2),
                        _ => "",
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/addPayment", arguments: {
                  "index": index,
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.buttonColor,
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Center(
                  child: Text(
                    "Add payment",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.mainTextColor,
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Center(
                  child: Text(
                    "Schedule",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.mainTextColor,
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Center(
                  child: Text(
                    "History",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.mainTextColor,
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Center(
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.mainTextColor,
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Center(
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
