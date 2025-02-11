import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/constant.dart';

class CommonDailyInsightContainer extends StatelessWidget {
  final String text;
  final String image;
  final List<Color> gradientColors;
  final Color borderColor;
  final GestureTapCallback? onTap;
  final bool isHorizontalView;

  const CommonDailyInsightContainer({
    super.key,
    required this.text,
    required this.image,
    required this.gradientColors,
    required this.borderColor,
    this.isHorizontalView = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isHorizontalView? Container(
        padding: const EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
            color: Color(0xFFECE1E7),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.5, color: borderColor)),
        child: Stack(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60),
                          topRight: Radius.circular(10),
                        ),
                      ))),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 5,
                        right: 5,
                      ),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getAppStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            height: 1),
                      ),
                    ),
                    kCommonSpaceV10,
                    Image.asset(
                      image,
                      fit: BoxFit.contain,
                      width: 100,
                    )
                  ],
                ),
              )
              // kCommonSpaceV5,
            ],
          ),

      ): Container(
        padding: const EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
            color: Color(0xFFECE1E7),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.5, color: borderColor)),
        child: SizedBox(
          width: 120,
          // height:160,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 130,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60),
                          topRight: Radius.circular(10),
                        ),
                      ))),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 5,
                      right: 5,
                    ),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: getAppStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1),
                    ),
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                    width: 100,
                  ))

              /* Expanded(
              flex: 2,
              child: Container(
                // width: 100,
                // height:140
                decoration: BoxDecoration(

                    boxShadow: const [
                      /* BoxShadow(
                        color: Color(0xFFFFFFFF),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ) */
                    ],
                    /*  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 90.0)),
                    border: Border.all(width: 1.5, color: borderColor),  */
                    /* borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1.5, color: borderColor) */
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      image,
                      fit: BoxFit.contain,
                      width:100,
                    )
                  ],
                ),
              ),
            ), */
              // kCommonSpaceV5,
            ],
          ),
        ),
      ),
    );
  }
}
