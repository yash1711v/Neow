import 'package:flutter/cupertino.dart';

import '../models/login_master.dart';
import '../models/cycle_dates_master.dart';

class PeriodInfoListResponse {
  PeriodObj? _data;
  bool? _success;
  String? _message;

  PeriodInfoListResponse({PeriodObj? data, bool? success, String? message}) {
    if (data != null) {
      _data = data;
    }
    if (success != null) {
      _success = success;
    }
    if (message != null) {
      _message = message;
    }
  }

  PeriodObj? get data => _data;

  set data(PeriodObj? data) => _data = data;

  bool? get success => _success;

  set success(bool? success) => _success = success;

  String? get message => _message;

  set message(String? message) => _message = message;

  PeriodInfoListResponse.fromJson(Map<String, dynamic> json) {
    /*if (json['data'] != null) {
      _data = PeriodObj>[];
      json['data'].forEach((v) {
        _data!.add(PeriodObj.fromJson(v));
      });
    }*/
    if (json['data'] != null) {
      _data = PeriodObj.fromJson(json['data']);
    }
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    /*if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }*/
    data['data'] = _data;
    data['success'] = _success;
    data['message'] = _message;
    return data;
  }
}

class PeriodObj {
  int user_id;
  String period_start_date;
  String period_end_date;
  String period_length;
  String period_cycle_length;
  String period_month_update;
  String predicated_period_start_date;
  String predicated_period_end_date;
  List<PeriodData>? periodData;

  PeriodObj({
    required this.user_id,
    required this.period_start_date,
    required this.period_end_date,
    required this.period_length,
    required this.period_cycle_length,
    required this.period_month_update,
    required this.predicated_period_start_date,
    required this.predicated_period_end_date,
    this.periodData,
  });

  factory PeriodObj.fromJson(Map<String, dynamic> json) {
    var periodsInfo =
        json['periods_info'] as List?; // Handle potential null case
    List<PeriodData> periodDataList = periodsInfo != null
        ? periodsInfo.map((v) => PeriodData.fromJson(v)).toList()
        : []; // Default to empty list if null
    return PeriodObj(
        user_id: json['user_id'] ?? 1,
        period_start_date: json['period_start_date'] ?? "",
        period_end_date: json['period_end_date'] ?? "",
        period_length: json['period_length'] ?? "",
        period_cycle_length: json['period_cycle_length'] ?? "",
        period_month_update: json['period_month_update'] ?? "",
        predicated_period_start_date:
            json['predicated_period_start_date'] ?? "",
        predicated_period_end_date: json['predicated_period_end_date'] ?? "",
        periodData: periodDataList);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user_id;
    data['period_start_date'] = period_start_date;
    data['period_end_date'] = period_end_date;
    data['predicated_period_start_date'] = predicated_period_start_date;
    data['predicated_period_end_date'] = predicated_period_end_date;
    data['period_length'] = period_length;
    data['period_cycle_length'] = period_cycle_length;
    data['period_month_update'] = period_month_update;
    if (periodData != null && periodData!.isNotEmpty) {
      data['periods_info'] = periodData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PeriodData {
  String period_start_date;
  String period_end_date;
  String period_length;
  String period_cycle_length;
  String period_month_update;

  PeriodData({
    required this.period_start_date,
    required this.period_end_date,
    required this.period_length,
    required this.period_cycle_length,
    required this.period_month_update,
  });

  factory PeriodData.fromJson(Map<String, dynamic> json) {
    return PeriodData(
      period_start_date: json['period_start_date'] ?? "",
      period_end_date: json['period_end_date'] ?? "",
      period_length: json['period_length'] ?? "",
      period_cycle_length: json['period_cycle_length'] ?? "",
      period_month_update: json['period_month_update'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['period_start_date'] = period_start_date;
    data['period_end_date'] = period_end_date;
    data['period_length'] = period_length;
    data['period_cycle_length'] = period_cycle_length;
    data['period_month_update'] = period_month_update;
    return data;
  }
}

bool connectivity = true, isNotifyConnectivity = false;
String languageCode = "en";
GlobalKey<NavigatorState> mainNavKey = GlobalKey();
String gUserType = "";
UserMaster? globalUserMaster;
List<CycleDates> gCycleDates = [];
// String connectivity = "";
String appVersion = "";
String uuid = "";
String globalPday = "0";
bool globalIsPeriodDay = false;
String platform = "";
bool isWithinFourteenDays = false;

List<PeriodObj> peroidCustomeList = [];
bool _isLogEdit = false;

// Getter
bool get isLogEdit => _isLogEdit;

// Setter
set isLogEdit(bool value) {
  _isLogEdit = value;
}
