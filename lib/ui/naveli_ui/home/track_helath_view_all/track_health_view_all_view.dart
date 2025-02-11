import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:provider/provider.dart';

import '../../../../models/common_master.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/global_variables.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_daily_insight_container.dart';
import '../../../../widgets/common_symptoms_widget.dart';
import '../../../../widgets/scaffold_bg.dart';
import '../../../../widgets/primary_button.dart';
import '../../profile/dashboard/quiz_view_report.dart';
import '../all_about_periods/all_about_periods_view.dart';
import '../de_stress/de_stress_view.dart';
import '../log_your_symptoms/log_your_symptoms_view.dart';
import '../log_your_symptoms/log_your_symptoms_view_model.dart';
import '../track/track_view.dart';

class TrackHealthViewAllView extends StatefulWidget {
  const TrackHealthViewAllView({super.key});

  @override
  State<TrackHealthViewAllView> createState() => _TrackHealthViewAllViewState();
}

class _TrackHealthViewAllViewState extends State<TrackHealthViewAllView>
    with SingleTickerProviderStateMixin {
  LogYourSymptomsModel? mViewSymptomsModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewSymptomsModel =
          Provider.of<LogYourSymptomsModel>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: "Track Your Health",
        ),
        body: Container(
          // Set the container height to full screen
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              // scrollDirection: Axis.horizontal,
              // shrinkWrap: true,
              children: <Widget>[
                if (gUserType == AppConstants.NEOWME)
                  CommonDailyInsightContainer(
                    onTap: () {
                      push(const LogYourSymptoms()).then((value) =>
                          mViewSymptomsModel?.getUserSymptomsLogApi(
                              date: globalUserMaster
                                  ?.previousPeriodsBegin ??
                                  ''));
                    },
                    isHorizontalView: true,
                    text: S.of(context)!.logYourSymptoms,
                    image: LocalImages.img_log_symptoms,
                    gradientColors: const [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                    borderColor: CommonColors.bglightPinkColor,
                  ),
                kCommonSpaceV15,
                CommonDailyInsightContainer(
                  onTap: () {
                    push(const TrackView());
                  },
                  isHorizontalView: true,
                  text: S.of(context)!.track,
                  image: LocalImages.img_track,
                  gradientColors: const [
                    Color(0xFF9E72C3),
                    Color(0xFF7338A0),
                  ],
                  borderColor: CommonColors.bglightPinkColor,
                ),
                kCommonSpaceV15,
                CommonDailyInsightContainer(
                  onTap: () {
                    // push(const KnowYourBodyView());
                    push(const AllAboutPeriodsView());
                  },
                  isHorizontalView: true,
                  text: 'Articles',
                  image: LocalImages.img_know_your_body,
                  gradientColors: const [
                    Color(0xFF9E72C3),
                    Color(0xFF7338A0),
                  ],
                  borderColor: CommonColors.bglightPinkColor,
                ),
                kCommonSpaceV15,
                if (gUserType == AppConstants.NEOWME ||
                    gUserType == AppConstants.CYCLE_EXPLORER)
                  CommonDailyInsightContainer(
                    onTap: () {
                      // showPopusDialog();
                      // showSymptomsDialog(context);
                      push(const QuizView());
                    },
                    isHorizontalView: true,
                    text: S.of(context)!.quickQuestion,
                    image: LocalImages.img_quick_question,
                    gradientColors: const [
                      Color(0xFF9E72C3),
                      Color(0xFF7338A0),
                    ],
                    borderColor: CommonColors.bglightPinkColor,
                  ),
                kCommonSpaceV15,
                CommonDailyInsightContainer(
                  onTap: () {
                    // showPopusDialog();
                    push(const DeStressView());
                  },
                  isHorizontalView: true,
                  text: S.of(context)!.deStress,
                  image: LocalImages.img_de_stress,
                  gradientColors: const [
                    Color(0xFF9E72C3),
                    Color(0xFF7338A0),
                  ],
                  borderColor: CommonColors.bglightPinkColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
