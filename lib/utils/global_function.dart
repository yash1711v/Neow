import 'package:flutter/cupertino.dart';

import '../models/login_master.dart';
import '../models/cycle_dates_master.dart';

List<DateTime> findOvulationDates(
    DateTime cycleStartDate, int cycleLength, int month) {
  List<DateTime> ovulationDates = [];

  DateTime nextPeriodDate = cycleStartDate;

  while (nextPeriodDate.month == month) {
    DateTime ovulationDate =
        nextPeriodDate.add(Duration(days: cycleLength - 14));
    if (ovulationDate.month == month) {
      ovulationDates.add(ovulationDate);
    }
    nextPeriodDate = nextPeriodDate.add(Duration(days: cycleLength));
  }

  return ovulationDates;
}

DateTime calculateOvulationDate(DateTime cycleStartDate, int cycleLength) {
  // Ovulation typically occurs 14 days before the next period
  return cycleStartDate.add(Duration(days: cycleLength - 14));
}

bool isWithinLastThreeDaysOfFutureDate(
    DateTime currentDate, DateTime futureDate) {
  // Calculate the difference between the future date and the current date
  Duration difference = futureDate.difference(currentDate);

  // Check if the difference is less than or equal to 3 days and greater than or equal to 0
  return difference.inDays <= 3 && difference.inDays >= 0;
}

int getDaysInMonth(int year, int month) {
  // Check if the month is valid
  if (month < 1 || month > 12) {
    throw ArgumentError("Month must be between 1 and 12");
  }

  // Calculate the number of days in the month
  DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);
  DateTime lastDayOfCurrentMonth =
      firstDayOfNextMonth.subtract(Duration(days: 1));
  int totalDays = lastDayOfCurrentMonth.day;

  // Generate a list of DateTime objects for each day of the month
  int dates = 0;
  for (int day = 1; day <= totalDays; day++) {
    dates = day;
  }

  return dates;
}
