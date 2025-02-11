// import 'package:flutter/material.dart';
// import 'package:naveli_2023/ui/naveli_ui/calendar/yearly_calendar/screen_sizes.dart';
// import 'package:naveli_2023/ui/naveli_ui/calendar/yearly_calendar/year_view.dart';
// import 'package:naveli_2023/utils/common_colors.dart';
// import 'package:provider/provider.dart';
//
// import '../../home/home_view_model.dart';
//
//
// class ScrollingYearsCalendar extends StatefulWidget {
//   ScrollingYearsCalendar({
//     required this.context,
//     required this.initialDate,
//     required this.firstDate,
//     required this.lastDate,
//     required this.currentDateColor,
//     this.highlightedDates,
//     this.highlightedDateColor,
//     this.monthNames,
//     this.onMonthTap,
//     this.monthTitleStyle,
//   })  : assert(context != null),
//         assert(initialDate != null),
//         assert(firstDate != null),
//         assert(lastDate != null),
//       /*  assert(!initialDate.isBefore(firstDate),
//         'initialDate must be on or after firstDate'),
//         assert(!initialDate.isAfter(lastDate),
//         'initialDate must be on or before lastDate'),
//         assert(!firstDate.isAfter(lastDate),
//         'lastDate must be on or after firstDate'),*/
//         assert(currentDateColor != null),
//         assert(highlightedDates == null || highlightedDateColor != null,
//         'highlightedDateColor is required if highlightedDates is not null'),
//         assert(
//         monthNames == null || monthNames.length == DateTime.monthsPerYear,
//         'monthNames must contain all months of the year');
//
//   final BuildContext context;
//   final DateTime initialDate;
//   final DateTime firstDate;
//   final DateTime lastDate;
//   final Color currentDateColor;
//   final List<DateTime>? highlightedDates;
//   final Color? highlightedDateColor;
//   final List<String>? monthNames;
//   final Function? onMonthTap;
//   final TextStyle? monthTitleStyle;
//
//   @override
//   _ScrollingYearsCalendarState createState() => _ScrollingYearsCalendarState();
// }
//
// class _ScrollingYearsCalendarState extends State<ScrollingYearsCalendar> {
//   /// Gets a widget with the view of the given year.
//   YearView _getYearView(int year) {
//     return YearView(
//       context: context,
//       year: year,
//       currentDateColor: widget.currentDateColor,
//       highlightedDates: widget.highlightedDates,
//       highlightedDateColor: widget.highlightedDateColor,
//       monthNames: widget.monthNames,
//       onMonthTap: widget.onMonthTap,
//       monthTitleStyle: widget.monthTitleStyle,
//     );
//   }
//   late HomeViewModel mViewModel;
//   @override
//   Widget build(BuildContext context) {
//     mViewModel = Provider.of<HomeViewModel>(context);
//
//     mViewModel.nextCycleDates;
//     final int _itemCount = widget.lastDate.year - widget.firstDate.year + 1;
//
//     // Makes sure the right initial offset is calculated so the listview
//     // jumps to the initial year.
//     final double _initialOffset =
//         (widget.initialDate.year - widget.firstDate.year) * getYearViewHeight(context);
//     final ScrollController _scrollController =
//     ScrollController(initialScrollOffset: _initialOffset);
//
//     return Scaffold(
//       backgroundColor: CommonColors.mTransparent,
//       body: ListView.builder(
//         padding: const EdgeInsets.only(bottom: 1.0),
//         shrinkWrap: true,
//         controller: _scrollController,
//         itemCount: _itemCount,
//         itemBuilder: (BuildContext context, int index) {
//           final int year = index + widget.firstDate.year;
//           return _getYearView(year);
//         },
//       ),
//     );
//   }
// }