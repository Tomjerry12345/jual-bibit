double calculatePercent(double discount, double price) {
  if (price == 0) {
    throw ArgumentError("Price cannot be zero.");
  }
  double percent = price * (discount / 100);
  return percent;
}
