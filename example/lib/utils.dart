int _calculateDaysLeft(DateTime birthdate) {
  final expectedDeath =
      birthdate.add(Duration(hours: (72.27 * 365.2425 * 24).floor()));

  final expectedDaysLeft = (expectedDeath.millisecondsSinceEpoch -
          DateTime.now().millisecondsSinceEpoch) ~/
      Duration.millisecondsPerDay;

  return expectedDaysLeft;
}

int calculateFullMoons(DateTime birthdate) =>
    _calculateDaysLeft(birthdate) ~/ 29.5;

int calculateTotalSolarEclipses(DateTime birthdate) =>
    (0.66 * _calculateDaysLeft(birthdate)) ~/ 365.2425;

bool areDayAndMonthEqual(DateTime d1, DateTime d2) =>
    d1.day == d2.day && d1.month == d2.month;
