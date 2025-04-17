import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/utils/date_utils.dart';

import '../ui/naveli_ui/home/home_view_model.dart';
import '../utils/global_variables.dart';
import 'dart:math';

class HorizontalCalendar extends StatefulWidget {
  HomeViewModel mViewModel;

  HorizontalCalendar({required this.mViewModel});

  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  final ScrollController _scrollController = ScrollController();
  List<DateTime> dates = [];

  @override
  void initState() {
    super.initState();
    dates = _generateDates();
    // Scroll to the current date position
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollToCurrentDate();
    // });
  }

  List<DateTime> _generateDates() {
    DateTime startDate =
    DateTime(DateTime.now().year, 1, 1); // Jan 1st of current year
    DateTime endDate =
    DateTime(DateTime.now().year + 2, 12, 31); // Dec 31st of current year

    List<DateTime> dates = [];
    for (DateTime date = startDate;
    date.isBefore(endDate.add(Duration(days: 1)));
    date = date.add(Duration(days: 1))) {
      dates.add(date);
    }
    return dates;
  }

  void _scrollToCurrentDate() {
    int currentIndex = dates.indexWhere((date) =>
    date.year == widget.mViewModel.selectedDate.year &&
        date.month == widget.mViewModel.selectedDate.month &&
        date.day == widget.mViewModel.selectedDate.day);

    if (currentIndex != -1) {
      _scrollController.jumpTo(currentIndex * 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color(0XFFFBF5F7),
          height: 85,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              DateTime date = dates[index];
              bool isSelected =
                  date.day == widget.mViewModel.selectedDate.day &&
                      date.month == widget.mViewModel.selectedDate.month &&
                      date.year == widget.mViewModel.selectedDate.year;

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
              peroidCustomeList.forEach((element) {
                element.predictions!.forEach((predictions) {
                  for (DateTime start =
                  DateTime.parse(predictions.predictedStart);
                  start.isSameDayOrBefore(
                      DateTime.parse(predictions.predictedEnd));
                  start = start.add(Duration(days: 1))) {
                    predictedPeriodDates.add(start);

                  }
                  for (DateTime start =
                  DateTime.parse(predictions.fertileWindowStart);
                  start.isSameDayOrBefore(
                      DateTime.parse(predictions.fertileWindowEnd));
                  start = start.add(Duration(days: 1))) {
                    fertileDates.add(start);

                  }

                  ovulationDates.add(DateTime.parse(predictions.ovulationDay));

                });

              });


              if (loggedPeriodDates.contains(date)) {
                PriodDates = true;
              }

              if (predictedPeriodDates.contains(date)) {
                isPredictedDate = true;
              }

              if (fertileDates.contains(date)) {
                isFirtile = true;
              }
              // ovulationDates.removeAt(ovulationDates.length - 1);
              if (ovulationDates.contains(date)) {
                if (date.year < date.year + 1) {
                  isOvulation = true;
                }
              }

              return Visibility(
                visible: date.isSameDayOrAfter(DateTime.now()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.MMM().format(date), // Month
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.mViewModel.selectedDate = date;
                        });
                        debugPrint(
                            "Selected Date: ${widget.mViewModel.selectedDate}");
                        widget.mViewModel.updateSelectedDate(date);
                        // widget.mViewModel.getCycleDayOrDaysToGo(selectedDate);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                            (isFirtile || isPredictedDate) ? 10.0 : 0),
                        child: DottedBorder(
                          color: isFirtile
                              ? Colors.green
                              : isPredictedDate
                              ? Colors.red
                              : Colors.transparent,
                          // Border color
                          strokeWidth: 2,
                          // Border width
                          dashPattern: [6, 3],
                          // Defines the pattern: [dot length, space length]
                          borderType: BorderType.Circle,
                          // Shape of the border
                          radius: Radius.circular(0),
                          padding: EdgeInsets.zero,

                          child: Center(
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? Colors.grey
                                    : PriodDates
                                    ? Color(0xFFFF9D93)
                                    : isOvulation
                                    ? Colors.green
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  date.day.toString(), // Day
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:
                                    isSelected || PriodDates || isOvulation
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //
                      // DateContainer(
                      //   date: date,
                      //   isSelected: isSelected,
                      //   isPeriodDate: PriodDates,
                      //   isOvulation: isOvulation,
                      //   showDottedBorder: isFirtile,
                      //   isPredictedDate: isPredictedDate,
                      // )
                      // Container(
                      //   width: 50,
                      //   margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: isSelected ? Colors.grey : PriodDates? Color(0xFFFF9D93) : isOvulation ? Colors.green: Colors.transparent,
                      //
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10.0),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text(
                      //           DateFormat.MMM().format(date), // Month
                      //           style: TextStyle(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.bold,
                      //             color: isSelected || PriodDates || isOvulation ? Colors.white : Colors.black,
                      //           ),
                      //         ),
                      //         // SizedBox(height: 5),
                      //         Text(
                      //           date.day.toString(), // Day
                      //           style: TextStyle(
                      //             fontSize: 20,
                      //             fontWeight: FontWeight.bold,
                      //             color: isSelected || PriodDates || isOvulation ? Colors.white : Colors.black,
                      //           ),
                      //         ),
                      //         // SizedBox(height: 5),
                      //         // Text(
                      //         //   DateFormat.E().format(date), // Weekday
                      //         //   style: TextStyle(
                      //         //     fontSize: 14,
                      //         //     fontWeight: FontWeight.bold,
                      //         //     color: isSelected ? Colors.white : Colors.black,
                      //         //   ),
                      //         // ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DateContainer extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isPeriodDate;
  final bool isPredictedDate;
  final bool isOvulation;
  final bool showDottedBorder; // Condition for dotted border

  DateContainer({
    required this.date,
    required this.isSelected,
    required this.isPeriodDate,
    required this.isOvulation,
    required this.showDottedBorder,
    required this.isPredictedDate, // Pass condition for border
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Apply dotted border conditionally
        if (showDottedBorder)
          CustomPaint(
              size: Size(55, 55), // Adjust size to fit Container
              painter: DottedCircleBorderPainter2()),
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? Colors.grey
                : isPeriodDate
                ? Color(0xFFFF9D93)
                : isOvulation
                ? Colors.green
                : isPredictedDate
                ? Colors.orange
                : Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat.MMM().format(date), // Month
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected || isPeriodDate || isOvulation
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Text(
                date.day.toString(), // Day
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isSelected || isPeriodDate || isOvulation
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom painter for the dotted border
class DottedCircleBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green // Border color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final double radius = size.width / 2;
    const double gap = 12; // Gap between dots
    const double dotRadius = 2; // Dot size

    for (double angle = 0; angle < 360; angle += gap) {
      double radian = angle * (pi / 180);
      double x = radius + (radius - 2) * cos(radian);
      double y = radius + (radius - 2) * sin(radian);
      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DottedCircleBorderPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red // Border color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final double radius = size.width / 2;
    const double gap = 12; // Gap between dots
    const double dotRadius = 2; // Dot size

    for (double angle = 0; angle < 360; angle += gap) {
      double radian = angle * (pi / 180);
      double x = radius + (radius - 2) * cos(radian);
      double y = radius + (radius - 2) * sin(radian);
      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}