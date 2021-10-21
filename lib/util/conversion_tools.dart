class ConversionTools {
  static double btcToUsd(double btc) {
    double returnAmnt;

    btc < 0 ? returnAmnt = 0 : returnAmnt = btc * 61909.20;

    return returnAmnt;
  }

  static double usdToBtc(double usd) {
    double returnAmnt;

    usd < 0 ? returnAmnt = 0 : returnAmnt = usd / 61909.20;

    return returnAmnt;
  }
}
