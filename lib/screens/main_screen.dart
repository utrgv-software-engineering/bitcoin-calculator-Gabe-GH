import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bitcoin_calculator/screens/usd_to_btc_screen.dart';
import 'package:bitcoin_calculator/screens/btc_to_usd_screen.dart';
import 'package:bitcoin_calculator/config/globals.dart' as globals;
import '../util/bitcoin_api_tool.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<double> bitCoinValue;
  @override
  void initState() {
    super.initState();
    bitCoinValue = BitCoinAPI.fetchValue(globals.httpClient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<double>(
                  future: bitCoinValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      double BTCvalue = snapshot.data;
                      return Text(
                          "${double.parse(BTCvalue.toString()).toStringAsFixed(2)} USD / BTC",
                          style: TextStyle(fontSize: 35, color: Colors.green));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Text("What type of exchange would you like to make?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                    key: Key('home-screen-prompt')),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  key: Key('usd-text'),
                  child: Text(
                    'USD to BTC',
                    style: TextStyle(color: Colors.blue),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: (BorderRadius.circular(20))),
                  padding: EdgeInsets.only(left: 80, right: 80),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => USDtoBTCScreen(bitCoinValue)),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  key: Key('btc-text'),
                  child: Text(
                    'BTC to USD',
                    style: TextStyle(color: Colors.blue),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: (BorderRadius.circular(20))),
                  padding: EdgeInsets.only(left: 80, right: 80),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BTCtoUSDScreen(bitCoinValue)),
                    );
                  },
                ),
              )
            ]),
      ),
    ));
  }
}
