class OnePricingCalculator {
  //Calculate price based on tax and shipping
  static double calculateTotalPrice(double productPrice, String location) {
    double taxrate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxrate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;

    return totalPrice;
  }

  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  static String calculateTax(double productPrice, String location) {
    double taxrate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxrate;

    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    return 0.10;
  }

  static double getShippingCost(String location) {
    return 5.00;
  }
}
