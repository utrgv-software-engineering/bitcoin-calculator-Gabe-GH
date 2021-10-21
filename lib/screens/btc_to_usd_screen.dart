import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../util/conversion_tools.dart';

class BTCtoUSDScreen extends StatefulWidget {
  @override
  State<BTCtoUSDScreen> createState() => _BTCtoUSDScreenState();
}

final convertMon = new TextEditingController();

class _BTCtoUSDScreenState extends State<BTCtoUSDScreen> {
  double btcAmnt = 0;
  var mon = 0.0;
  var errTxt = '';
  bool errTxtShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                key: Key("back-to-main"),
                icon: Icon(Icons.arrow_back_ios_new,
                    color: Color(0xff4c748b), size: 18),
                onPressed: () => Navigator.of(context).pop())
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("BTC to USD",
                style: TextStyle(fontSize: 40), key: Key('third-screen-text')),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                Text("$mon USD",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.green,
                    ),
                    key: Key("usd-amount-text")),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    suffixText: "BTC",
                  ),
                  key: ValueKey('input-field-two'),
                  keyboardType: TextInputType.number,
                  controller: convertMon,
                ),
                Text(
                  errTxtShow ? "Please input a valid BTC amount" : "",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                  ),
                  key: Key("err-txt-two"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      double amnt = 0;

                      try {
                        double.parse(convertMon.text) < 0
                            ? errTxtShow = true
                            : errTxtShow = false;
                      } on Exception {
                        errTxtShow = true;
                      }

                      try {
                        amnt = double.parse(convertMon.text);
                      } on Exception {
                        errTxtShow = true;
                      }
                      mon = double.parse((ConversionTools.btcToUsd(amnt)).toStringAsFixed(2));
                    });
                  },
                  child: Text('Done'),
                  key: Key('convert-button-two'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
