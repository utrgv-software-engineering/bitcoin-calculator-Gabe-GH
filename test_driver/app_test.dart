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
  group('Conversion App Happy Paths:', () {
    test("usd to btc take us to the corresponding screen", () async {
      final findUSDbtn = find.byValueKey("usd-text");
      final findMainScreenPrompt = find.byValueKey('home-screen-prompt');

      expect(await driver.getText(findMainScreenPrompt),
          'What type of exchange would you like to make?');
      await driver.tap(findUSDbtn);

      final secondScreenText = find.byValueKey('second-screen-text');
      expect(await driver.getText(secondScreenText), 'USD to BTC');
    });

    test("insert number in input field and convert 61909.20 to 1 btc",
        () async {
      final findInputField = find.byValueKey("input-field-one");
      final convertBtn = find.byValueKey("convert-button");
      final btcAmountText = find.byValueKey("btc-amount-text");

      await driver.tap(findInputField);

      await driver.enterText('61909.20');
      await driver.waitFor(find.text('61909.20'));
      await driver.tap(convertBtn);

      expect(await driver.getText(btcAmountText), '1.0 BTC');
    });

    test("btc to usd take us to the corresponding screen", () async {
      final findBackBtn = find.byValueKey("back-to-main");
      await driver.tap(findBackBtn);

      final findBTCbtn = find.byValueKey("btc-text");
      final findMainScreenPrompt = find.byValueKey('home-screen-prompt');

      expect(await driver.getText(findMainScreenPrompt),
          'What type of exchange would you like to make?');
      await driver.tap(findBTCbtn);

      final thirdScreenText = find.byValueKey('third-screen-text');
      expect(await driver.getText(thirdScreenText), 'BTC to USD');
    });

    test("insert number in input field and convert 1 to 61909.20 usd",
        () async {
      final findInputField = find.byValueKey("input-field-two");
      final convertBtn = find.byValueKey("convert-button-two");
      final usdAmountText = find.byValueKey("usd-amount-text");

      await driver.tap(findInputField);

      await driver.enterText('1');
      await driver.waitFor(find.text('1'));
      await driver.tap(convertBtn);

      expect(await driver.getText(usdAmountText), '61909.2 USD');
    });
  });

// ********************
// SAD PATHS
// ********************
  group('Conversion App Sad Paths:', () {
    test("gets error when trying to convert a negative amount to btc",
        () async {
      final findBackBtn = find.byValueKey("back-to-main");
      await driver.tap(findBackBtn);

      final findUSDbtn = find.byValueKey("usd-text");
      final findMainScreenPrompt = find.byValueKey('home-screen-prompt');

      expect(await driver.getText(findMainScreenPrompt),
          'What type of exchange would you like to make?');
      await driver.tap(findUSDbtn);

      final secondScreenText = find.byValueKey('second-screen-text');
      final findInputField = find.byValueKey("input-field-one");
      final convertBtn = find.byValueKey("convert-button");
      final btcAmountText = find.byValueKey("btc-amount-text");
      final errTxtFinder = find.byValueKey("err-text");

      expect(await driver.getText(secondScreenText), 'USD to BTC');

      await driver.tap(findInputField);

      await driver.enterText('-1');
      await driver.waitFor(find.text('-1'));
      await driver.tap(convertBtn);

      expect(await driver.getText(btcAmountText), '0.0 BTC');
      expect(await driver.getText(errTxtFinder),
          "Please input a valid USD amount");
    });

    test("gets error when trying to convert a non numeric amount to btc",
        () async {
      final findInputField = find.byValueKey("input-field-one");
      final convertBtn = find.byValueKey("convert-button");
      final btcAmountText = find.byValueKey("btc-amount-text");
      final errTxtFinder = find.byValueKey("err-text");

      await driver.tap(findInputField);

      await driver.enterText(',57,');
      await driver.waitFor(find.text(',57,'));
      await driver.tap(convertBtn);

      expect(await driver.getText(btcAmountText), '0.0 BTC');
      expect(await driver.getText(errTxtFinder),
          "Please input a valid USD amount");
    });

    test("gets error when trying to convert a negative amount to usd",
        () async {
      final findBackBtn = find.byValueKey("back-to-main");
      await driver.tap(findBackBtn);

      final findBTCbtn = find.byValueKey("btc-text");
      final findMainScreenPrompt = find.byValueKey('home-screen-prompt');

      expect(await driver.getText(findMainScreenPrompt),
          'What type of exchange would you like to make?');
      await driver.tap(findBTCbtn);

      final thirdScreenText = find.byValueKey('third-screen-text');
      final findInputField = find.byValueKey("input-field-two");
      final convertBtn = find.byValueKey("convert-button-two");
      final btcAmountText = find.byValueKey("usd-amount-text");
      final errTxtFinder = find.byValueKey("err-txt-two");

      expect(await driver.getText(thirdScreenText), 'BTC to USD');

      await driver.tap(findInputField);

      await driver.enterText('-1');
      await driver.waitFor(find.text('-1'));
      await driver.tap(convertBtn);

      expect(await driver.getText(btcAmountText), '0.0 USD');
      expect(await driver.getText(errTxtFinder),
          'Please input a valid BTC amount');
    });

    test("gets error when trying to convert a non numeric amount to btc",
        () async {
      final findInputField = find.byValueKey("input-field-two");
      final convertBtn = find.byValueKey("convert-button-two");
      final btcAmountText = find.byValueKey("usd-amount-text");
      final errTxtFinder = find.byValueKey("err-txt-two");

      await driver.tap(findInputField);

      await driver.enterText(',57,');
      await driver.waitFor(find.text(',57,'));
      await driver.tap(convertBtn);

      expect(await driver.getText(btcAmountText), '0.0 USD');
      expect(await driver.getText(errTxtFinder),
          "Please input a valid BTC amount");
    });
  });
}
