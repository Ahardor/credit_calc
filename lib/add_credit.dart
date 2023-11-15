import 'dart:math';

import 'package:credit_calc/parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddEditCredit extends StatefulWidget {
  const AddEditCredit({super.key});

  @override
  State<AddEditCredit> createState() => _AddEditCreditState();
}

class _AddEditCreditState extends State<AddEditCredit> {
  int selectedType = 1;

  double creditAmount = 0,
      interestRate = 0,
      notaryServices = 0,
      depositCost = 0;

  int creditPeriod = 0;

  void calcPayments() {
    var monthlyRate = (interestRate / 100) / 12;

    setState(() {
      outputs["Monthly payments"] = creditAmount *
          (monthlyRate +
              monthlyRate / (pow((1 + monthlyRate), creditPeriod) - 1));
      outputs["Total payments"] = outputs["Monthly payments"]! * creditPeriod;
      outputs["Full cost of credit"] =
          outputs["Monthly payments"]! + notaryServices + depositCost;
      outputs["Overpayment"] = outputs["Total payments"]! - creditAmount;
    });
  }

  var fields = <String, TextEditingController>{
    "Credit amount": TextEditingController(),
    "Interest rate": TextEditingController(),
    "Credit period": TextEditingController(),
    "Date": TextEditingController(),
    "Notary services": TextEditingController(),
    "Deposit cost": TextEditingController(),
  };

  var suffixes = {
    "Interest rate": "%",
    "Credit period": "months",
    "Credit amount": r"$",
    "Notary services": r"$",
    "Deposit cost": r"$",
  };

  var outputs = <String, double>{
    "Total payments": 0,
    "Monthly payments": 0,
    "Full cost of credit": 0,
    "Overpayment": 0,
  };

  String formatDate(DateTime dt) {
    return DateFormat("dd.MM.yyyy").format(dt);
  }

  @override
  void initState() {
    fields["Date"]!.text = formatDate(DateTime.now());
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
                onTap: () {},
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
                child: Column(children: <Widget>[
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
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 13, top: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
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
                  for (var i in fields.keys)
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      color: Colors.white,
                      child: TextField(
                        // controller: fields[i],
                        onChanged: (value) {
                          setState(() {
                            switch (i) {
                              case "Credit amount":
                                creditAmount = double.parse(value);
                                break;
                              case "Interest rate":
                                interestRate = double.parse(value);
                                break;
                              case "Credit period":
                                creditPeriod = int.parse(value);
                                break;
                              case "Notary services":
                                notaryServices = double.parse(value);
                                break;
                              case "Deposit cost":
                                depositCost = double.parse(value);
                                break;
                              default:
                                break;
                            }
                          });

                          calcPayments();
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
                                    fields["Date"]!.text = formatDate(value);
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
                          suffixText: suffixes[i] != null ? suffixes[i]! : null,
                        ),
                      ),
                    ),
                ]),
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
                  for (var i in outputs.keys)
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
                            "${outputs[i]} \$",
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
