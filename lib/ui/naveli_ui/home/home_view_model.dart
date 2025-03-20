import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// import 'dart:developer';
// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naveli_2023/utils/date_utils.dart';

import '../../../database/app_preferences.dart';
import '../../../models/cycle_dates_master.dart';
import '../../../models/slider_video_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';

class HomeViewModel with ChangeNotifier {
  late BuildContext context;
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  final _services = Services();
  Timer? timerSlider;
  Timer? timerSymptoms;
  List<SliderVideoData> sliderVideo = [];
  List<String> dateParts = [];
  int year = 0;
  int month = 0;
  int day = 0;
  List<DateTime> nextCycleDates = [];
  List<DateTime> ovulationDates = [];
  List<DateTime> firtileDates = [];
  List<DateTime> daysList = [];
  DateTime selectedDate = DateTime.now();

  List<Color> gradientColorsList() => [
        Colors.red,
        Colors.red.withOpacity(0.9),
        Colors.red.withOpacity(0.8),
        Colors.red.withOpacity(0.7),
        Colors.red.withOpacity(0.5),
      ];

  List<Color> gradientColorsListPink() => [
        Colors.pink,
        Colors.pink.withOpacity(0.9),
        Colors.pink.withOpacity(0.8),
        Colors.pink.withOpacity(0.7),
        Colors.pink.withOpacity(0.5),
      ];

  List<Color> gradientColorsListGreen() => [
        Colors.green.withOpacity(0.6),
        Colors.green.withOpacity(0.6),
        Colors.green.withOpacity(0.6),
        Colors.green.withOpacity(0.5),
        Colors.green.withOpacity(0.4),
      ];

  LinearGradient getGradient() {
    List<Color> gradientColors = gradientColorsList();
    return LinearGradient(
      colors: gradientColors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: List.generate(gradientColors.length,
          (index) => index / (gradientColors.length - 1)),
    );
  }

  LinearGradient getGradientPink() {
    List<Color> gradientColors = gradientColorsListPink();
    return LinearGradient(
      colors: gradientColors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: List.generate(gradientColors.length,
          (index) => index / (gradientColors.length - 1)),
    );
  }

  LinearGradient getGradientGreen() {
    List<Color> gradientColors = gradientColorsListGreen();
    return LinearGradient(
      colors: gradientColors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: List.generate(gradientColors.length,
          (index) => index / (gradientColors.length - 1)),
    );
  }

  DateTime currentDateTime = DateTime.now();

  void attachedContext(BuildContext context) {
    this.context = context;
    daysList.clear();
    selectedDate = DateTime.now();
    // generateDaysList();
  }

  List<DateTime> calculateCycleDatesInYear(
      DateTime previousDate, int cycleLength) {
    List<DateTime> nextCycleDates = [];

    print('PrevousDate : $previousDate CycleLength: $cycleLength');

    DateTime nextDate = previousDate;

    DateTime now = DateTime.now();
    DateTime twelveMonthsLater = now.add(const Duration(days: 365));
    List<DateTime> ovulationDates = [];

    print("ppppppp ${globalUserMaster!.averagePeriodLength ?? '5'}");
    DateTime startDate = DateTime.parse(
        peroidCustomeList[peroidCustomeList.length - 1].period_start_date);
    DateTime endDate = DateTime.parse(
        peroidCustomeList[peroidCustomeList.length - 1].period_end_date);
    int periodLength = startDate.difference(endDate).inDays.abs();
    print(
        "ppppppp ${peroidCustomeList[peroidCustomeList.length - 1].period_length}");

    while (nextDate.isBefore(twelveMonthsLater)) {
      // Add all days of the period to the list
      for (int i = 0;
          i <
              int.parse(peroidCustomeList[peroidCustomeList.length - 1]
                  .period_length) /*globalUserMaster!.averagePeriodLength ?? '5')*/;
          i++) {
        if (i == 0) {
          ovulationDates.add(nextDate.add(Duration(days: 14)));
        }
        nextCycleDates.add(nextDate.add(Duration(days: i)));
        gCycleDates.add(CycleDates(
            nextDate.add(Duration(days: i)), true, false, false, (i + 1)));
      }
      // Move to the next cycle start date
      nextDate = nextDate.add(Duration(days: cycleLength));
    }

    return nextCycleDates;
  }

  List<DateTime> calculateOvolutionDatesInYear(
      DateTime previousDate, int cycleLength) {
    List<DateTime> nextCycleDates = [];
    DateTime nextDate = previousDate;

    DateTime now = DateTime.now();
    DateTime twelveMonthsLater = now.add(const Duration(days: 365));
    List<DateTime> ovulationDates = [];

    while (nextDate.isBefore(twelveMonthsLater)) {
      // Add all days of the period to the list
      for (int i = 0;
          i <
              int.parse(peroidCustomeList[peroidCustomeList.length - 1]
                  .period_length) /*int.parse(globalUserMaster!.averagePeriodLength ?? '5')*/;
          i++) {
        if (i == 0) {
          int ovdays = 6 + (cycleLength - 21);
          ovulationDates.add(nextDate.add(Duration(days: ovdays)));
        }
        nextCycleDates.add(nextDate.add(Duration(days: i)));
      }

      // Move to the next cycle start date
      nextDate = nextDate.add(Duration(days: cycleLength));
    }

    // log("OvulationDates===> $ovulationDates", name: "OvulationDates");
    return ovulationDates;
  }

