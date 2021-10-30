import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:bitcoin_calculator/util/bitcoin_api_tool.dart';
import 'package:bitcoin_calculator/util/conversion_tools.dart';
import 'package:bitcoin_calculator/config/globals.dart' as globals;

class MockClient extends Mock implements http.Client {}

void main() {
  // HAPPY PATH for API
  test('returns a float if the http call completes successfully', () async {
    final client = MockClient();
    final fakeBtcAPIData = '{"bpi": {"USD": {"rate_float": 0.58}}}';

    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    when(client.get(url))
        .thenAnswer((_) async => http.Response(fakeBtcAPIData, 200));

    double amount = await BitCoinAPI.fetchValue(client);
    expect(amount, isA<double>());
    expect(amount, 0.58);
  });

  //SAD PATH for API
  test('throws an exception if the http call completes with an error',
      () async {
    final client = MockClient();

    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    when(client.get(url))
        .thenAnswer((_) async => http.Response('Not found', 400));
    expect(BitCoinAPI.fetchValue(client), throwsException);
  });

  //HAPPY PATHS for CONVERSION TOOL
  test('convert 1 btc to usd', () async {
    double amount = await BitCoinAPI.fetchValue(globals.httpClient);

    double result = ConversionTools.btcToUsd(amount, 1);

    expect(result, isA<double>());
  });

  test('convert 2 btc to usd', () async {
    double amount = await BitCoinAPI.fetchValue(globals.httpClient);

    double result = ConversionTools.btcToUsd(amount, 2);

    expect(result, isA<double>());
  });

  test('convert 61,909.20 usd to btc', () async {
    double amount = await BitCoinAPI.fetchValue(globals.httpClient);

    double result = ConversionTools.usdToBtc(amount, 5000.55);

    expect(result, isA<double>());
  });

  test('function returns a double', () async {
    double amount = await BitCoinAPI.fetchValue(globals.httpClient);

    double result = ConversionTools.usdToBtc(amount, 10001.1);

    expect(result, isA<double>());
  });
}
