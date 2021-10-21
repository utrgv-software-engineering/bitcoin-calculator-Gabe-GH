import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/input_border.dart';

class BTCtoUSDScreen extends StatefulWidget {
  @override
  State<BTCtoUSDScreen> createState() => _BTCtoUSDScreenState();
}

final convertMon = new TextEditingController();

class _BTCtoUSDScreenState extends State<BTCtoUSDScreen> {
  double btcAmnt = 0;
  var mon2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(25),
          child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Icon(null))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("BTC to USD", key: Key('third-screen-text')),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                Text("${mon2}",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.green,
                    )),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  key: ValueKey('input-field-two'),
                  keyboardType: TextInputType.number,
                  controller: convertMon,
                ),
                Text("Please input a valid BTC amount",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                    )),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    mon2 = convertMon.text;
                  },
                  child: Text('Done'),
                  key: Key('convert-button2'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
