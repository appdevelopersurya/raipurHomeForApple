class Formatter {
  static String formatNumber(String numberStr) {
    double? number = double.tryParse(numberStr);

    if (number == null) {
      return numberStr;
    }

    if (number >= 10000000) {
      // Value in crores
      number = number / 10000000;
      String formattedNumber =
          number.toStringAsFixed((number % 1 == 0) ? 0 : 2);
      return '$formattedNumber Cr';
    } else if (number >= 100000) {
      // Value in lakhs
      number = number / 100000;
      String formattedNumber =
          number.toStringAsFixed((number % 1 == 0) ? 0 : 2);
      return '$formattedNumber L';
    } else if (number >= 1000) {
      // Value in thousands
      number = number / 1000;
      String formattedNumber =
          number.toStringAsFixed((number % 1 == 0) ? 0 : 2);
      return '$formattedNumber K';
    } else {
      // Value less than thousand
      return number.toStringAsFixed(0);
    }
  }
}
