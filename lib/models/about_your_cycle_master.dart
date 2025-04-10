class AboutYourCycleReponse {
  List<CycleTableData>? _data;
  bool? _success;
  String? _message;

  AboutYourCycleReponse(
      {bool? success, String? message, List<CycleTableData>? data}) {
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

  List<CycleTableData>? get data => _data;

  set postsData(List<CycleTableData>? postsData) => _data = data;

  bool? get success => _success;

  set success(bool? success) => _success = success;

  String? get message => _message;

  set message(String? message) => _message = message;

  AboutYourCycleReponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <CycleTableData>[];
      json['data'].forEach((v) {
        _data!.add(CycleTableData.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    data['success'] = _success;
    data['message'] = _message;
    return data;
  }
}

class CycleTableData {
  String? _periodDate;
  String? _periodLength;
  String? _periodCycleLength;
  int? _cycleLengthDeviation;
  int? _periodLengthDeviation;

  CycleTableData(
      {String? periodDate,
      String? periodLength,
      String? periodCycleLength,
      int? cycleLengthDeviation,
      int? periodLengthDeviation,}) {
    if (periodDate != null) {
      _periodDate = periodDate;
    }
    if (periodLength != null) {
      _periodLength = periodLength;
    }
    if (periodCycleLength != null) {
      _periodCycleLength = periodCycleLength;
    }
    if (cycleLengthDeviation != null) {
      _cycleLengthDeviation = cycleLengthDeviation;
    }
    if (periodLengthDeviation != null) {
      _periodLengthDeviation = periodLengthDeviation;
    }
  }

  int? get cycleLengthDeviation => _cycleLengthDeviation;

  set cycleLengthDeviation(int? deviation) => _cycleLengthDeviation = deviation;

  int? get periodLengthDeviation => _periodLengthDeviation;

  set periodLengthDeviation(int? deviation) => _periodLengthDeviation = deviation;

  String? get periodDate => _periodDate;

  set periodDate(String? periodDate) => _periodDate = periodDate;

  String? get periodCycleLength => _periodCycleLength;

  set periodCycleLength(String? periodCycleLength) => _periodCycleLength = periodCycleLength;

  String? get periodLength => _periodLength;

  set periodLength(String? periodLength) => _periodLength = periodLength;

  CycleTableData.fromJson(Map<String, dynamic> json) {
    _periodDate = json['period_date'];
    _periodCycleLength = json['period_cycle_length'].toString();
    _periodLength = json['period_length'].toString();
    _cycleLengthDeviation = json['period_cycle_length_deviation'];
    _periodLengthDeviation = json['period_length_deviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['period_date'] = _periodDate;
    data['period_cycle_length'] = _periodCycleLength;
    data['period_length'] = _periodLength;
    data['period_cycle_length_deviation'] = _cycleLengthDeviation;
    data['period_length_deviation'] = _periodLengthDeviation;
    return data;
  }
}