  List<DateTime> calculateFertileDatesInYear({
    required DateTime previousPeriodStartDate,
    required int cycleLength,
    required int periodLength,
  }) {
    List<DateTime> fertileDates = [];

    // Predict next cycle start date
    DateTime nextCycleStartDate =
        previousPeriodStartDate.add(Duration(days: cycleLength));

    // Calculate ovulation date (14 days before next cycle start)
    DateTime ovulationDate = nextCycleStartDate.subtract(Duration(days: 14));

    // Add fertile window (5 days before + ovulation day + 2 days after)
    for (int j = 5; j > 0; j--) {
      fertileDates.add(ovulationDate.subtract(Duration(days: j)));
    }
    fertileDates.add(ovulationDate);
    for (int j = 1; j <= 2; j++) {
      fertileDates.add(ovulationDate.add(Duration(days: j)));
    }

    // log("Fertile dates ===> $fertileDates", name: "FertileDates");
    return fertileDates;
  }

  Future<void> getSliderVideoApi() async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    SliderVideoMaster? master =
        await _services.api!.getHomeSliderVideo(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      sliderVideo = master.data ?? [];
    }
    notifyListeners();
  }

  Future<void> updateCycleDates({
    required DateTime startDate,
    required int cycleLength,
  }) async {
    // Clear the existing cycle data to avoid conflicts.
    gCycleDates.clear();

    // Recalculate the new cycle, ovulation, and fertile dates
    List<DateTime> newCycleDates =
        calculateCycleDatesInYear(startDate, cycleLength);
    List<DateTime> newOvulationDates =
        calculateOvolutionDatesInYear(startDate, cycleLength);
    List<DateTime> newFertileDates = calculateFertileDatesInYear(
        previousPeriodStartDate: startDate,
        cycleLength: cycleLength,
        periodLength: int.parse(globalUserMaster?.averagePeriodLength ?? "5"));

    // Optionally, you can print out the recalculated dates or store them in the model
    print("New Cycle Dates: $newCycleDates");
    print("New Ovulation Dates: $newOvulationDates");
    print("New Fertile Dates: $newFertileDates");

    // Update your model or state with the new data
    nextCycleDates = newCycleDates;
    ovulationDates = newOvulationDates;
    firtileDates = newFertileDates;

    // You can add additional logic here as needed
  }

  void generateDaysList() {
    DateTime currentDate = DateTime.now();
    selectedDate = currentDate;
    for (int i = 0; i < 90; i++) {
      daysList.add(currentDate.add(Duration(days: i)));
    }
    notifyListeners();
  }

  String calculateDaysToGo(DateTime currentDate) {
    nextCycleDates.sort();
    nextCycleDates = nextCycleDates.toSet().toList();
    DateTime nextCycleStartDate = nextCycleDates.firstWhere(
        (date) => date.isAfter(currentDate),
        orElse: () => nextCycleDates.last);

    int daysRemaining = nextCycleStartDate.difference(currentDate).inDays + 1;

    return "$daysRemaining days";
  }

  bool getPredictedDaySelected(DateTime currentDate) {
    for (int i = 0; i < peroidCustomeList.length; i++) {
      DateTime startPredicatedPeriods =
          DateTime.parse(peroidCustomeList[i].predicated_period_start_date);
      DateTime endPredicatedPeriods =
          DateTime.parse(peroidCustomeList[i].predicated_period_end_date);

      if ((currentDate.isAfter(startPredicatedPeriods) &&
              currentDate.isBefore(endPredicatedPeriods)) ||
          currentDate.isAtSameMomentAs(startPredicatedPeriods) ||
          currentDate.isAtSameMomentAs(endPredicatedPeriods)) {
        return true;
      }
    }
    return false;
  }

  DateTime parseDDMMYYYY(DateTime dateStr) {
    int day = dateStr.day;
    int month = dateStr.month;
    int year = dateStr.year;
    return DateTime(year, month, day);
  }

  String getCycleDayOrDaysToGo(DateTime date) {
    if (peroidCustomeList.isEmpty) {
      return "No cycle dates available";
    }


    bool isPredictedDate = false;
    bool PriodDates = false;
    // widget.mViewModel.nextCycleDates.contains(date);
    bool isOvulation =
    false; //widget.mViewModel.ovulationDates.contains(date);
    bool isFirtile = false;

    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int currentYear = now.year;

    List<DateTime> fertileDates = [];
    List<DateTime> ovulationDates = [];
    List<DateTime> loggedPeriodDates = [];
    List<DateTime> predictedPeriodDates = [];

    // DateTime now = DateTime.now();
    // int currentYear = now.year;

    // DateTime now = DateTime.now();
    // int currentYear = now.year;

    for (var dateRange in peroidCustomeList) {
      DateTime start = DateTime.parse(dateRange.period_start_date);
      DateTime end = DateTime.parse(dateRange.period_end_date);
      int cycleLength = int.parse(dateRange.period_cycle_length);

      DateTime? startDate = dateRange.fertile_window_start != null
          ? DateTime.parse(dateRange.fertile_window_start!)
          : null;

      DateTime? endDate = dateRange.fertile_window_end != null
          ? DateTime.parse(dateRange.fertile_window_end!)
          : null;

      for (DateTime date = startDate ?? DateTime.now();
      date.isBefore(
          (endDate ?? DateTime.now()).add(Duration(days: 1)));
      date = date.add(Duration(days: 1))) {
        fertileDates.add(date);
      }
      ovulationDates
          .add(DateTime.parse(dateRange.ovulation_day ?? ""));

      // Store logged period dates
      loggedPeriodDates.addAll(List.generate(
        end.difference(start).inDays +
            1, // +1 to include the 'end' date
            (i) => start.add(Duration(days: i)),
      ).where((date) =>
      date.isBefore(DateTime.now()) ||
          date.isAtSameMomentAs(DateTime.now())));

      // Predicted period dates
      DateTime startPredictedPeriods =
      DateTime.parse(dateRange.predicated_period_start_date);
      DateTime endPredictedPeriods =
      DateTime.parse(dateRange.predicated_period_end_date);
      int length = int.parse(dateRange.avg_cycle_length ?? "28");

      // ✅ Ensure predicted periods are added
      if (startPredictedPeriods.year == currentYear) {
        predictedPeriodDates.addAll(List.generate(
          endPredictedPeriods
              .difference(startPredictedPeriods)
              .inDays,
              (i) => startPredictedPeriods.add(Duration(days: i)),
        ));
      }

      // **Predict upcoming periods for the next 12 months (within the current year)**
      for (int i = 0; i < 12; i++) {
        startPredictedPeriods =
            startPredictedPeriods.add(Duration(days: length));
        endPredictedPeriods = startPredictedPeriods
            .add(Duration(days: int.parse(dateRange.period_length)));

        // ✅ Stop if the predicted period exceeds the current year
        if (startPredictedPeriods.year > currentYear) break;

        List<DateTime> tempPeriodDates = List.generate(
          int.parse(dateRange.period_length),
              (i) => startPredictedPeriods.add(Duration(days: i)),
        ).where((date) => date.year == currentYear).toList();

// Calculate the period length from user-marked dates
        int actualPeriodLength = end.difference(start).inDays + 1;
        int averagePeriodLength =
        int.parse(globalUserMaster?.averagePeriodLength ?? "5");

// Find the remaining days needed
        int remainingDays = averagePeriodLength - actualPeriodLength;

// If the user marked fewer days than the average, add the missing days
        if (remainingDays > 0) {
          tempPeriodDates.addAll(List.generate(
            remainingDays,
                (i) => end.add(Duration(
                days: i +
                    1)), // Start adding from the next day after `end`
          ));
        }

        predictedPeriodDates.addAll(tempPeriodDates);

        // DateTime futureFertileStart =
        // endPredictedPeriods.add(Duration(days: 3));
        // DateTime futureFertileEnd =
        // futureFertileStart.add(Duration(days: 5));
        // DateTime futureOvulationDay =
        // futureFertileStart.add(Duration(days: 4));
        //
        // // ✅ Add fertile dates only if they fall within the current year
        // if (futureFertileStart.year == currentYear &&
        //     futureFertileEnd.year == currentYear) {
        //   List<DateTime> tempFertileDates = List.generate(
        //     futureFertileEnd.difference(futureFertileStart).inDays +
        //         1,
        //         (i) => futureFertileStart.add(Duration(days: i)),
        //   ).where((date) => date.year == currentYear).toList();
        //
        //   fertileDates.addAll(tempFertileDates);
        // }
        //
        // // ✅ Add ovulation date only if it's within the current year
        // if (futureOvulationDay.year == currentYear) {
        //   ovulationDates.add(futureOvulationDay);
        // }
      }

      predictedPeriodDates.sort(); // Ensure dates are in order

      List<DateTime> periodStartDates = [];
      List<DateTime> periodEndDates = [];

// ✅ Separate start and end dates
      for (int i = 0; i < predictedPeriodDates.length; i++) {
        if (i == 0 ||
            predictedPeriodDates[i]
                .difference(predictedPeriodDates[i - 1])
                .inDays >
                1) {
          // Start of a new period
          periodStartDates.add(predictedPeriodDates[i]);

          // Previous end date (if exists)
          if (i > 0) {
            periodEndDates.add(predictedPeriodDates[i - 1]);
          }
        }
      }
// Add the last period end date
      if (predictedPeriodDates.isNotEmpty) {
        periodEndDates.add(predictedPeriodDates.last);
      }

      predictedPeriodDates.sort(); // Ensure correct order

// ✅ Calculate Fertile Window & Ovulation Dates
      for (int i = 0; i < periodStartDates.length; i++) {
        DateTime currentPeriodStart = periodStartDates[i];
        DateTime? nextPeriodStart = (i + 1 < periodStartDates.length)
            ? periodStartDates[i + 1]
            : null;

        // ✅ If next period is available, calculate ovulation normally.
        DateTime futureOvulationDay;
        if (nextPeriodStart != null) {
          futureOvulationDay =
              nextPeriodStart.subtract(Duration(days: 14));
        } else {
          // ✅ Estimate ovulation for the last month using the average cycle length.
          int estimatedCycleLength = (i > 0)
              ? periodStartDates[i]
              .difference(periodStartDates[i - 1])
              .inDays
              : 28; // Default to 28 days if no previous cycle exists.
          futureOvulationDay = currentPeriodStart
              .add(Duration(days: estimatedCycleLength - 14));
        }

        // ✅ Ensure one ovulation per month
        bool ovulationExistsInMonth = ovulationDates.any(
              (date) =>
          date.year == futureOvulationDay.year &&
              date.month == futureOvulationDay.month,
        );

        if (!ovulationExistsInMonth &&
            futureOvulationDay.year == currentYear) {
          ovulationDates.add(futureOvulationDay);
        } else {
          // ✅ If there's already an ovulation date for the month, replace it with the latest one.
          ovulationDates.removeWhere((date) =>
          date.year == futureOvulationDay.year &&
              date.month == futureOvulationDay.month);
          ovulationDates.add(futureOvulationDay);
        }

        // ✅ Calculate Fertile Window (5 days before & 2 days after ovulation)
        DateTime futureFertileStart =
        futureOvulationDay.subtract(Duration(days: 5));
        DateTime futureFertileEnd =
        futureOvulationDay.add(Duration(days: 2));

        // ✅ Ensure each month has only one fertile window
        bool fertileWindowExistsInMonth = fertileDates.any(
              (date) =>
          date.year == futureFertileStart.year &&
              date.month == futureFertileStart.month,
        );

        if (!fertileWindowExistsInMonth &&
            futureFertileStart.year == currentYear &&
            futureFertileEnd.year == currentYear) {
          // ✅ Remove any previously added fertile dates for that month (if wrong)
          fertileDates.removeWhere((date) =>
          date.year == futureFertileStart.year &&
              date.month == futureFertileStart.month);

          List<DateTime> tempFertileDates = List.generate(
            futureFertileEnd.difference(futureFertileStart).inDays +
                1,
                (i) => futureFertileStart.add(Duration(days: i)),
          ).where((date) => date.year == currentYear).toList();

          fertileDates.addAll(tempFertileDates);
        }
      }

      // // **Past Fertile Dates (Based on last period start date)**
      // DateTime lastFertileStart = end.add(Duration(days: 3));
      // DateTime lastFertileEnd =
      //     lastFertileStart.add(Duration(days: 5));
      // DateTime lastOvulationDay =
      //     lastFertileStart.add(Duration(days: 4));
      //
      // if (lastFertileStart.year == currentYear) {
      //   fertileDates.addAll(List.generate(
      //     lastFertileEnd.difference(lastFertileStart).inDays + 1,
      //     (i) => lastFertileStart.add(Duration(days: i)),
      //   ));
      // }
      //
      // if (lastOvulationDay.year == currentYear) {
      //   ovulationDates.add(lastOvulationDay);
      // }
    }

    // Checking if the given `date` falls in the calculated dates

 String value = "";
    Map<int, Map<int, List<DateTime>>> fertileDatesByMonth = separateDatesByMonth(fertileDates);
    Map<int, Map<int, List<DateTime>>> ovulationDatesByMonth = separateDatesByMonth(ovulationDates);
    Map<int, Map<int, List<DateTime>>> loggedPeriodDatesByMonth = separateDatesByMonth(loggedPeriodDates);
    Map<int, Map<int, List<DateTime>>> predictedPeriodDatesByMonth = separateDatesByMonth(predictedPeriodDates);

    // Iterate through each year and month
    print("Fertile Dates:");
    value = getFertileWindowInfo(date, fertileDatesByMonth, ovulationDatesByMonth) ?? "Cycle data unavailable";
    // fertileDatesByMonth.forEach((year, months) {
    //   months.forEach((month, dates) {
    //     if(date.month == month){
    //       ovulationDatesByMonth.forEach((year, months) {
    //         months.forEach((month, dates) {
    //           if(date.month == month){
    //             String difference = "";
    //             if(date.isBefore(dates[0])) {
    //               difference = dates[0].difference(date).toString();
    //               return "Fertile Window: $difference days to";
    //             }
    //           }
    //         });
    //       });
    //     }
    //   });
    // });

    print("\nOvulation Dates:");
    ovulationDatesByMonth.forEach((year, months) {
      months.forEach((month, dates) {
        // print("Year: $year, Month: $month => ${dates.map((d) => d.toIso8601String()).toList()}");
      });
    });

    print("\nLogged Period Dates:");
    loggedPeriodDatesByMonth.forEach((year, months) {
      months.forEach((month, dates) {
        // print("Year: $year, Month: $month => ${dates.map((d) => d.toIso8601String()).toList()}");
      });
    });

    print("\nPredicted Period Dates:");
    predictedPeriodDatesByMonth.forEach((year, months) {
      months.forEach((month, dates) {
        // print("Year: $year, Month: $month => ${dates.map((d) => d.toIso8601String()).toList()}");
      });
    });


    if (loggedPeriodDates.contains(date)) {

    }

    if (predictedPeriodDates.contains(date)) {
      isPredictedDate = true;
    }

    if (fertileDates.contains(date)) {
      isFirtile = true;
    }
    ovulationDates.removeAt(ovulationDates.length - 1);
    if (ovulationDates.contains(date)) {
      if (date.year < date.year + 1) {
        isOvulation = true;
        return "Ovulation Day";
      }
    }


    return value;
  }

  String? getFertileWindowInfo(DateTime date,
      Map<int, Map<int, List<DateTime>>> fertileDatesByMonth,
      Map<int, Map<int, List<DateTime>>> ovulationDatesByMonth) {

    for (var year in fertileDatesByMonth.keys) {
      var months = fertileDatesByMonth[year]!;

      for (var month in months.keys) {
        if (date.month == month) {

          for (var ovYear in ovulationDatesByMonth.keys) {
            var ovMonths = ovulationDatesByMonth[ovYear]!;

            for (var ovMonth in ovMonths.keys) {
              if (date.month == ovMonth) {
                List<DateTime> ovulationDates = ovMonths[ovMonth]!;

                if (date.isBefore(ovulationDates[0])) {
                  int difference = ovulationDates[0].difference(date).inDays;
                  return "Ovulation in $difference ${difference>1?"days":"day"}";
                }
              }
            }
          }
        }
      }
    }

    return null; // Return null if no match is found
  }


  Map<int, Map<int, List<DateTime>>> separateDatesByMonth(List<DateTime> dates) {
    Map<int, Map<int, List<DateTime>>> sortedDates = {};

    for (var date in dates) {
      int year = date.year;
      int month = date.month;

      sortedDates.putIfAbsent(year, () => {});
      sortedDates[year]!.putIfAbsent(month, () => []);

      // Add date only if it's not already present in the list
      if (!sortedDates[year]![month]!.contains(date)) {
        sortedDates[year]![month]!.add(date);
      }
    }

    return sortedDates;
  }

  String getCyclePhaseMessage() {
    DateTime currentDate = DateTime.now();

    if (peroidCustomeList.isEmpty) {
      return "";
    }

    // Sort period data to get the latest logged period start date
    peroidCustomeList.sort((a, b) =>
        DateTime.parse(b.period_start_date).compareTo(DateTime.parse(a.period_start_date)));

    DateTime lastPeriodStartDate =
    DateTime.parse(peroidCustomeList.first.period_start_date);

    int dayDifference = currentDate.difference(lastPeriodStartDate).inDays + 1;

    print("Current date is day $dayDifference from the start date.");

    int cycleLength = int.parse(peroidCustomeList.first.period_cycle_length);
    int periodLength = int.parse(peroidCustomeList.first.period_length);

    // Define cycle phases based on the table provided
    List<Map<String, dynamic>> cyclePhases = [
      {
        "start": 1,
        "end": 3,
        "message": "Cycle kicks in—heavy flow, cramps, and all that! Rest, stay hydrated, and go easy on yourself."
      },
      {
        "start": 4,
        "end": 5,
        "message": "Period winding down—time to relax and refuel yourself."
      },
      {
        "start": 6,
        "end": 8,
        "message": "Energy peaks—time to shine! Set goals and stay active."
      },
      {
        "start": 7,
        "end": 10,
        "message": "Estrogen rising—feeling vibrant. Go for it—be social and creative."
      },
      {
        "start": 8,
        "end": 13,
        "message": "Confidence peaks! Embrace the energy, take on new challenges, and slay!"
      },
      {
        "start": 9,
        "end": 15,
        "message": "Vibes are chill. Take a breather, unwind, and treat yourself to some me-time."
      },
      {
        "start": 13,
        "end": 18,
        "message": "Cravings, mood swings, and all the feels. Nourish, slow down, and be gentle with yourself."
      },
      {
        "start": 18,
        "end": 21,
        "message": "PMS Alert!! Feeling bloated, tired, and emotional? Hydrate, relax, and pamper yourself."
      },
      {
        "start": cycleLength - 3,
        "end": cycleLength,
        "message": "Your period is due soon! Stay mindful of your body and prepare accordingly."
      },
    ];

    // Handle late period scenario
    if (dayDifference > cycleLength) {
      return "Period’s running late? Don’t stress, give it time, and let your body do its thing.";
    }

    // Find the correct phase
    for (var phase in cyclePhases) {
      if (dayDifference >= phase["start"] && dayDifference <= phase["end"]) {
        return phase["message"];
      }
    }

    return "Cycle phase not identified. Please check your period data.";
  }





  // String getCycleDayOrDaysToGo(DateTime currentDate) {
  //   nextCycleDates.sort();
  //
  //   // Find the most recent period start date before or on the current date
  //   DateTime previousCycleStartDate = nextCycleDates.lastWhere(
  //     (date) =>
  //         date.isBefore(currentDate) || date.isAtSameMomentAs(currentDate),
  //     orElse: () => nextCycleDates.first,
  //   );
  //
  //   // Find the next cycle start date after the current date
  //   DateTime nextCycleStartDate = nextCycleDates.firstWhere(
  //     (date) => date.isAfter(currentDate),
  //     orElse: () => nextCycleDates.last,
  //   );
  //
  //   int cycleDay = currentDate.difference(previousCycleStartDate).inDays +
  //       1; // Cycle day including the current date
  //
  //   // Check if the current date is within the period days
  //   bool isPeriodDay = nextCycleDates.any((date) =>
  //       date.year == currentDate.year &&
  //       date.month == currentDate.month &&
  //       date.day == currentDate.day);
  //
  //   if (isPeriodDay) {
  //     // This is a period day
  //     return "Period day";
  //   } else if (currentDate.isBefore(nextCycleStartDate)) {
  //     // Show the day of the current cycle if the current date is before the next cycle start date
  //     // return "Day $cycleDay of current cycle";
  //     return "Day ${cycleDay + int.parse(globalUserMaster?.averagePeriodLength ?? "5") - 1} of current cycle";
  //   } else {
  //     // Calculate days to go until the next period starts
  //     int daysToNextCycle = nextCycleStartDate.difference(currentDate).inDays;
  //     return "$daysToNextCycle days to go";
  //   }
  // }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void startSlider() {
    timerSlider = Timer.periodic(
      const Duration(seconds: 25),
      (timer) {
        if (currentPage < 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
    );
    notifyListeners();
  }

  String getWeekDay(DateTime dateTime) {
    switch (dateTime.weekday) {
      case DateTime.sunday:
        return 'S';
      case DateTime.monday:
        return 'M';
      case DateTime.tuesday:
        return 'T';
      case DateTime.wednesday:
        return 'W';
      case DateTime.thursday:
        return 'T';
      case DateTime.friday:
        return 'F';
      case DateTime.saturday:
        return 'S';
      default:
        return '';
    }
  }

  Future<void> fetchData() async {
    String accessToken = AppPreferences.instance.getAccessToken();
    String numberString = "${globalUserMaster?.id}";
    peroidCustomeList.clear();
    final url = Uri.parse(
        "https://neowindia.com/customeApi/periodinfo.php?user_id=" +
            numberString); // Replace with your API endpoint
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    final response =
        await http.get(url, headers: headers).timeout(Duration(seconds: 30));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the server returns a successful response, parse the JSON.
      var data = jsonDecode(response.body);
      // debugPrint("data ====>$data");
      List<dynamic> jsonList = jsonDecode(response.body);
      // peroidCustomeList =
      //     jsonList.map((json) => PeriodObj.fromJson(json)).toList();
      peroidCustomeList
          .addAll(jsonList.map((json) => PeriodObj.fromJson(json)).toList());

      // if (peroidCustomeList.isNotEmpty) {
      //   // startDate: newStartDate, cycleLength:
      //   // String periodStartDateString =
      //   //     peroidCustomeList[peroidCustomeList.length - 1].period_start_date;
      //   // DateTime periodStartDate = DateTime.parse(periodStartDateString);
      //   // updateCycleDates(
      //   //   startDate: periodStartDate,
      //   //   cycleLength: int.parse(
      //   //       peroidCustomeList[peroidCustomeList.length - 1].period_length),
      //   // );
      // }

      notifyListeners();

      print('Response data: $jsonList');
      // print('peroidCustomeList data: $peroidCustomeList');
    } else {
      throw Exception('Failed to post data: ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<void> getPeriodInfoList() async {
    //CommonUtils.showProgressDialog();
    PeriodInfoListResponse? master = await _services.api!.getPeriodInfoList();
    //CommonUtils.hideProgressDialog();
    // var data = jsonDecode(master.data.toString());
    // debugPrint("data ====>$data");

    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................period info list data oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      //  CommonUtils.hideProgressDialog();
      peroidCustomeList.clear();
      if ((master.data!.periodData?.length ?? 0) > 0) {
        for (int i = 0; i < (master.data!.periodData?.length ?? 0); i++) {
          var data = PeriodObj(
            user_id: master.data!.user_id,
            period_start_date: master.data!.periodData![i].period_start_date,
            period_end_date: master.data!.periodData![i].period_end_date,
            period_length: master.data!.periodData![i].period_length,
            period_cycle_length:
                master.data!.periodData![i].period_cycle_length,
            period_month_update:
                master.data!.periodData![i].period_month_update,
            predicated_period_start_date:
                master.data!.predicated_period_start_date,
            predicated_period_end_date: master.data!.predicated_period_end_date,
            fertile_window_start: master.data!.fertile_window_start ?? "",
            fertile_window_end: master.data!.fertile_window_end ?? "",
            ovulation_day: master.data!.ovulation_day ?? "",
            avg_cycle_length: master.data!.avg_cycle_length,
          );
          peroidCustomeList.add(data);
          notifyListeners();
        }
      }
      //
      // globalFertileWindowStart = master.fertile_window_start;
      // globalFertileWindowEnd = master.fertile_window_end;

      debugPrint("globalFertileWindowStart ====>${globalFertileWindowStart}");
      debugPrint("globalFertileWindowEnd ====>${globalFertileWindowEnd}");

      //check period whithin 14 days
      if (peroidCustomeList.length > 1) {
        DateTime firstPeriodLastDate =
            DateTime.parse(peroidCustomeList[0].period_end_date);
        DateTime secondPeriodStartDate =
            DateTime.parse(peroidCustomeList[1].period_start_date);
        isWithinFourteenDays = firstPeriodLastDate
                .difference(secondPeriodStartDate)
                .inDays
                .abs() <=
            14;
      }

      debugPrint(
          "peroidCustomeList ====>${peroidCustomeList[(master.data!.periodData?.length ?? 0) - 1].period_cycle_length}");

      handleSecondBloc(master.data!.periodData![0].period_start_date);
      /*peroidCustomeList.add( PeriodObj(
          user_id: master.data!.user_id,
          period_cycle_length: master.data!.period_cycle_length,
          period_end_date: master.data!.predicated_period_end_date,
          period_start_date: master.data!.predicated_period_start_date,
          period_length: master.data!.period_length,
          period_month_update: "324",
          predicated_period_end_date: master.data!.predicated_period_end_date,
          predicated_period_start_date:
              master.data!.predicated_period_start_date));*/
      updateSelectedDate(DateTime.now());
      print("daaa =>${master.data}");
      notifyListeners();
    }
    notifyListeners();
  }

  DateTime previousDateLocal = DateTime.now();

  Future<void> handleSecondBloc(
    String dt,
  ) async {
    if (gUserType == AppConstants.NEOWME || gUserType == AppConstants.BUDDY) {
      print("Cycle length :: ${globalUserMaster?.averageCycleLength}");
      print("Period length :: ${globalUserMaster?.averagePeriodLength}");
      dateParts = dt.split(RegExp(r'[\s-]+'));
      debugPrint("dt :: ${dt.toString()}");
      year = int.parse(dateParts[0]);
      month = int.parse(dateParts[1]);
      day = int.parse(dateParts[2]);
      DateTime previousDate = DateTime(year, month, day);
      previousDateLocal = previousDate;
      DateTime newDate = previousDate
          .add(Duration(
              days: int.parse(globalUserMaster?.averageCycleLength ?? "28")))
          .subtract(Duration(days: 1));
      print("previousDate is :::::::::: $previousDate");
      print("newDate date is :::::::::: $newDate");
      print(
          " cycleLength date is :::::::::: $globalUserMaster?.averageCycleLength");

      nextCycleDates = calculateCycleDatesInYear(
          newDate.month == DateTime.now().month ||
                  previousDate.month == DateTime.now().month
              ? previousDate
              : newDate,
          int.parse(globalUserMaster?.averageCycleLength ?? "28"));
      ovulationDates = calculateOvolutionDatesInYear(
          newDate, int.parse(globalUserMaster?.averageCycleLength ?? "28"));
      firtileDates = calculateFertileDatesInYear(
          previousPeriodStartDate: newDate,
          cycleLength: int.parse(globalUserMaster?.averageCycleLength ?? "28"),
          periodLength:
              int.parse(globalUserMaster?.averagePeriodLength ?? "5"));
      print("CycleDates date is :::::::::: ${gCycleDates[0].periodDay}");
      generateDaysList();
      print("Next date is :::::::::: ${nextCycleDates}");

      DateTime today = DateTime.now();
      DateTime? nextCycleDate = nextCycleDates.firstWhere(
        (date) => date.isAfter(today),
        orElse: () => nextCycleDates.last,
      );

      // Pass the next cycle date to the calculateDaysToGo method
      String daysToGo = calculateDaysToGo(nextCycleDate);
      print(
          'FInal date for done :::::::::::::::::::::::::::==============> $daysToGo');

      // daysToGo = mViewModel.calculateDaysToGo(mViewModel.nextCycleDates);
    }

    // if (gUserType == AppConstants.NEOWME || gUserType == AppConstants.BUDDY) {
    //   int cycleLength = int.parse(globalUserMaster?.averageCycleLength ?? "28");
    //   print("Cycle length :: ${globalUserMaster?.averageCycleLength}");
    //   print("dt :: ${dt}");
    //   print(
    //       "Period length :: ${globalUserMaster?.averagePeriodLength} previouspreriodbegin : ${globalUserMaster?.previousPeriodsBegin ?? ''}");
    //   //mViewModel.dateParts = dateString.split(RegExp(r'[\s-]+'));
    //   dateParts = dt.split(RegExp(r'[\s-]+'));
    //   year = int.parse(dateParts[0]);
    //   month = int.parse(dateParts[1]);
    //   day = int.parse(dateParts[2]);
    //   DateTime previousDate = DateTime(year, month, day);
    //   DateTime endDate = DateTime(year, month, day).add(Duration(days: int.parse(globalUserMaster?.averagePeriodLength ?? "5") - 1));
    //   print("previousDate :::::::::: $previousDate");
    //   DateTime newDate = previousDate.add(Duration(days: cycleLength));
    //   print("newDate date is :::::::::: $newDate");
    //   print(" cycleLength date is :::::::::: $cycleLength");
    //
    //   nextCycleDates = calculateCycleDatesInYear(newDate.subtract(Duration(days: 1)), cycleLength);
    //   ovulationDates = calculateOvolutionDatesInYear(previousDate, cycleLength);
    //   firtileDates = calculateFirtileDatesInYear(ovulationDates);
    //   print("CycleDates date is :::::::::: ${gCycleDates[0].periodDay}");
    //   generateDaysList();
    //   print("Next date is :::::::::: $nextCycleDates");
    //
    //   DateTime today = DateTime.now();
    //   DateTime? nextCycleDate = nextCycleDates.firstWhere(
    //     (date) => date.isAfter(today),
    //     orElse: () => nextCycleDates.last,
    //   );
    //
    //   // Pass the next cycle date to the calculateDaysToGo method
    //   // daysToGo = mViewModel.calculateDaysToGo(nextCycleDate);
    //
    //   // daysToGo = mViewModel.calculateDaysToGo(mViewModel.nextCycleDates);
    // }
  }
}

