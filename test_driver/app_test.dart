// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  // First, define the Finders and use them to locate widgets from the
  // test suite. Note: the Strings provided to the `byValueKey` method must
  // be the same as the Strings we used for the Keys in step 1.

  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });
  group('Conversion App', () {
    test("usd to btc take us to the corresponding screen", () async {
      final findUSDbtn = find.byValueKey("usd-text");
      final findMainScreenPrompt = find.byValueKey('home-screen-prompt');

      expect(await driver.getText(findMainScreenPrompt),
          'What type of exchange would you like you make?');
      // expect(findUSDbtn, "USD to BTC");
      await driver.tap(findUSDbtn);

      final secondScreenText = find.byValueKey('second-screen-text');
      expect(await driver.getText(secondScreenText), 'USD to BTC');
    });

    // test("btc to usd take us to the corresponding screen", () async {
    //   final findBTCtext = find.byValueKey("btc-text");
    //   await driver.tap(findBTCtext);

    //   expect(await driver.getText(findBTCtext), "BTC to USD");
    // });

    test("insert number in input field and convert 61909.20 to 1 btc",
        () async {
      final findInputField = find.byValueKey("input-field-one");
      final convertBtn = find.byValueKey("convert-button");
      final btcAmountText = find.byValueKey("btc-amount-text");

      await driver.tap(findInputField);

      await driver.enterText('61909.20');
      await driver.waitFor(find.text('61909.20'));
      await driver.tap(convertBtn);

      expect(btcAmountText, '1.0');
    });
  });
}
