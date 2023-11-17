import 'dart:convert';

import 'package:credit_calc/parameters.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  CreditCard({
    super.key,
    required this.index,
  });

  final index;

  double paid = 0;
  late Credit credit;

  @override
  Widget build(BuildContext context) {
    var creditData = jsonDecode(prefs.getStringList("credits")![index]);
    credit = Credit.fromJson(json: creditData);

    for (var i in credit.history) {
      paid += i.amount;
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/info", arguments: {
          "index": index,
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding:
            const EdgeInsets.only(left: 15, top: 20, bottom: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.secondTextColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.buttonColor,
              ),
              child: Image.asset(
                "assets/img/${CreditType[creditData["type"]]}.png",
                width: 35,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "My credit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Paid $paid \$ out of ${credit.totalPayment.toStringAsFixed(2)} \$",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.thirdTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: LinearProgressIndicator(
                      value: paid / credit.totalPayment,
                      minHeight: 5,
                      color: AppColors.accentColor,
                      backgroundColor: AppColors.secondTextColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
