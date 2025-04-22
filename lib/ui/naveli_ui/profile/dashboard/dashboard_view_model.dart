import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/database/app_preferences.dart';
import 'package:naveli_2023/utils/global_variables.dart';

import '../../../../models/about_your_cycle_master.dart';
import '../../../../models/common_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import 'package:http/http.dart' as http;

class User {
  int id;
  String name;
  String? email; // Nullable field
  int roleId;
  String uniqueId;
  String birthdate;
  int gender;
  String? genderType; // Nullable field
  String? randomCode; // Nullable field
  String mobile;
  String deviceToken;
  String? image; // Nullable field
  int relationshipStatus;
  String averageCycleLength;
  String previousPeriodsBegin;
  String? previousPeriodsMonth; // Nullable field
  String averagePeriodLength;
  String? humApkeHeKon; // Nullable field
  String? emailVerifiedAt; // Nullable field
  String? password; // Nullable field
  String state;
  String city;
  int status;
  String? rememberToken; // Nullable field
  String createdAt;
  String updatedAt;
  String? deletedAt; // Nullable field

  // Constructor to initialize properties
  User({
    required this.id,
    required this.name,
    this.email,
    required this.roleId,
    required this.uniqueId,
    required this.birthdate,
    required this.gender,
    this.genderType,
    this.randomCode,
    required this.mobile,
    required this.deviceToken,
    this.image,
    required this.relationshipStatus,
    required this.averageCycleLength,
    required this.previousPeriodsBegin,
    this.previousPeriodsMonth,
    required this.averagePeriodLength,
    this.humApkeHeKon,
    this.emailVerifiedAt,
    this.password,
    required this.state,
    required this.city,
    required this.status,
    this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  // Factory method to create an object from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      roleId: json['role_id'],
      uniqueId: json['unique_id'],
      birthdate: json['birthdate'],
      gender: json['gender'],
      genderType: json['gender_type'],
      randomCode: json['random_code'],
      mobile: json['mobile'],
      deviceToken: json['device_token'],
      image: json['image'],
      relationshipStatus: json['relationship_status'],
      averageCycleLength: json['average_cycle_length'],
      previousPeriodsBegin: json['previous_periods_begin'],
      previousPeriodsMonth: json['previous_periods_month'],
      averagePeriodLength: json['average_period_length'],
      humApkeHeKon: json['hum_apke_he_kon'],
      emailVerifiedAt: json['email_verified_at'],
      password: json['password'],
      state: json['state'],
      city: json['city'],
      status: json['status'],
      rememberToken: json['remember_token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  // Method to convert the object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role_id': roleId,
      'unique_id': uniqueId,
      'birthdate': birthdate,
      'gender': gender,
      'gender_type': genderType,
      'random_code': randomCode,
      'mobile': mobile,
      'device_token': deviceToken,
      'image': image,
      'relationship_status': relationshipStatus,
      'average_cycle_length': averageCycleLength,
      'previous_periods_begin': previousPeriodsBegin,
      'previous_periods_month': previousPeriodsMonth,
      'average_period_length': averagePeriodLength,
      'hum_apke_he_kon': humApkeHeKon,
      'email_verified_at': emailVerifiedAt,
      'password': password,
      'state': state,
      'city': city,
      'status': status,
      'remember_token': rememberToken,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class DashBoardViewModel with ChangeNotifier {
  List<CycleTableData> dataList = [];
  List<FlSpot> top3Spots = [];
  List<FlSpot> scaledSpots = [];
  late BuildContext context;
  final _services = Services();
  late User userInfo;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> userUpdateDashboardApi({
    required String imagePath,
    required String name,
    required String email,
    required String relationshipStatus,
    required String averageCycleLength,
    required String averagePeriodLength,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.name: name,
      ApiParams.email: email,
      ApiParams.relationship_status: relationshipStatus,
      ApiParams.average_cycle_length: averageCycleLength,
      ApiParams.average_period_length: averagePeriodLength,
    };
    CommonMaster? master = await _services.api!.userUpdateDashboard(
        params: params, picture: imagePath, fileKey: ApiParams.image);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................dashboard oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.greenColor,
      );
    }
    notifyListeners();
  }

  Future<void> getUserInfo() async {
    String accessToken = AppPreferences.instance.getAccessToken();
    String numberString = "${globalUserMaster?.id}";
    peroidCustomeList.clear();
    final url = Uri.parse(
        "https://neowindia.com/customeApi/getUserDetails.php?user_id=" +
            numberString);
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    final response =
        await http.get(url, headers: headers).timeout(Duration(seconds: 30));
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> responseData = jsonDecode(response.body);

      // Since the response is an array, get the first element from the list and convert it to User object
      userInfo = User.fromJson(responseData[0]);

      // Printing or using the parsed User object
      print(
          'User Info: ${userInfo.name}, ${userInfo.mobile}, ${userInfo.state}');
    } else {
      throw Exception('Failed to post data: ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<void> getAboutYourCycle() async {
    // CommonUtils.showProgressDialog();
    AboutYourCycleReponse? master = await _services.api!.getAboutYourCycle();
    print("about =>${master?.data![0].periodLengthInterpretation}");
    // CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();

    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
      print("daaa dipak =>${master.message}");
    } else if (master.success == true) {
      //     CommonUtils.hideProgressDialog();
      print("about =>${master.data}");
      dataList = master.data ?? [];
      if (dataList.isNotEmpty) {
        int max3Lenght = dataList.length>3?3:dataList.length;
        List<FlSpot> spotList=[];
        for(int i=0;i<max3Lenght;i++){
          //print("ddddddPeriodLenght===>${dataList[i].periodLength??"0"}");
          spotList.add(FlSpot(double.parse(DateTime.parse(dataList[i].period_start_date??"0").month.toString()),double.parse(dataList[i].periodCycleLength??"0")));
        }
        top3Spots = List.from(spotList)
          ..sort((a, b) => b.y.compareTo(a.y)) // Sort by Y value descending
          ..sublist(
              0,
              spotList.length); // Take the first 3 spots
        // Sort the top 3 by X-axis values to maintain chronological order
        top3Spots.sort((a, b) => a.x.compareTo(b.x));
        // Scale the X values of top3Spots to fill the X-axis range
       /* final double xScaleFactor = 15 / (top3Spots.last.x - top3Spots.first.x);
        scaledSpots = top3Spots
            .map((spot) => FlSpot(
          (spot.x - top3Spots.first.x) * xScaleFactor,
          spot.y,
        ))
            .toList();*/

        scaledSpots = top3Spots;

        print("scaledSpots ${scaledSpots}");
      }
      notifyListeners();
    }
    notifyListeners();
  }
}
