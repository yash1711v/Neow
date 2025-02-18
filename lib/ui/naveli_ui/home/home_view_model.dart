import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../database/app_preferences.dart';
import '../../../models/slider_video_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';
import '../../../models/cycle_dates_master.dart';
import 'package:http/http.dart' as http;

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
      DateTime previousDate, int cycleLength)
  {
    List<DateTime> nextCycleDates = [];

    print('PrevousDate : $previousDate CycleLength: $cycleLength');

    DateTime nextDate = previousDate;

    DateTime now = DateTime.now();
    DateTime twelveMonthsLater = now.add(const Duration(days: 365));
    List<DateTime> ovulationDates = [];

    print("ppppppp ${globalUserMaster!.averagePeriodLength ?? '5'}");
    DateTime startDate = DateTime.parse(peroidCustomeList[peroidCustomeList.length-1].period_start_date);
    DateTime endDate = DateTime.parse(peroidCustomeList[peroidCustomeList.length-1].period_end_date);
    int periodLength = startDate.difference(endDate).inDays.abs();
    print("ppppppp ${peroidCustomeList[peroidCustomeList.length-1].period_length}");

    while (nextDate.isBefore(twelveMonthsLater)) {
      // Add all days of the period to the list
      for (int i = 0; i < int.parse(peroidCustomeList[peroidCustomeList.length-1].period_length) /*globalUserMaster!.averagePeriodLength ?? '5')*/; i++) {
        if (i == 0) {
          ovulationDates.add(nextDate.add(Duration(days: 14)));
        }
        nextCycleDates.add(nextDate.add(Duration(days: i)));
        gCycleDates.add(CycleDates(nextDate.add(Duration(days: i)), true, false, false, (i + 1)));
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
          i < int.parse(peroidCustomeList[peroidCustomeList.length-1].period_length)/*int.parse(globalUserMaster!.averagePeriodLength ?? '5')*/;
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

    return ovulationDates;
  }

  List<DateTime> calculateFirtileDatesInYear(ovulationDates) {
    List<DateTime> firtileDates = [];
    for (int i = 0; i < ovulationDates.length; i++) {
      DateTime tdate = ovulationDates[i];

      for (int i = 5; i > 0; i--) {
        DateTime fdate = tdate.subtract(Duration(days: i));
        firtileDates.add(fdate);
      }
      for (int i = 1; i <= 2; i++) {
        DateTime fdate = tdate.add(Duration(days: i));
        firtileDates.add(fdate);
      }
    }
    return firtileDates;
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
    List<DateTime> newFertileDates =
        calculateFirtileDatesInYear(newOvulationDates);

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
    for (int i = 0; i < 50; i++) {
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

  bool getPredictedDaySelected(DateTime currentDate){
    for(int i=0;i<peroidCustomeList.length;i++){
      DateTime startPredicatedPeriods = DateTime.parse(
          peroidCustomeList[i].predicated_period_start_date);
      DateTime endPredicatedPeriods = DateTime.parse(
          peroidCustomeList[i].predicated_period_end_date);

      if ((currentDate.isAfter(startPredicatedPeriods) &&
          currentDate.isBefore(endPredicatedPeriods)) ||
          currentDate.isAtSameMomentAs(startPredicatedPeriods) ||
          currentDate.isAtSameMomentAs(endPredicatedPeriods)) {
        return true;
      }
    }
    return false;
  }

  String getCycleDayOrDaysToGo(DateTime currentDate) {


    if (nextCycleDates.isEmpty) {
      return "No cycle dates available";
    }


    nextCycleDates = nextCycleDates.toSet().toList();
    nextCycleDates.sort();

   // print("nextCycleDates  ${nextCycleDates}");
    // Find the most recent period start date before or on the current date
    DateTime? previousCycleStartDate = nextCycleDates
        .where((date) => date.year == currentDate.year && date.month == currentDate.month) // Filter same year and month
        .where((date) => date.isBefore(currentDate) || date.isAtSameMomentAs(currentDate)) // Filter dates before or equal to currentDate
        .fold<DateTime?>(null, (prev, date) => prev == null || date.isBefore(prev) ? date : prev); // Find the minimum date

    // Find the next cycle start date after the current date
    DateTime? nextCycleStartDate = nextCycleDates
        .where((date) => date.isAfter(currentDate)) // Keep only dates after currentDate
        .fold<DateTime?>(null, (prev, date) => prev == null || date.isBefore(prev) ? date : prev); // Find the smallest date


    //print("periodLenght =====>${peroidCustomeList.length}");
    int prL=0;
    if(peroidCustomeList.length<=0){
      prL=0;
    }else{
      prL=int.parse(peroidCustomeList[peroidCustomeList.length-1].period_length);
    }
    // Calculate the cycle day including the current date
    int cycleDay = currentDate.difference(previousCycleStartDate ?? DateTime.now()).inDays + prL/*int.parse(globalUserMaster?.averagePeriodLength ?? "5")*/;

    /* int pday = currentDate.difference(previousCycleStartDate).inDays;
    print('pday $pday'); */
    // Check if the current date is within the period days
    bool isPeriodDay = nextCycleDates.any((date) =>
        date.year == currentDate.year &&
        date.month == currentDate.month &&
        date.day == currentDate.day);

    // print("===================================$cycleDay");
    // print("===================================$previousCycleStartDate");
    // print("===================================$nextCycleStartDate");
    // print("===================================$currentDate");

    int clen = int.parse(globalUserMaster?.averageCycleLength ?? '28');
    globalPday = "$cycleDay";
    if (isPeriodDay) {
      // This is a period day
      int currentMonth = currentDate.month;
      int currentYear = currentDate.year;
      // Filter dates for the current month and year
      List<DateTime> filteredDates = nextCycleDates
          .where(
              (date) => date.month == currentMonth && date.year == currentYear)
          .toList();
      int currentDateIndex = filteredDates[0].difference(currentDate).inDays;
      globalIsPeriodDay = true;

      int num = currentDateIndex.abs() + 1;
      return "Period day $num";
    } else if (cycleDay <= clen) {
      // If the current cycle day is less than or equal to 15, display the day of the current cycle

      int ovdays = 7 + (clen - 21);
      if (ovdays >= cycleDay) {
        ovdays = ovdays - cycleDay;
      } else {
        // ovdays = cycleDay-ovdays;
        int daysToNextCycle = (nextCycleStartDate ?? DateTime.now()).difference(currentDate).inDays;
        //  log("NextCycle Days: ${nextCycleDates}",name: "NextCycle");
        // debugPrint("daysToNextCycle $daysToNextCycle");
        // debugPrint("daysToNextCycle $daysToNextCycle");
        // debugPrint("dNextCycle $nextCycleStartDate");

        if(daysToNextCycle==1) {
          return "Period may\nstart today";
        }else {
          return "Period in $daysToNextCycle days";
        }
      }

      // print("Ovulation in $ovdays Days\n");

      return "Ovulation in $ovdays Days\n";
    } else {
      // Calculate days to go until the next period starts
      int daysToNextCycle =
          (nextCycleStartDate ?? DateTime.now()).difference(currentDate).inDays + 1;
      if(daysToNextCycle==1) {
        return "Period may\nstart today";
      }else {
        return "Period in $daysToNextCycle days";
      }
    }
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
    print("master $master");
    print("master ${master!.success!}");
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
      if ((master.data!.periodData?.length??0) > 0) {
        for (int i = 0; i < (master.data!.periodData?.length??0); i++) {
          var data = PeriodObj(
              user_id: master.data!.user_id,
              period_start_date: master.data!.periodData![i].period_start_date,
              period_end_date: master.data!.periodData![i].period_end_date,
              period_length: master.data!.periodData![i].period_length,
              period_cycle_length:
                  master.data!.periodData![i].period_cycle_length,
              period_month_update:
                  master.data!.periodData![i].period_month_update,
              predicated_period_start_date: master.data!.predicated_period_start_date,
              predicated_period_end_date: master.data!.predicated_period_end_date);
          peroidCustomeList.add(data);
        }
      }

      //check period whithin 14 days
      if(peroidCustomeList.length>1){
        DateTime firstPeriodLastDate = DateTime.parse(peroidCustomeList[0].period_end_date);
        DateTime secondPeriodStartDate = DateTime.parse(peroidCustomeList[1].period_start_date);
        isWithinFourteenDays = firstPeriodLastDate.difference(secondPeriodStartDate).inDays.abs()<=14;
      }

      handleSecondBloc(peroidCustomeList[(master.data!.periodData?.length??0)-1].period_start_date);
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

  Future<void> handleSecondBloc(String dt) async {
    if (gUserType == AppConstants.NEOWME || gUserType == AppConstants.BUDDY) {
      int cycleLength = int.parse(globalUserMaster?.averageCycleLength ?? "28");
      print("Cycle length :: ${globalUserMaster?.averageCycleLength}");
      print(
          "Period length :: ${globalUserMaster?.averagePeriodLength} previouspreriodbegin : ${globalUserMaster?.previousPeriodsBegin ?? ''}");
      //mViewModel.dateParts = dateString.split(RegExp(r'[\s-]+'));
      dateParts = dt.split(RegExp(r'[\s-]+'));
      year = int.parse(dateParts[0]);
      month = int.parse(dateParts[1]);
      day = int.parse(dateParts[2]);
      DateTime previousDate = DateTime(year, month, day);
      print("previousDate :::::::::: $previousDate");
      DateTime newDate = previousDate.add(Duration(days: -cycleLength));
      print("newDate date is :::::::::: $newDate");
      print(" cycleLength date is :::::::::: $cycleLength");

      nextCycleDates = calculateCycleDatesInYear(newDate, cycleLength);
      ovulationDates = calculateOvolutionDatesInYear(newDate, cycleLength);
      firtileDates = calculateFirtileDatesInYear(ovulationDates);
      print("CycleDates date is :::::::::: ${gCycleDates[0].periodDay}");
      generateDaysList();
      print("Next date is :::::::::: $nextCycleDates");

      DateTime today = DateTime.now();
      DateTime? nextCycleDate = nextCycleDates.firstWhere(
        (date) => date.isAfter(today),
        orElse: () => nextCycleDates.last,
      );

      // Pass the next cycle date to the calculateDaysToGo method
      // daysToGo = mViewModel.calculateDaysToGo(nextCycleDate);

      // daysToGo = mViewModel.calculateDaysToGo(mViewModel.nextCycleDates);
    }
  }
}
