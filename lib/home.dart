import 'dart:convert';

import 'package:credit_calc/credit_card.dart';
import 'package:credit_calc/parameters.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  var credits = [];

  void updateList() {
    setState(() {
      credits = [
        for (var i in prefs.getStringList("credits") ?? []) jsonDecode(i)
      ];
    });
  }

  @override
  void initState() {
    updateHomeList = updateList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    updateList();
    return Scaffold(
      backgroundColor: AppColors.secondBgColor,
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Credit calculator",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            )),
        actions: [
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/img/Settings.png",
              width: 30,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: credits.isEmpty
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: credits.isEmpty
                    ? <Widget>[
                        const Text(
                          "It's empty",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Add information about your mortgage by clicking the '
                          '"Add credit info" button',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.secondTextColor,
                          ),
                        ),
                      ]
                    : [
                        for (var i = 0; i < credits.length; i++)
                          CreditCard(
                            index: i,
                          ),
                      ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/add");
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: Text(
                    "Add credit info",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
