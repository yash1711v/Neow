import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/date_utils.dart';
import 'package:naveli_2023/utils/global_function.dart';
import 'package:naveli_2023/utils/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../home/home_view_model.dart';

class YearCalendarView extends StatefulWidget {
  const YearCalendarView({super.key});

  @override
  _YearCalendarViewState createState() => _YearCalendarViewState();
}

class _YearCalendarViewState extends State<YearCalendarView> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Year Calendar'),
      // ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (1 / 1.4),
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return MonthView(
            month: index + 1,
            year: DateTime.now().year,
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
            selectedDate: selectedDate, // Uncommented selectedDate here
          );
        },
      ),
    );
  }
}

class MonthView extends StatefulWidget {
  final int month;
  final int year;
  final Function(DateTime) onDateSelected;
  final DateTime? selectedDate; // Uncommented selectedDate here

  const MonthView({
    super.key,
    required this.month,
    required this.year,
    required this.onDateSelected,
    this.selectedDate,
  });

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  late HomeViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    refreshView();
  }

  refreshView() {
    print("daaaaaaaaaaaaaaaaa=>${peroidCustomeList[0].period_start_date}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);
    DateTime ovulationDate = DateTime(2020, 1, 1);

    final firstDayOfWeek = DateTime(widget.year, widget.month, 1).weekday;
    final daysInMonth = getDaysInMonth(widget.year, widget.month);
    final List<Widget> dayWidgets = List.generate(firstDayOfWeek - 1, (index) {
      // Add empty containers for days before the first day of the month
      return Container();
    });
    List<String> weekDay = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];

    // Generate day widgets for the actual days in the month
    for (int i = 1; i <= daysInMonth; i++) {
      final date = DateTime(widget.year, widget.month, i);
      final isSelectedDate = widget.selectedDate != null &&
          date.day == widget.selectedDate?.day &&
          date.month == widget.selectedDate?.month &&
          date.year == widget.selectedDate?.year;

      bool isHighlighted = false;
      bool isFuturePredictedHighlighted = false;
      bool isOvulation = false;
      bool isFertile = false;
      DateTime now = DateTime.now();

      for (var dateRange in peroidCustomeList) {
        DateTime start = DateTime.parse(dateRange.period_start_date);
        DateTime end = DateTime.parse(dateRange.period_end_date);
        int cycleLength = int.parse(dateRange.period_cycle_length);

        if (date.isAfter(start) && date.isBefore(end) ||
            date.isAtSameMomentAs(start) ||
            date.isAtSameMomentAs(end)) {
          isHighlighted = true;
        }

        DateTime previousOvulationDay = start.subtract(Duration(days: 14));
        DateTime previousFertileStartDate = previousOvulationDay.subtract(Duration(days: 5));
        DateTime previousFertileEndDate = previousOvulationDay.add(Duration(days: 2));

        if (date.isSameDay(previousOvulationDay)) {
          isOvulation = true;
        }

        if (date.isAfter(previousFertileStartDate) && date.isBefore(previousFertileEndDate) ||
            date.isAtSameMomentAs(previousFertileStartDate) ||
            date.isAtSameMomentAs(previousFertileEndDate)) {
          isFertile = true;
        }
      }

      for (DateTime predictedStartDate in mViewModel.nextCycleDates) {
        DateTime predictedOvulationDay = predictedStartDate.add(Duration(days: 14));
        DateTime predictedFertileStartDate = predictedOvulationDay.subtract(Duration(days: 5));
        DateTime predictedFertileEndDate = predictedOvulationDay.add(Duration(days: 2));

        if (date.isSameDay(predictedStartDate)) {
          isHighlighted = true;
        }

        if (date.isAfter(predictedFertileStartDate) && date.isBefore(predictedFertileEndDate) ||
            date.isAtSameMomentAs(predictedFertileStartDate) ||
            date.isAtSameMomentAs(predictedFertileEndDate)) {
          isFertile = true;
        }

        if (date.isSameDay(predictedOvulationDay)) {
          isOvulation = true;
        }

        if (date.isAfter(now) && date.month >= now.month && date.month <= now.month + 12) {
          bool isWithinNext12Months = date.year == now.year || (date.year == now.year + 1 && date.month <= 12);
          if (isWithinNext12Months) {
            isFuturePredictedHighlighted = mViewModel.nextCycleDates.contains(date);
          }
        }
      }

      if (date.isSameDay(ovulationDate)) {
        isOvulation = true;
      }

      if (date.isAfter(now)) {
        bool isInUpcomingMonths = date.year == now.year ||
            (date.year == now.year + 1 && date.month <= now.month);

        if (isInUpcomingMonths) {
          isHighlighted = mViewModel.nextCycleDates.contains(date);
          isOvulation = mViewModel.ovulationDates.contains(date);
        }

        isFuturePredictedHighlighted = isInUpcomingMonths;
      } else {
        isFuturePredictedHighlighted = false;
      }

      dayWidgets.add(
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: isHighlighted && !isFuturePredictedHighlighted
                  ? BoxDecoration(
                gradient: mViewModel.getGradient(),
                borderRadius: BorderRadius.circular(8),
              )
                  : isHighlighted && isFuturePredictedHighlighted
                  ? null
                  : isOvulation
                  ? BoxDecoration(
                gradient: mViewModel.getGradientGreen(),
                borderRadius: BorderRadius.circular(8),
              )
                  : isSelectedDate
                  ? BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              )
                  : null,
              child: DottedBorder(
                color: isFertile
                    ? CommonColors.greenColor
                    : isHighlighted && isFuturePredictedHighlighted
                    ? CommonColors.mRed
                    : CommonColors.mTransparent,
                dashPattern: [4, 3],
                strokeWidth: isFertile ? 1 : 0,
                borderType: BorderType.Circle,
                child: Center(
                  child: Text(
                    '$i',
                    style: TextStyle(
                      fontSize: 6,
                      color: (isSelectedDate || (isHighlighted && !isFuturePredictedHighlighted) || isOvulation)
                          ? Colors.white
                          : (isHighlighted && isFuturePredictedHighlighted)
                          ? Colors.black
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat.MMMM().format(DateTime(widget.year, widget.month)),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ),

          Container(
            color: Color(0xFFFFFFFF),
            padding: const EdgeInsets.only(top: 10, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                weekDay.length,
                (index) => Flexible(
                  child: Text(
                    weekDay[index],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Display dates
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 7,
            children: dayWidgets,
          ),
        ],
      ),
    );
  }
}
