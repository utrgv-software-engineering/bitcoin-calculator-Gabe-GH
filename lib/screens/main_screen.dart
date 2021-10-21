import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_calculator/screens/usd_to_btc_screen.dart';
import 'package:bitcoin_calculator/screens/btc_to_usd_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("What type of exchange would you like to make?",
                  key: Key('home-screen-prompt')),
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
                      MaterialPageRoute(builder: (context) => USDtoBTCScreen()),
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
                      MaterialPageRoute(builder: (context) => BTCtoUSDScreen()),
                    );
                  },
                ),
              )
            ]),
      ),
    ));
  }
}
