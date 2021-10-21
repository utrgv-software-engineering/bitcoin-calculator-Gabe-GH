import 'package:test/test.dart';
import 'package:bitcoin_calculator/util/conversion_tools.dart';

void main() {
  test('2 plus 2 is 4', () {
    int result = 2 + 2;
    expect(result, 4);
  });

  test('convert 1 btc to usd', () {
    double result = ConversionTools.btcToUsd(1);

    expect(result, 61909.20);
  });

  test('convert 2 btc to usd', () {
    double result = ConversionTools.btcToUsd(2);

    expect(result, 123818.40);
  });

  test('convert 61,909.20 usd to btc', () {
    double result = ConversionTools.usdToBtc(61909.20);

    expect(result, 1.0);
  });

  test('convert 123,818.40 usd to btc', () {
    double result = ConversionTools.usdToBtc(123818.40);

    expect(result, 2.0);
  });
}
