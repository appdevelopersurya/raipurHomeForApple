import '../data/modal/PriceModel.dart';

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

  static List<PriceModel> generateBuyPriceList(int maxPrice) {
    List<PriceModel> priceList = [];
    double start = 500000;
    double interval = 500000;
    int id = 1;

    for (double price = start; price <= maxPrice; price += interval) {
      priceList.add(PriceModel(
        id: id++,
        title: Formatter.formatNumber(price.toString()),
        actualPrice: price,
      ));
    }

    // Add "No Min" at index 0
    priceList.insert(
        0,
        PriceModel(
          id: 0,
          title: "No Min",
          actualPrice: 0.0,
        ));

    return priceList;
  }

  static List<PriceModel> generateBuyMaxPriceList(int maxPrice) {
    List<PriceModel> priceList = [];
    double start = 500000;
    double interval = 500000;
    int id = 1;

    for (double price = start; price <= maxPrice; price += interval) {
      priceList.add(PriceModel(
        id: id++,
        title: Formatter.formatNumber(price.toString()),
        actualPrice: price,
      ));
    }

    // Add "No Min" at index 0
    priceList.insert(
        0,
        PriceModel(
          id: 0,
          title: "No Max",
          actualPrice: 0.0,
        ));

    return priceList;
  }

  static List<PriceModel> generateRentPriceList(int maxPrice) {
    List<PriceModel> priceList = [];
    double start = 5000;
    double interval = 5000;
    int id = 1;

    for (double price = start; price <= maxPrice; price += interval) {
      priceList.add(PriceModel(
        id: id++,
        title: Formatter.formatNumber(price.toString()),
        actualPrice: price,
      ));
    }

    // Add "No Min" at index 0
    priceList.insert(
        0,
        PriceModel(
          id: 0,
          title: "No Min",
          actualPrice: 0.0,
        ));

    return priceList;
  }

  static List<PriceModel> generateRentMaxPriceList(int maxPrice) {
    List<PriceModel> priceList = [];
    double start = 5000;
    double interval = 5000;
    int id = 1;

    for (double price = start; price <= maxPrice; price += interval) {
      priceList.add(PriceModel(
        id: id++,
        title: Formatter.formatNumber(price.toString()),
        actualPrice: price,
      ));
    }

    // Add "No Min" at index 0
    priceList.insert(
        0,
        PriceModel(
          id: 0,
          title: "No Max",
          actualPrice: 0.0,
        ));

    return priceList;
  }

  static List<PriceModel> generateAreaSqftListMin(int maxPrice) {
    List<PriceModel> priceList = [];
    double start = 500; // Starting value
    double interval = 1000; // Interval of 1000
    int id = 1;

    // Generate prices from start to the smaller of maxPrice or 10000
    for (double price = start;
        price <= maxPrice && price <= 30000;
        price += interval) {
      priceList.add(PriceModel(
        id: id++,
        title: price.toStringAsFixed(0), // Convert to string without suffix
        actualPrice: price,
      ));
    }

// Ensure 10000 is included if maxPrice allows it
    if (maxPrice >= maxPrice) {
      priceList.add(PriceModel(
        id: id,
        title: "$maxPrice +", // Explicitly add 10000
        actualPrice: maxPrice.toDouble(),
      ));
    }

    // Add "No Min" at index 0
    priceList.insert(
        0,
        PriceModel(
          id: 0,
          title: "No Min",
          actualPrice: 0.0,
        ));

    return priceList;
  }

  static List<PriceModel> generateAreaSqftListMax(int maxPrice) {
    List<PriceModel> priceList = [];
    double start = 500; // Starting value
    double interval = 1000; // Interval of 1000
    int id = 1;

    // Generate prices from start to the smaller of maxPrice or 10000
    for (double price = start;
        price <= maxPrice && price <= 30000;
        price += interval) {
      priceList.add(PriceModel(
        id: id++,
        title: price.toStringAsFixed(0), // Convert to string without suffix
        actualPrice: price,
      ));
    }

    // Ensure 10000 is included if maxPrice allows it
    if (maxPrice >= maxPrice) {
      priceList.add(PriceModel(
        id: id,
        title: "$maxPrice +", // Explicitly add 10000
        actualPrice: maxPrice.toDouble(),
      ));
    }

    // Add "No Min" at index 0
    priceList.insert(
        0,
        PriceModel(
          id: 0,
          title: "No Max",
          actualPrice: 0.0,
        ));

    return priceList;
  }
}
