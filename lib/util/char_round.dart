String charRound(number) {
  const List<String> suffixes = ['', 'K', 'M', 'B', 'T', 'Q'];
  int suffixIndex = 0;
  double abbreviatedNumber = number.toDouble();

  while (abbreviatedNumber >= 1000 && suffixIndex < suffixes.length - 1) {
    abbreviatedNumber /= 1000;
    suffixIndex++;
  }

  String formattedNumber;
  if (abbreviatedNumber % 1 == 0) {
    formattedNumber = abbreviatedNumber.toInt().toString();
  } else {
    formattedNumber = abbreviatedNumber.toStringAsFixed(1);
  }

  return '$formattedNumber${suffixes[suffixIndex]}';
}