bool isCurrentDateAfterOvulationRange({
  required DateTime currentDate,
  required DateTime nextCycleStartDate,
  required int periodLength,
}) {
  // Step 1: Determine cycle length (Default: 28 days)
  int cycleLength =
      int.tryParse(globalUserMaster?.averageCycleLength ?? "28") ?? 28;

  // Step 2: Calculate the first day of the current cycle
  DateTime currentCycleStartDate =
      nextCycleStartDate.subtract(Duration(days: cycleLength));

  // Step 3: Calculate the ovulation day (14 days before next cycle start)
  DateTime ovulationDate = nextCycleStartDate.subtract(Duration(days: 14));

  // Step 4: Define the fertile window (5 days before ovulation + ovulation day)
  DateTime fertileStartDate = ovulationDate.subtract(Duration(days: 5));
  DateTime fertileEndDate =
      ovulationDate.add(Duration(days: 1)); // Ovulation day included

  // Debugging Prints
  // debugPrint("Cycle Start Date: $currentCycleStartDate");
  // debugPrint("Next Cycle Start Date: $nextCycleStartDate");
  // debugPrint("Ovulation Date: $ovulationDate");
  // debugPrint("Fertile Window Start: $fertileStartDate");
  // debugPrint("Fertile Window End: $fertileEndDate");

  // Step 5: Check if current date is after ovulation window
  return currentDate.isAfter(fertileEndDate);
}

DateTime? getValidCycleStartDate(
    List<DateTime> nextCycleDates, DateTime currentDate, int periodLength) {
  if (nextCycleDates.isEmpty || periodLength < 1) return null;

  nextCycleDates.sort(); // Ensure dates are sorted

  for (int i = 0; i <= nextCycleDates.length - periodLength; i++) {
    List<DateTime> window = nextCycleDates.sublist(i, i + periodLength);

    if (crossesIntoNextMonth(window)) {
      return window.first; // Return first date in the valid sequence
    }
  }

  return null; // No valid cycle found
}

bool crossesIntoNextMonth(List<DateTime> dates) {
  if (dates.length < 2) return false;

  for (int i = 0; i < dates.length - 1; i++) {
    if (dates[i].month != dates[i + 1].month) {
      return true; // Sequence extends into the next month
    }
  }
  return false;
}
