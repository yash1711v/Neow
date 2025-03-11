import 'dart:ffi';

import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/date_utils.dart';
import 'package:naveli_2023/utils/global_function.dart';
import 'package:naveli_2023/utils/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:developer';
import 'package:flutter/gestures.dart';

import '../../../../models/date_model.dart';
import '../../home/home_view_model.dart';

enum PaginationDirection {
  up,
  down,
}

class PagedVerticalCalendar extends StatefulWidget {
  PagedVerticalCalendar({
    super.key,
    this.minDate,
    this.maxDate,
    DateTime? initialDate,
    this.monthBuilder,
    this.dayBuilder,
    this.addAutomaticKeepAlives = false,
    this.onDayPressed,
    this.onMonthLoaded,
    this.onPaginationCompleted,
    this.invisibleMonthsThreshold = 1,
    this.physics,
    this.scrollController,
    this.listPadding = EdgeInsets.zero,
    this.startWeekWithSunday = false,
    this.weekdaysToHide = const [],
    this.isChecked,
    required this.dateList,
  }) : initialDate = initialDate ?? DateTime.now().removeTime();
  final DateTime? minDate;

  final DateTime? maxDate;

  final DateTime initialDate;

  final MonthBuilder? monthBuilder;

  final DayBuilder? dayBuilder;

  final bool addAutomaticKeepAlives;

  final ValueChanged<DateTime>? onDayPressed;

  final OnMonthLoaded? onMonthLoaded;

  final ValueChanged<PaginationDirection>? onPaginationCompleted;

  final int invisibleMonthsThreshold;

  final EdgeInsets listPadding;

  final ScrollPhysics? physics;

  final ScrollController? scrollController;

  final bool startWeekWithSunday;

  final List<int> weekdaysToHide;

  var isChecked;

  final List<DateTime> dateList;

  @override
  _PagedVerticalCalendarState createState() => _PagedVerticalCalendarState();
}

class _PagedVerticalCalendarState extends State<PagedVerticalCalendar> {
  late PagingController<int, Month> _pagingReplyUpController;
  late PagingController<int, Month> _pagingReplyDownController;

  final Key downListKey = UniqueKey();
  late bool hideUp;

  @override
  void initState() {
    super.initState();

    if (widget.minDate != null &&
        widget.initialDate.isBefore(widget.minDate!)) {
      throw ArgumentError("initialDate cannot be before minDate");
    }

    if (widget.maxDate != null && widget.initialDate.isAfter(widget.maxDate!)) {
      throw ArgumentError("initialDate cannot be after maxDate");
    }

    hideUp = !(widget.minDate == null ||
        !widget.minDate!.isSameMonth(widget.initialDate));

    _pagingReplyUpController = PagingController<int, Month>(
      firstPageKey: 0,
      invisibleItemsThreshold: widget.invisibleMonthsThreshold,
    );
    _pagingReplyUpController.addPageRequestListener(_fetchUpPage);
    _pagingReplyUpController.addStatusListener(paginationStatusUp);

    _pagingReplyDownController = PagingController<int, Month>(
      firstPageKey: 0,
      invisibleItemsThreshold: widget.invisibleMonthsThreshold,
    );
    _pagingReplyDownController.addPageRequestListener(_fetchDownPage);
    _pagingReplyDownController.addStatusListener(paginationStatusDown);
  }

