import 'package:credit_calc/parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPayment extends StatelessWidget {
  AddPayment({super.key});

  TextEditingController amountCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Function(Payment pay) addPayment = (ModalRoute.of(context)!
        .settings
        .arguments as Map<String, dynamic>)["fun"];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add payment",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
              ],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                hintText: "Amount",
                hintStyle: TextStyle(
                  fontSize: 16,
                ),
                suffixText: "\$",
              ),
            ),
            InkWell(
              onTap: () {
                if (amountCtrl.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "Enter amount",
                    ),
                  ));
                } else {
                  var pay = Payment(
                    amount: double.parse(amountCtrl.text),
                    date: formatDateTime(DateTime.now()),
                  );

                  addPayment(pay);

                  Navigator.of(context).pop();
                }
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
          ],
        ),
      ),
    );
  }
}
