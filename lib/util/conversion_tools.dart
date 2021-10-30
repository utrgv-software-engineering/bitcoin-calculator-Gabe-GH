class ConversionTools {
  static double btcToUsd(double currentBtcValue, double btc) {
    double returnAmnt;

    btc < 0 ? returnAmnt = 0 : returnAmnt = btc * currentBtcValue;

    return returnAmnt;
  }

  static double usdToBtc(double currentBTCValue, double usd) {
    double returnAmnt;

    usd < 0 ? returnAmnt = 0 : returnAmnt = usd / currentBTCValue;

    return returnAmnt;
  }
}