  @override
  void didUpdateWidget(covariant PagedVerticalCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.minDate != oldWidget.minDate) {
      _pagingReplyUpController.refresh();

      hideUp = !(widget.minDate == null ||
          !widget.minDate!.isSameMonth(widget.initialDate));
    }
  }

  void paginationStatusUp(PagingStatus state) {
    if (state == PagingStatus.completed) {
      return widget.onPaginationCompleted?.call(PaginationDirection.up);
    }
  }

  void paginationStatusDown(PagingStatus state) {
    if (state == PagingStatus.completed) {
      return widget.onPaginationCompleted?.call(PaginationDirection.down);
    }
  }

  /// fetch a new [Month] object based on the [pageKey] which is the Nth month
  /// from the start date
  void _fetchUpPage(int pageKey) async {
    try {
      final month = DateUtils.getMonth(
        DateTime(widget.initialDate.year, widget.initialDate.month - 1, 1),
        widget.minDate,
        pageKey,
        true,
        startWeekWithSunday: widget.startWeekWithSunday,
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onMonthLoaded?.call(month.year, month.month),
      );

      final newItems = [month];
      final isLastPage = widget.minDate != null &&
          widget.minDate!.isSameDayOrAfter(month.weeks.first.firstDay);

      if (isLastPage) {
        return _pagingReplyUpController.appendLastPage(newItems);
      }

      final nextPageKey = pageKey + newItems.length;
      _pagingReplyUpController.appendPage(newItems, nextPageKey);
    } catch (_) {
      _pagingReplyUpController.error;
    }
  }

  void _fetchDownPage(int pageKey) async {
    try {
      final month = DateUtils.getMonth(
        DateTime(widget.initialDate.year, widget.initialDate.month, 1),
        widget.maxDate,
        pageKey,
        false,
        startWeekWithSunday: widget.startWeekWithSunday,
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onMonthLoaded?.call(month.year, month.month),
      );

      final newItems = [month];
      final isLastPage = widget.maxDate != null &&
          widget.maxDate!.isSameDayOrBefore(month.weeks.last.lastDay);

      if (isLastPage) {
        return _pagingReplyDownController.appendLastPage(newItems);
      }

      final nextPageKey = pageKey + newItems.length;
      _pagingReplyDownController.appendPage(newItems, nextPageKey);
    } catch (_) {
      _pagingReplyDownController.error;
    }
  }

  EdgeInsets _getDownListPadding() {
    final double paddingTop = hideUp ? widget.listPadding.top : 0;
    return EdgeInsets.fromLTRB(widget.listPadding.left, paddingTop,
        widget.listPadding.right, widget.listPadding.bottom);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      controller: widget.scrollController,
      physics: widget.physics,
      viewportBuilder: (BuildContext context, ViewportOffset position) {
        return Viewport(
          offset: position,
          center: downListKey,
          slivers: [
            if (!hideUp)
              SliverPadding(
                padding: EdgeInsets.fromLTRB(widget.listPadding.left,
                    widget.listPadding.top, widget.listPadding.right, 0),
                sliver: PagedSliverList(
                  pagingController: _pagingReplyUpController,
                  builderDelegate: PagedChildBuilderDelegate<Month>(
                    itemBuilder:
                        (BuildContext context, Month month, int index) {
                      return _MonthView(
                          month: month,
                          monthBuilder: widget.monthBuilder,
                          dayBuilder: widget.dayBuilder,
                          onDayPressed: widget.onDayPressed,
                          startWeekWithSunday: widget.startWeekWithSunday,
                          weekDaysToHide: widget.weekdaysToHide,
                          isChecked: widget.isChecked,
                          dateList: widget.dateList);
                    },
                  ),
                ),
              ),
            SliverPadding(
              key: downListKey,
              padding: _getDownListPadding(),
              sliver: PagedSliverList(
                pagingController: _pagingReplyDownController,
                builderDelegate: PagedChildBuilderDelegate<Month>(
                  itemBuilder: (BuildContext context, Month month, int index) {
                    return _MonthView(
                        month: month,
                        monthBuilder: widget.monthBuilder,
                        dayBuilder: widget.dayBuilder,
                        onDayPressed: widget.onDayPressed,
                        startWeekWithSunday: widget.startWeekWithSunday,
                        weekDaysToHide: widget.weekdaysToHide,
                        isChecked: widget.isChecked,
                        dateList: widget.dateList);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _pagingReplyUpController.dispose();
    _pagingReplyDownController.dispose();
    super.dispose();
  }
}

class _MonthView extends StatefulWidget {
  const _MonthView({
    required this.month,
    this.monthBuilder,
    this.dayBuilder,
    this.onDayPressed,
    required this.weekDaysToHide,
    required this.startWeekWithSunday,
    required this.isChecked,
    required this.dateList,
  });

  final Month month;
  final MonthBuilder? monthBuilder;
  final DayBuilder? dayBuilder;
  final ValueChanged<DateTime>? onDayPressed;
  final bool startWeekWithSunday;
  final List<int> weekDaysToHide;

  final dynamic isChecked;
  final dynamic dateList;

  @override
  State<_MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<_MonthView> {
  List<int> selectedIndices = [];
  late HomeViewModel mViewModel;
  List<String> weekDay = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
  bool _isChecked = false; // State variable to hold checkbox status
  int ItemIndex = -1; // State variable to hold checkbox status
  DateTime ovulationDate = DateTime(2020, 1, 1);

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);
    final validDates =
        DateUtils.listOfValidDatesInMonth(widget.month, widget.weekDaysToHide);
    final blankSpaces = DateUtils.getNoOfSpaceRequiredBeforeFirstValidDate(
      widget.weekDaysToHide,
      validDates.isNotEmpty ? validDates.first.weekday : 0,
      widget.startWeekWithSunday,
    );

    var no = 0;

    return Column(
      children: <Widget>[
        widget.monthBuilder
                ?.call(context, widget.month.month, widget.month.year) ??
            _DefaultMonthView(
              month: widget.month.month,
              year: widget.month.year,
            ),
        Container(
          color: Color(0xFFFCF7FF),
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              weekDay.length,
              (index) => Flexible(
                child: Text(
                  weekDay[index],
                  style: const TextStyle(
                    color: CommonColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        GridView.builder(
          addRepaintBoundaries: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: DateTime.daysPerWeek - widget.weekDaysToHide.length,
          ),
          itemCount: validDates.length + blankSpaces,
          itemBuilder: (BuildContext context, int index) {
            if (index < blankSpaces) return const SizedBox();

            final date = validDates[index - blankSpaces];
            // final isOvulation = index == 13 ? true:false;
            final vlen = validDates.length;
            // print('blank spaces: $vlen');
            // final isSelected = selectedIndices.contains(index);

            bool isSelected = false;
            bool isPredictedDate = false;
            // mViewModel.nextCycleDates.contains(date);
            bool isOvulation =
                false; //mViewModel.ovulationDates.contains(date);
            bool isFirtile = false; //mViewModel.firtileDates.contains(date);
            DateTime now = DateTime.now();
            // DateTime isStartDate = DateTime.now();
            // peroidCustomeList
            if (peroidCustomeList.isEmpty) {
              isSelected = mViewModel.nextCycleDates.contains(date);
              isOvulation = mViewModel.ovulationDates.contains(date);
              isFirtile = mViewModel.firtileDates.contains(date);
            } else {
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

                // Store logged period dates
                loggedPeriodDates.addAll(List.generate(
                  end.difference(start).inDays + 1,
                  (i) => start.add(Duration(days: i)),
                ));

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
                  endPredictedPeriods =
                      endPredictedPeriods.add(Duration(days: length));

                  // ✅ Stop if the predicted period exceeds the current year
                  if (startPredictedPeriods.year > currentYear) break;

                  List<DateTime> tempPeriodDates = List.generate(
                    endPredictedPeriods
                            .difference(startPredictedPeriods)
                            .inDays +
                        1,
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

                  // ✅ Calculate future fertile and ovulation dates
                  DateTime futureFertileStart =
                      endPredictedPeriods.add(Duration(days: 3));
                  DateTime futureFertileEnd =
                      futureFertileStart.add(Duration(days: 5));
                  DateTime futureOvulationDay =
                      futureFertileStart.add(Duration(days: 4));

                  // ✅ Add fertile dates only if they fall within the current year
                  if (futureFertileStart.year == currentYear &&
                      futureFertileEnd.year == currentYear) {
                    List<DateTime> tempFertileDates = List.generate(
                      futureFertileEnd.difference(futureFertileStart).inDays +
                          1,
                      (i) => futureFertileStart.add(Duration(days: i)),
                    ).where((date) => date.year == currentYear).toList();

                    fertileDates.addAll(tempFertileDates);
                  }

                  // ✅ Add ovulation date only if it's within the current year
                  if (futureOvulationDay.year == currentYear) {
                    ovulationDates.add(futureOvulationDay);
                  }
                }

                // **Past Fertile Dates (Based on last period start date)**
                DateTime lastFertileStart = end.add(Duration(days: 3));
                DateTime lastFertileEnd =
                    lastFertileStart.add(Duration(days: 5));
                DateTime lastOvulationDay =
                    lastFertileStart.add(Duration(days: 4));

                if (lastFertileStart.year == currentYear) {
                  fertileDates.addAll(List.generate(
                    lastFertileEnd.difference(lastFertileStart).inDays + 1,
                    (i) => lastFertileStart.add(Duration(days: i)),
                  ));
                }

                if (lastOvulationDay.year == currentYear) {
                  ovulationDates.add(lastOvulationDay);
                }
              }

              // ✅ DEBUG: Check if April is included
              bool hasAprilFertileDates = fertileDates
                  .any((date) => date.month == 4 && date.year == currentYear);

              if (!hasAprilFertileDates) {
                debugPrint("❌ April Fertile Dates Missing - Adding them now");

                // Get the last known period cycle
                if (peroidCustomeList.isNotEmpty) {
                  var lastCycle = peroidCustomeList.last;

                  DateTime lastPeriodEnd =
                      DateTime.parse(lastCycle.period_end_date);
                  int cycleLength = int.parse(lastCycle.period_cycle_length);

                  // Predict next period start in April
                  DateTime predictedStart =
                      lastPeriodEnd.add(Duration(days: cycleLength));

                  while (predictedStart.month < 4) {
                    predictedStart =
                        predictedStart.add(Duration(days: cycleLength));
                  }

                  if (predictedStart.month == 4) {
                    DateTime predictedEnd = predictedStart.add(Duration(
                        days: int.parse(lastCycle.avg_cycle_length ?? "5")));

                    // Add fertile and ovulation dates
                    DateTime aprilFertileStart =
                        predictedEnd.add(Duration(days: 3));
                    DateTime aprilFertileEnd =
                        aprilFertileStart.add(Duration(days: 5));
                    DateTime aprilOvulation =
                        aprilFertileStart.add(Duration(days: 4));

                    // Add fertile dates
                    fertileDates.addAll(List.generate(
                      aprilFertileEnd.difference(aprilFertileStart).inDays + 1,
                      (i) => aprilFertileStart.add(Duration(days: i)),
                    ));

                    // Add ovulation date
                    ovulationDates.add(aprilOvulation);

                    debugPrint("✅ April Fertile Dates Added");
                  }
                }
              } else {
                debugPrint("✅ April Fertile Dates Found");
              }

// Checking if the given `date` falls in the calculated dates
              if (loggedPeriodDates.contains(date)) {
                isSelected = true;
              }

              if (predictedPeriodDates.contains(date)) {
                isPredictedDate = true;
              }

              if (fertileDates.contains(date)) {
                isFirtile = true;
              }

              if (ovulationDates.contains(date)) {
                isOvulation = true;
              }
            }

            List<int> months = [];
            for (int i = 1; i <= 1; i++) {
              DateTime monthDate = DateTime(now.year, now.month - i);

              // Adjust for the year if the month is less than 1
              if (monthDate.month < 1) {
                monthDate = DateTime(monthDate.year - 1, 12);
              }

              months.add(monthDate.month);
            }
            if (!months.contains(now.month)) {
              months.add(now.month);
            }
            bool currentDateCheck = false;

            // debugPrint('dateList: ${widget.dateList}');
            // debugPrint('dateList Date: $date');

            if (widget.dateList?.contains(date)) {
              currentDateCheck = true;
            }

            // for (var dateRange in peroidCustomeList) {
            //   DateTime start = DateTime.parse(dateRange.period_start_date);
            //
            //   DateTime end = DateTime.parse(dateRange.period_end_date);
            //
            //   if (date.isAfter(start) && date.isBefore(end) ||
            //       date.isAtSameMomentAs(start) ||
            //       date.isAtSameMomentAs(end)) {
            //     currentDateCheck = true;
            //     if (widget.dateList.contains(date)) {
            //       widget.dateList.remove(date);
            //     } else {
            //       widget.dateList.add(date);
            //     }
            //   }
            //
            // }

            // print(widget.dateList);
            return AspectRatio(
              aspectRatio: 1.0,
              child: InkWell(
                child: widget.dayBuilder?.call(context, date) ??
                    Center(
                      child: widget.isChecked &&
                              months.contains(date.month) &&
                              (date.isBefore(now) || date.isAtSameMomentAs(now))
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (widget.dateList.contains(date)) {
                                    widget.dateList.remove(date);
                                  } else {
                                    widget.dateList.add(date);
                                  }
                                  widget.onDayPressed!(date);
                                });
                              },
                              child: Container(
                                height: 70,
                                width: 70.0,
                                decoration: BoxDecoration(
                                    // Optional: Add decoration if needed (e.g., background color, border, etc.)
                                    ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Center the content vertically
                                  children: [
                                    Text(
                                      date.day.toString(),
                                      style: getAppStyle(
                                        fontSize: 15,
                                        color: CommonColors.blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25, // Width of the circle
                                      height: 25, // Height of the circle
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            currentDateCheck =
                                                !currentDateCheck; // Toggle the checkbox state
                                            if (currentDateCheck) {
                                              if (!widget.dateList
                                                  .contains(date)) {
                                                widget.dateList.add(
                                                    date); // Add date when checked
                                              }
                                            } else {
                                              widget.dateList.remove(
                                                  date); // Remove date when unchecked
                                            }
                                            widget.onDayPressed!(
                                                date); // Callback when the day is pressed
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            // Makes the container circular
                                            color: currentDateCheck
                                                ? CommonColors
                                                    .secondaryColor // Background color when checked
                                                : Colors.transparent,
                                            // Transparent when unchecked
                                            border: Border.all(
                                              color: currentDateCheck
                                                  ? CommonColors
                                                      .secondaryColor // Border color when checked
                                                  : Colors.grey,
                                              // Border color when unchecked
                                              width: 2, // Border width
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: currentDateCheck
                                              ? Icon(
                                                  Icons.check,
                                                  // Display checkmark icon when checked
                                                  color: Colors
                                                      .white, // Color of the checkmark
                                                  size: 20, // Icon size
                                                )
                                              : null,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 40,
                              width: 40.0,
                              // padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? null
                                    : isOvulation
                                        ? null
                                        : isFirtile
                                            ? null
                                            : Colors.transparent,
                                gradient: isSelected
                                    ? LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFFFF9D93),
                                          Color(0xFFFFB5AE),
                                        ],
                                      )
                                    : isOvulation
                                        ? mViewModel.getGradientGreen()
                                        : isPredictedDate
                                            ? LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xFFFFFFFF),
                                                  Color(0xFFFFFFFF),
                                                ],
                                              )
                                            : null,
                                // color: isSelected ? CommonColors.primaryColor : CommonColors.mTransparent,
                                shape: BoxShape.circle,
                              ),
                              child: DottedBorder(
                                color: isFirtile
                                    ? CommonColors.greenColor
                                    : isPredictedDate
                                        ? CommonColors.mRed
                                        : CommonColors.mTransparent,
                                dashPattern: [4, 3],
                                strokeWidth:
                                    (isFirtile || isPredictedDate) ? 2 : 0,
                                borderType: BorderType.Circle,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      print(date);
                                    },
                                    child: Text(
                                      date.day.toString(),
                                      style: getAppStyle(
                                        fontSize: 15,
                                        color: isSelected
                                            ? CommonColors.mWhite
                                            : isOvulation
                                                ? CommonColors.mWhite
                                                : CommonColors.blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
              ),
            );
          },
        ),
        const SizedBox(height: 10.0),
        // ElevatedButton(
        //   onPressed: () {
        //     _updateButtonText();

        //     // Add your onPressed code here!
        //   },
        //   child: widget.isChecked ? Text('Update') : Text('Edit'),
        // ),
        Divider(
          color: CommonColors.mGrey.withOpacity(.3),
          thickness: 2,
        ),
      ],
    );
  }
}

class _DefaultMonthView extends StatelessWidget {
  final int month;
  final int year;

  _DefaultMonthView({required this.month, required this.year});

  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        '${months[month - 1]} $year',
        style: getAppStyle(
            color: CommonColors.blackColor,
            fontSize: 18.0,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

typedef MonthBuilder = Widget Function(
    BuildContext context, int month, int year);
typedef DayBuilder = Widget Function(BuildContext context, DateTime date);

typedef OnMonthLoaded = void Function(int year, int month);
