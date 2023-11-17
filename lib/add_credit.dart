import 'dart:convert';
import 'package:credit_calc/parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEditCredit extends StatefulWidget {
  const AddEditCredit({super.key});

  @override
  State<AddEditCredit> createState() => _AddEditCreditState();
}

class _AddEditCreditState extends State<AddEditCredit> {
  int selectedType = 1;

  Credit credit = Credit(
      creditAmount: 0,
      interestRate: 0,
      creditPeriod: 0,
      type: 1,
      notaryServices: 0,
      depositCost: 0,
      date: "");

  var dateController = TextEditingController();

  var fields = [
    "Credit amount",
    "Interest rate",
    "Credit period",
    "Date",
    "Notary services",
    "Deposit cost",
  ];

  var suffixes = {
    "Interest rate": "%",
    "Credit period": "months",
    "Credit amount": r"$",
    "Notary services": r"$",
    "Deposit cost": r"$",
  };

  var outputs = [
    "Total payments",
    "Monthly payments",
    "Full cost of credit",
    "Overpayment",
  ];

  @override
  void initState() {
    dateController.text = formatDate(DateTime.now());
    credit.date = dateController.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add credit"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: InkWell(
                onTap: () {
                  var currentCredits = prefs.getStringList("credits") ?? [];

                  currentCredits.add(credit.toString());

                  prefs.setStringList("credits", currentCredits);
                  updateHomeList();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.secondTextColor,
                        ),
                      ),
                      // height: 100,
                      child: Column(
                        children: List<Widget>.generate(
                              3,
                              (index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedType = index;
                                    credit.type = index;
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 13, top: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: AppColors.buttonColor,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Image.asset(
                                          "assets/img/${CreditType[index]}.png",
                                          width: 35,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        CreditType[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Spacer(),
                                      if (selectedType == index)
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.buttonColor,
                                          ),
                                          child: const Icon(
                                            Icons.check,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ) +
                            <Widget>[
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                      ),
                    ),
                    for (var i in fields)
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        color: Colors.white,
                        child: TextField(
                          controller: i == "Date" ? dateController : null,
                          onChanged: (value) {
                            setState(() {
                              switch (i) {
                                case "Credit amount":
                                  credit.creditAmount =
                                      value == "" ? 0 : double.parse(value);
                                  break;
                                case "Interest rate":
                                  credit.interestRate =
                                      value == "" ? 0 : double.parse(value);
                                  break;
                                case "Credit period":
                                  credit.creditPeriod =
                                      value == "" ? 0 : int.parse(value);
                                  break;
                                case "Notary services":
                                  credit.notaryServices =
                                      value == "" ? 0 : double.parse(value);
                                  break;
                                case "Deposit cost":
                                  credit.depositCost =
                                      value == "" ? 0 : double.parse(value);
                                  break;
                                default:
                                  break;
                              }
                            });

                            credit.countPayments();
                          },
                          keyboardType: TextInputType.number,
                          readOnly: i == "Date",
                          onTap: i == "Date"
                              ? () {
                                  showDatePicker(
                                    builder: (context, child) => Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: AppColors.buttonColor,
                                        ),
                                      ),
                                      child: child!,
                                    ),
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        dateController.text = formatDate(value);
                                        credit.date = formatDate(value);
                                      });
                                    }
                                  });
                                }
                              : null,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: i == "Date" ? 15 : 18,
                            color: i == "Date"
                                ? AppColors.buttonColor
                                : Colors.black,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'(^\d*\.?\d*)')),
                          ],
                          decoration: InputDecoration(
                            hintText: i,
                            contentPadding: EdgeInsets.zero,
                            suffixText:
                                suffixes[i] != null ? suffixes[i]! : null,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // const Spacer(),
            const SizedBox(
              height: 20,
            ),
            GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 2.2,
                children: [
                  for (var i in outputs)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          color: AppColors.secondTextColor,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            i,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.secondTextColor,
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
                              "Overpayment" =>
                                credit.overpayment.toStringAsFixed(2),
                              _ => "",
                            },
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                ]),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
