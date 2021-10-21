class ConversionTools {
  static double btcToUsd(double btc) {
    return btc * 61909.20;
  }

  static double usdToBtc(double usd) {
    double returnAmnt;

    usd < 0 ? returnAmnt = 0 : returnAmnt = usd / 61909.20;

    return returnAmnt;
  }
}
