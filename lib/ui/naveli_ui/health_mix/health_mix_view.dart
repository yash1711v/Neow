import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:provider/provider.dart';

import '../../../generated/i18n.dart';
import '../../../utils/global_variables.dart';
import '../../../widgets/scaffold_bg.dart';
import 'health_mix_view_model.dart';
import 'post_list.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class HealthMixView extends StatefulWidget {
  const HealthMixView({super.key});

  @override
  State<HealthMixView> createState() => _HealthMixViewState();
}

class _HealthMixViewState extends State<HealthMixView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  late HealthMixViewModel mViewModel;
  SampleItem? selectedMenu;
  int selectedTabIndex = 0;
  final bool _isLiked = false;

  final List<String> text = [
    'Nutrition',
    S.of(mainNavKey.currentContext!)!.expertAdvice,
    S.of(mainNavKey.currentContext!)!.cycleWisdom,
    // S.of(mainNavKey.currentContext!)!.grooveWithNeow,
    S.of(mainNavKey.currentContext!)!.testimonials,
    /* S.of(mainNavKey.currentContext!)!.funCorner,
    S.of(mainNavKey.currentContext!)!.calebSpeaks,
    S.of(mainNavKey.currentContext!)!.empowHer, */
  ];
  final List<String> subHeadings = [
    'Popular',
    "Latest",
    "Saved"

  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      tabController = TabController(length: text.length, vsync: this);
      getPostList();
    });
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedTabIndex = index;
    });
    tabController?.animateTo(selectedTabIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    getPostList();
  }

  void getPostList() {
    if (selectedTabIndex == 0) {
      mViewModel.getHealthMixPostsApi(titleId: 7);
    } else if (selectedTabIndex == 1) {
      mViewModel.getHealthMixPostsApi(titleId: 1);
    } else if (selectedTabIndex == 2) {
      mViewModel.getHealthMixPostsApi(titleId: 2);
    } else if (selectedTabIndex == 3) {
      mViewModel.getHealthMixPostsApi(titleId: 4);
    } else if (selectedTabIndex == 4) {
      mViewModel.getHealthMixPostsApi(titleId: 3);
    } else if (selectedTabIndex == 5) {
      mViewModel.getHealthMixPostsApi(titleId: 5);
    } else if (selectedTabIndex == 6) {
      mViewModel.getHealthMixPostsApi(titleId: 6);
    } else if (selectedTabIndex == 7) {
      mViewModel.getHealthMixPostsApi(titleId: 8);
    }
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HealthMixViewModel>(context);
    return DefaultTabController(
      length: text.length,
      initialIndex: selectedTabIndex,
      child: ScaffoldBG(
        child: Scaffold(
            backgroundColor: CommonColors.mTransparent,
            appBar: AppBar(
              /* bottom: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              onTap: (index) {
                onButtonPressed(index);
              },
              tabs: text.map((title) {
                return Tab(
                  child: Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      color: CommonColors.blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ), */
              backgroundColor: CommonColors.mTransparent,
              elevation: 0,
              centerTitle: true,
              iconTheme: const IconThemeData(
                color: CommonColors.primaryColor,
              ),
              title: Text(
                S.of(context)!.healthMix,
                style: TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  height: 40,
                  child: Container(
                      child: ListView.builder(
                          itemCount: text.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var txtColor = selectedTabIndex == index
                                ? CommonColors.mWhite
                                : CommonColors.blackColor;
                            return (GestureDetector(
                                onTap: () {
                                  onButtonPressed(index);
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 10,
                                        bottom: 10),
                                    margin: const EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      color: selectedTabIndex == index
                                          ? CommonColors.primaryColor
                                          : CommonColors.mGrey.withOpacity(0.3),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: CommonColors.mWhite, width: 1),
                                    ),
                                    child: Text(text[index],
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: txtColor,
                                        )))));
                          }))),
              /* Text(
                  "Testing code",
                ), */
                  // TabBar(tabs: subHeadings.map((title) {
                  //   return Tab(
                  //     child: Text(
                  //       title.toUpperCase(),
                  //       style: TextStyle(
                  //         color: CommonColors.blackColor,
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   );
                  // }).toList()),
              kCommonSpaceV20,
                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // number of items in each row
                        mainAxisSpacing: 5.0, // spacing between rows
                        crossAxisSpacing: 5.0, // spacing between columns
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5.0), // padding around the grid
                      itemCount: mViewModel
                          .healthPostsList.length, // total number of items
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              push(PostList(
                                  position: index,
                                  selectedTabIndex: selectedTabIndex));
                            },
                            child: Container(
                              // color: Colors.blue, // color of grid items
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: CommonColors.mWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 110,
                                        // padding:const EdgeInsets.all(10,),
                                        decoration: BoxDecoration(
                                          // color:Color(0xFFF2C731),
                                          /* gradient: LinearGradient(
                                      begin: Alignment.topCenter,//(0.5, 0.5),
                                      end: Alignment.bottomCenter,//(-0.5, -0.5),
                                      colors: [Color(0xFFF2C731),Color(0xFFF2C731),Color(0xFFF2C731), CommonColors.blackColor.withOpacity(0.1)],
                                      // stops: [0, 0.2, 0.8, 1],
                                    ), */
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  if (mViewModel
                                                      .healthPostsList[index]
                                                      .mediaType ==
                                                      'image')
                                                    Container(
                                                      height: 110,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(mViewModel
                                                              .healthPostsList[
                                                          index]
                                                              .media ??
                                                              "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                  if (mViewModel
                                                      .healthPostsList[index]
                                                      .mediaType ==
                                                      'link')
                                                    SizedBox(
                                                        height: 110,
                                                        child: Align(
                                                            alignment:
                                                            Alignment.center,
                                                            child: Image.network(
                                                              "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                                              height: 110,
                                                            )) /* VideoPlayerScreen(
                                      link: mViewModel
                                              .healthPostsList[index].media ??
                                          "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                      // isFillAvailableSpace: false,
                                      // isLoop: true,
                                      // isMute: false,
                                    ), */
                                                    ),
                                                ])

                                          /* Image.asset(
                                                  LocalImages.img_nutrition_img,
                                                  // width:kDeviceWidth/1.4,
                                                  height:100,
                                                  fit: BoxFit.cover,
                                                ) */
                                        )),
                                    kCommonSpaceV5,
                                    SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                          mViewModel.healthPostsList[index]
                                              .description ??
                                              '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                          mViewModel.healthPostsList[index]
                                              .diffrenceTime ??
                                              '',
                                          style: TextStyle(
                                            color: CommonColors.blackColor
                                                .withOpacity(0.6),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ]),
                            ));
                      },
                    ),
                  )
              /* GridView.builder(
                  scrollDirection:Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 5.0, // spacing between rows
                    crossAxisSpacing: 5.0, // spacing between columns
                  ),
                  padding: EdgeInsets.all(10.0), // padding around the grid
                  itemCount: 10,//mViewModel.healthPostsList.length, // total number of items
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height:20,
                      color: Colors.blue, // color of grid items
                      child: Center(
                        child: Text(
                          
                                    'Testing',
                          overflow: TextOverflow.ellipsis,
                          maxLines:1,
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                      ),
                    );
                  },
                ) */
            ]) /* TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 25, left: 10, right: 10, top: 15),
                child: ListView.builder(
                  itemCount: mViewModel.healthPostsList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: 3, left: 3, top: 3, bottom: 8),
                      child: Container(
                        // width: kDeviceWidth / 1,
                        // height: kDeviceHeight / 2.2,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: CommonColors.mWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: CommonColors.mTransparent,
                                    backgroundImage: AssetImage(
                                      LocalImages.img_app_logo,
                                    ),
                                    radius: 25,
                                  ),
                                  kCommonSpaceH10,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Neow',
                                        style: getAppStyle(
                                          color: CommonColors.blackColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        mViewModel.healthPostsList[index]
                                                .diffrenceTime ??
                                            '',
                                        style: getAppStyle(
                                          color: CommonColors.mGrey,
                                          fontSize: 14,
                                          height: 0.5,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  // Expanded(
                                  //   child: Align(
                                  //     alignment: Alignment.topRight,
                                  //     child: PopupMenuButton<SampleItem>(
                                  //       initialValue: selectedMenu,
                                  //       onSelected: (SampleItem item) {
                                  //         setState(() {
                                  //           selectedMenu = item;
                                  //         });
                                  //       },
                                  //       itemBuilder: (BuildContext
                                  //               context) =>
                                  //           <PopupMenuEntry<SampleItem>>[
                                  //         const PopupMenuItem<SampleItem>(
                                  //           value: SampleItem.itemOne,
                                  //           child: Text('Block User'),
                                  //         ),
                                  //         const PopupMenuItem<SampleItem>(
                                  //           value: SampleItem.itemTwo,
                                  //           child: Text('Report Post'),
                                  //         ),
                                  //         const PopupMenuItem<SampleItem>(
                                  //           value: SampleItem.itemThree,
                                  //           child: Text('Report User'),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            if (mViewModel.healthPostsList[index].mediaType ==
                                'image')
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute<void>(
                                    fullscreenDialog: true,
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Image.network(
                                          height: kDeviceHeight / 1,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          mViewModel.healthPostsList[index]
                                                  .media ??
                                              "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    },
                                  ));
                                },
                                child: Container(
                                  height: kDeviceHeight / 3.5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(mViewModel
                                              .healthPostsList[index].media ??
                                          "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                            if (mViewModel.healthPostsList[index].mediaType ==
                                'link')
                              SizedBox(
                                height: kDeviceHeight / 4,
                                child: VideoPlayerScreen(
                                  link: mViewModel
                                          .healthPostsList[index].media ??
                                      "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                  // isFillAvailableSpace: false,
                                  // isLoop: true,
                                  // isMute: false,
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Wrap(
                                children: (mViewModel
                                            .healthPostsList[index].hashtags ??
                                        '')
                                    .split(',')
                                    .map((tag) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          tag,
                                          style: getAppStyle(
                                              color:
                                                  CommonColors.secondaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              height: 1.5),
                                        ),
                                        kCommonSpaceH5,
                                        Container(
                                          width: 1,
                                          height: 15,
                                          color: CommonColors.mGrey,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                mViewModel.healthPostsList[index].description ??
                                    '',
                                style: getAppStyle(
                                  color: CommonColors.mGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    mViewModel.likeHealthMixPostApi(
                                        healthMixId: mViewModel
                                            .healthPostsList[index].id,
                                        isLike: mViewModel.isLikedList[index]
                                            ? 0
                                            : 1);
                                    setState(() {
                                      mViewModel.isLikedList[index] =
                                          !mViewModel.isLikedList[index];
                                    });
                                  },
                                  icon: Icon(
                                      mViewModel.isLikedList[index]
                                          ? Icons.thumb_up
                                          : Icons.thumb_up_off_alt_outlined,
                                      color: CommonColors.primaryColor),
                                ),
                                // kCommonSpaceH3,
                                // IconButton(
                                //     onPressed: () {},
                                //     icon: Icon(Icons.thumb_down_alt_rounded,
                                //         color: CommonColors.primaryColor)),
                                kCommonSpaceH3,
                                IconButton(
                                    onPressed: () {
                                      if (mViewModel.healthPostsList[index]
                                              .mediaType ==
                                          "image") {
                                        // print("File type image");
                                        shareNetworkImage(
                                          mViewModel
                                              .healthPostsList[index].media,
                                          text: mViewModel
                                              .healthPostsList[index]
                                              .description,
                                        );
                                      } else if (mViewModel
                                              .healthPostsList[index]
                                              .mediaType ==
                                          "link") {
                                        // print("File type link");
                                        share(
                                            mViewModel
                                                .healthPostsList[index].media,
                                            text: mViewModel
                                                .healthPostsList[index]
                                                .description);
                                      }
                                    },
                                    icon: const Icon(Icons.share_rounded,
                                        color: CommonColors.primaryColor)),
                                // Expanded(
                                //   child: PrimaryButton(
                                //     height: 40,
                                //     onPress: () {},
                                //     borderRadius: BorderRadius.zero,
                                //     label: S.of(context)!.like,
                                //     lblSize: 13,
                                //   ),
                                // ),
                                // kCommonSpaceH3,
                                // Expanded(
                                //   child: PrimaryButton(
                                //     height: 40,
                                //     onPress: () {},
                                //     borderRadius: BorderRadius.zero,
                                //     label: S.of(context)!.dislike,
                                //     lblSize: 13,
                                //   ),
                                // ),
                                // kCommonSpaceH3,
                                // Expanded(
                                //   child: PrimaryButton(
                                //     height: 40,
                                //     onPress: () {},
                                //     borderRadius: BorderRadius.zero,
                                //     label: S.of(context)!.share,
                                //     lblSize: 13,
                                //   ),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 25, left: 10, right: 10, top: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Get professional health guidance from experts to support your well-being",
                        textAlign: TextAlign.center,
                        style: getAppStyle(
                          color: CommonColors.black87,
                          fontSize: 18,
                          height: 1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kCommonSpaceV15,
                      ListView.builder(
                        itemCount: mViewModel.healthPostsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 3, left: 3, top: 3, bottom: 8),
                            child: Container(
                              // width: kDeviceWidth / 1,
                              // height: kDeviceHeight / 2.2,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: CommonColors.mWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor:
                                              CommonColors.mTransparent,
                                          backgroundImage: AssetImage(
                                            LocalImages.img_app_logo,
                                          ),
                                          radius: 25,
                                        ),
                                        kCommonSpaceH10,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Neow',
                                              style: getAppStyle(
                                                color: CommonColors.blackColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              mViewModel.healthPostsList[index]
                                                      .diffrenceTime ??
                                                  '',
                                              style: getAppStyle(
                                                color: CommonColors.mGrey,
                                                fontSize: 14,
                                                height: 0.5,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                        // Expanded(
                                        //   child: Align(
                                        //     alignment: Alignment.topRight,
                                        //     child: PopupMenuButton<SampleItem>(
                                        //       initialValue: selectedMenu,
                                        //       onSelected: (SampleItem item) {
                                        //         setState(() {
                                        //           selectedMenu = item;
                                        //         });
                                        //       },
                                        //       itemBuilder: (BuildContext
                                        //               context) =>
                                        //           <PopupMenuEntry<SampleItem>>[
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemOne,
                                        //           child: Text('Block User'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemTwo,
                                        //           child: Text('Report Post'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemThree,
                                        //           child: Text('Report User'),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'image')
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute<void>(
                                          fullscreenDialog: true,
                                          builder: (BuildContext context) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Image.network(
                                                height: kDeviceHeight / 1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                mViewModel
                                                        .healthPostsList[index]
                                                        .media ??
                                                    "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        height: kDeviceHeight / 3.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(mViewModel
                                                    .healthPostsList[index]
                                                    .media ??
                                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'link')
                                    SizedBox(
                                      height: kDeviceHeight / 4,
                                      child: VideoPlayerScreen(
                                        link: mViewModel
                                                .healthPostsList[index].media ??
                                            "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                        // isFillAvailableSpace: false,
                                        // isLoop: true,
                                        // isMute: false,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Wrap(
                                      children: (mViewModel
                                                  .healthPostsList[index]
                                                  .hashtags ??
                                              '')
                                          .split(',')
                                          .map((tag) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                tag,
                                                style: getAppStyle(
                                                    color: CommonColors
                                                        .secondaryColor,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5),
                                              ),
                                              kCommonSpaceH5,
                                              Container(
                                                width: 1,
                                                height: 15,
                                                color: CommonColors.mGrey,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      mViewModel.healthPostsList[index]
                                              .description ??
                                          '',
                                      style: getAppStyle(
                                        color: CommonColors.mGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          mViewModel.likeHealthMixPostApi(
                                              healthMixId: mViewModel
                                                  .healthPostsList[index].id,
                                              isLike:
                                                  mViewModel.isLikedList[index]
                                                      ? 0
                                                      : 1);
                                          setState(() {
                                            mViewModel.isLikedList[index] =
                                                !mViewModel.isLikedList[index];
                                          });
                                        },
                                        icon: Icon(
                                            mViewModel.isLikedList[index]
                                                ? Icons.thumb_up
                                                : Icons
                                                    .thumb_up_off_alt_outlined,
                                            color: CommonColors.primaryColor),
                                      ),
                                      // kCommonSpaceH3,
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(Icons.thumb_down_alt_rounded,
                                      //         color: CommonColors.primaryColor)),
                                      kCommonSpaceH3,
                                      IconButton(
                                          onPressed: () {
                                            if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "image") {
                                              // print("File type image");
                                              shareNetworkImage(
                                                mViewModel
                                                    .healthPostsList[index]
                                                    .media,
                                                text: mViewModel
                                                    .healthPostsList[index]
                                                    .description,
                                              );
                                            } else if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "link") {
                                              // print("File type link");
                                              share(
                                                  mViewModel
                                                      .healthPostsList[index]
                                                      .media,
                                                  text: mViewModel
                                                      .healthPostsList[index]
                                                      .description);
                                            }
                                          },
                                          icon: const Icon(Icons.share_rounded,
                                              color:
                                                  CommonColors.primaryColor)),
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.like,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.dislike,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.share,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 25, left: 10, right: 10, top: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Explore a wealth of resources, articles, and tips curated to empower you with knowledge about your menstrual cycle, reproductive health, and overall well-being.",
                        textAlign: TextAlign.center,
                        style: getAppStyle(
                          color: CommonColors.black87,
                          fontSize: 18,
                          height: 1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kCommonSpaceV15,
                      ListView.builder(
                        itemCount: mViewModel.healthPostsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 3, left: 3, top: 3, bottom: 8),
                            child: Container(
                              // width: kDeviceWidth / 1,
                              // height: kDeviceHeight / 2.2,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: CommonColors.mWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor:
                                              CommonColors.mTransparent,
                                          backgroundImage: AssetImage(
                                            LocalImages.img_app_logo,
                                          ),
                                          radius: 25,
                                        ),
                                        kCommonSpaceH10,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Neow',
                                              style: getAppStyle(
                                                color: CommonColors.blackColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              mViewModel.healthPostsList[index]
                                                      .diffrenceTime ??
                                                  '',
                                              style: getAppStyle(
                                                color: CommonColors.mGrey,
                                                fontSize: 14,
                                                height: 0.5,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                        // Expanded(
                                        //   child: Align(
                                        //     alignment: Alignment.topRight,
                                        //     child: PopupMenuButton<SampleItem>(
                                        //       initialValue: selectedMenu,
                                        //       onSelected: (SampleItem item) {
                                        //         setState(() {
                                        //           selectedMenu = item;
                                        //         });
                                        //       },
                                        //       itemBuilder: (BuildContext
                                        //               context) =>
                                        //           <PopupMenuEntry<SampleItem>>[
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemOne,
                                        //           child: Text('Block User'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemTwo,
                                        //           child: Text('Report Post'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemThree,
                                        //           child: Text('Report User'),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'image')
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute<void>(
                                          fullscreenDialog: true,
                                          builder: (BuildContext context) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Image.network(
                                                height: kDeviceHeight / 1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                mViewModel
                                                        .healthPostsList[index]
                                                        .media ??
                                                    "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        height: kDeviceHeight / 3.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(mViewModel
                                                    .healthPostsList[index]
                                                    .media ??
                                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'link')
                                    SizedBox(
                                      height: kDeviceHeight / 4,
                                      child: VideoPlayerScreen(
                                        link: mViewModel
                                                .healthPostsList[index].media ??
                                            "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                        // isFillAvailableSpace: false,
                                        // isLoop: true,
                                        // isMute: false,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Wrap(
                                      children: (mViewModel
                                                  .healthPostsList[index]
                                                  .hashtags ??
                                              '')
                                          .split(',')
                                          .map((tag) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                tag,
                                                style: getAppStyle(
                                                    color: CommonColors
                                                        .secondaryColor,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5),
                                              ),
                                              kCommonSpaceH5,
                                              Container(
                                                width: 1,
                                                height: 15,
                                                color: CommonColors.mGrey,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      mViewModel.healthPostsList[index]
                                              .description ??
                                          '',
                                      style: getAppStyle(
                                        color: CommonColors.mGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          mViewModel.likeHealthMixPostApi(
                                              healthMixId: mViewModel
                                                  .healthPostsList[index].id,
                                              isLike:
                                                  mViewModel.isLikedList[index]
                                                      ? 0
                                                      : 1);
                                          setState(() {
                                            mViewModel.isLikedList[index] =
                                                !mViewModel.isLikedList[index];
                                          });
                                        },
                                        icon: Icon(
                                            mViewModel.isLikedList[index]
                                                ? Icons.thumb_up
                                                : Icons
                                                    .thumb_up_off_alt_outlined,
                                            color: CommonColors.primaryColor),
                                      ),
                                      // kCommonSpaceH3,
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(Icons.thumb_down_alt_rounded,
                                      //         color: CommonColors.primaryColor)),
                                      kCommonSpaceH3,
                                      IconButton(
                                          onPressed: () {
                                            if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "image") {
                                              // print("File type image");
                                              shareNetworkImage(
                                                mViewModel
                                                    .healthPostsList[index]
                                                    .media,
                                                text: mViewModel
                                                    .healthPostsList[index]
                                                    .description,
                                              );
                                            } else if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "link") {
                                              // print("File type link");
                                              share(
                                                  mViewModel
                                                      .healthPostsList[index]
                                                      .media,
                                                  text: mViewModel
                                                      .healthPostsList[index]
                                                      .description);
                                            }
                                          },
                                          icon: const Icon(Icons.share_rounded,
                                              color:
                                                  CommonColors.primaryColor)),
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.like,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.dislike,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.share,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 25, left: 10, right: 10, top: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Groove with NeoW: Dive into Dynamic Fitness with Yoga, Dance, Aerobics, and Zumba",
                        textAlign: TextAlign.center,
                        style: getAppStyle(
                          color: CommonColors.black87,
                          fontSize: 18,
                          height: 1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kCommonSpaceV15,
                      ListView.builder(
                        itemCount: mViewModel.healthPostsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 3, left: 3, top: 3, bottom: 8),
                            child: Container(
                              // width: kDeviceWidth / 1,
                              // height: kDeviceHeight / 2.2,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: CommonColors.mWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor:
                                              CommonColors.mTransparent,
                                          backgroundImage: AssetImage(
                                            LocalImages.img_app_logo,
                                          ),
                                          radius: 25,
                                        ),
                                        kCommonSpaceH10,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Neow',
                                              style: getAppStyle(
                                                color: CommonColors.blackColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              mViewModel.healthPostsList[index]
                                                      .diffrenceTime ??
                                                  '',
                                              style: getAppStyle(
                                                color: CommonColors.mGrey,
                                                fontSize: 14,
                                                height: 0.5,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                        // Expanded(
                                        //   child: Align(
                                        //     alignment: Alignment.topRight,
                                        //     child: PopupMenuButton<SampleItem>(
                                        //       initialValue: selectedMenu,
                                        //       onSelected: (SampleItem item) {
                                        //         setState(() {
                                        //           selectedMenu = item;
                                        //         });
                                        //       },
                                        //       itemBuilder: (BuildContext
                                        //               context) =>
                                        //           <PopupMenuEntry<SampleItem>>[
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemOne,
                                        //           child: Text('Block User'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemTwo,
                                        //           child: Text('Report Post'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemThree,
                                        //           child: Text('Report User'),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'image')
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute<void>(
                                          fullscreenDialog: true,
                                          builder: (BuildContext context) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Image.network(
                                                height: kDeviceHeight / 1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                mViewModel
                                                        .healthPostsList[index]
                                                        .media ??
                                                    "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        height: kDeviceHeight / 3.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(mViewModel
                                                    .healthPostsList[index]
                                                    .media ??
                                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'link')
                                    SizedBox(
                                      height: kDeviceHeight / 4,
                                      child: VideoPlayerScreen(
                                        link: mViewModel
                                                .healthPostsList[index].media ??
                                            "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                        // isFillAvailableSpace: false,
                                        // isLoop: true,
                                        // isMute: false,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Wrap(
                                      children: (mViewModel
                                                  .healthPostsList[index]
                                                  .hashtags ??
                                              '')
                                          .split(',')
                                          .map((tag) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                tag,
                                                style: getAppStyle(
                                                    color: CommonColors
                                                        .secondaryColor,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5),
                                              ),
                                              kCommonSpaceH5,
                                              Container(
                                                width: 1,
                                                height: 15,
                                                color: CommonColors.mGrey,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      mViewModel.healthPostsList[index]
                                              .description ??
                                          '',
                                      style: getAppStyle(
                                        color: CommonColors.mGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          mViewModel.likeHealthMixPostApi(
                                              healthMixId: mViewModel
                                                  .healthPostsList[index].id,
                                              isLike:
                                                  mViewModel.isLikedList[index]
                                                      ? 0
                                                      : 1);
                                          setState(() {
                                            mViewModel.isLikedList[index] =
                                                !mViewModel.isLikedList[index];
                                          });
                                        },
                                        icon: Icon(
                                            mViewModel.isLikedList[index]
                                                ? Icons.thumb_up
                                                : Icons
                                                    .thumb_up_off_alt_outlined,
                                            color: CommonColors.primaryColor),
                                      ),
                                      // kCommonSpaceH3,
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(Icons.thumb_down_alt_rounded,
                                      //         color: CommonColors.primaryColor)),
                                      kCommonSpaceH3,
                                      IconButton(
                                          onPressed: () {
                                            if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "image") {
                                              // print("File type image");
                                              shareNetworkImage(
                                                mViewModel
                                                    .healthPostsList[index]
                                                    .media,
                                                text: mViewModel
                                                    .healthPostsList[index]
                                                    .description,
                                              );
                                            } else if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "link") {
                                              // print("File type link");
                                              share(
                                                  mViewModel
                                                      .healthPostsList[index]
                                                      .media,
                                                  text: mViewModel
                                                      .healthPostsList[index]
                                                      .description);
                                            }
                                          },
                                          icon: const Icon(Icons.share_rounded,
                                              color:
                                                  CommonColors.primaryColor)),
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.like,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.dislike,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.share,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 25, left: 10, right: 10, top: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Explore real stories by real people of empowerment and transformation",
                        textAlign: TextAlign.center,
                        style: getAppStyle(
                          color: CommonColors.black87,
                          fontSize: 18,
                          height: 1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kCommonSpaceV15,
                      ListView.builder(
                        itemCount: mViewModel.healthPostsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 3, left: 3, top: 3, bottom: 8),
                            child: Container(
                              // width: kDeviceWidth / 1,
                              // height: kDeviceHeight / 2.2,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: CommonColors.mWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor:
                                              CommonColors.mTransparent,
                                          backgroundImage: AssetImage(
                                            LocalImages.img_app_logo,
                                          ),
                                          radius: 25,
                                        ),
                                        kCommonSpaceH10,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Neow',
                                              style: getAppStyle(
                                                color: CommonColors.blackColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              mViewModel.healthPostsList[index]
                                                      .diffrenceTime ??
                                                  '',
                                              style: getAppStyle(
                                                color: CommonColors.mGrey,
                                                fontSize: 14,
                                                height: 0.5,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                        // Expanded(
                                        //   child: Align(
                                        //     alignment: Alignment.topRight,
                                        //     child: PopupMenuButton<SampleItem>(
                                        //       initialValue: selectedMenu,
                                        //       onSelected: (SampleItem item) {
                                        //         setState(() {
                                        //           selectedMenu = item;
                                        //         });
                                        //       },
                                        //       itemBuilder: (BuildContext
                                        //               context) =>
                                        //           <PopupMenuEntry<SampleItem>>[
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemOne,
                                        //           child: Text('Block User'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemTwo,
                                        //           child: Text('Report Post'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemThree,
                                        //           child: Text('Report User'),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'image')
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute<void>(
                                          fullscreenDialog: true,
                                          builder: (BuildContext context) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Image.network(
                                                height: kDeviceHeight / 1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                mViewModel
                                                        .healthPostsList[index]
                                                        .media ??
                                                    "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        height: kDeviceHeight / 3.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(mViewModel
                                                    .healthPostsList[index]
                                                    .media ??
                                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'link')
                                    SizedBox(
                                      height: kDeviceHeight / 4,
                                      child: VideoPlayerScreen(
                                        link: mViewModel
                                                .healthPostsList[index].media ??
                                            "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                        // isFillAvailableSpace: false,
                                        // isLoop: true,
                                        // isMute: false,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Wrap(
                                      children: (mViewModel
                                                  .healthPostsList[index]
                                                  .hashtags ??
                                              '')
                                          .split(',')
                                          .map((tag) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                tag,
                                                style: getAppStyle(
                                                    color: CommonColors
                                                        .secondaryColor,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5),
                                              ),
                                              kCommonSpaceH5,
                                              Container(
                                                width: 1,
                                                height: 15,
                                                color: CommonColors.mGrey,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      mViewModel.healthPostsList[index]
                                              .description ??
                                          '',
                                      style: getAppStyle(
                                        color: CommonColors.mGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          mViewModel.likeHealthMixPostApi(
                                              healthMixId: mViewModel
                                                  .healthPostsList[index].id,
                                              isLike:
                                                  mViewModel.isLikedList[index]
                                                      ? 0
                                                      : 1);
                                          setState(() {
                                            mViewModel.isLikedList[index] =
                                                !mViewModel.isLikedList[index];
                                          });
                                        },
                                        icon: Icon(
                                            mViewModel.isLikedList[index]
                                                ? Icons.thumb_up
                                                : Icons
                                                    .thumb_up_off_alt_outlined,
                                            color: CommonColors.primaryColor),
                                      ),
                                      // kCommonSpaceH3,
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(Icons.thumb_down_alt_rounded,
                                      //         color: CommonColors.primaryColor)),
                                      kCommonSpaceH3,
                                      IconButton(
                                          onPressed: () {
                                            if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "image") {
                                              // print("File type image");
                                              shareNetworkImage(
                                                mViewModel
                                                    .healthPostsList[index]
                                                    .media,
                                                text: mViewModel
                                                    .healthPostsList[index]
                                                    .description,
                                              );
                                            } else if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "link") {
                                              // print("File type link");
                                              share(
                                                  mViewModel
                                                      .healthPostsList[index]
                                                      .media,
                                                  text: mViewModel
                                                      .healthPostsList[index]
                                                      .description);
                                            }
                                          },
                                          icon: const Icon(Icons.share_rounded,
                                              color:
                                                  CommonColors.primaryColor)),
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.like,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.dislike,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.share,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 25, left: 10, right: 10, top: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Where Every Moment Sparkles with Joy!",
                        textAlign: TextAlign.center,
                        style: getAppStyle(
                          color: CommonColors.black87,
                          fontSize: 18,
                          height: 1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kCommonSpaceV15,
                      ListView.builder(
                        itemCount: mViewModel.healthPostsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 3, left: 3, top: 3, bottom: 8),
                            child: Container(
                              // width: kDeviceWidth / 1,
                              // height: kDeviceHeight / 2.2,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: CommonColors.mWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor:
                                              CommonColors.mTransparent,
                                          backgroundImage: AssetImage(
                                            LocalImages.img_app_logo,
                                          ),
                                          radius: 25,
                                        ),
                                        kCommonSpaceH10,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Neow',
                                              style: getAppStyle(
                                                color: CommonColors.blackColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              mViewModel.healthPostsList[index]
                                                      .diffrenceTime ??
                                                  '',
                                              style: getAppStyle(
                                                color: CommonColors.mGrey,
                                                fontSize: 14,
                                                height: 0.5,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                        // Expanded(
                                        //   child: Align(
                                        //     alignment: Alignment.topRight,
                                        //     child: PopupMenuButton<SampleItem>(
                                        //       initialValue: selectedMenu,
                                        //       onSelected: (SampleItem item) {
                                        //         setState(() {
                                        //           selectedMenu = item;
                                        //         });
                                        //       },
                                        //       itemBuilder: (BuildContext
                                        //               context) =>
                                        //           <PopupMenuEntry<SampleItem>>[
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemOne,
                                        //           child: Text('Block User'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemTwo,
                                        //           child: Text('Report Post'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemThree,
                                        //           child: Text('Report User'),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'image')
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute<void>(
                                          fullscreenDialog: true,
                                          builder: (BuildContext context) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Image.network(
                                                height: kDeviceHeight / 1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                mViewModel
                                                        .healthPostsList[index]
                                                        .media ??
                                                    "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        height: kDeviceHeight / 3.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(mViewModel
                                                    .healthPostsList[index]
                                                    .media ??
                                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'link')
                                    SizedBox(
                                      height: kDeviceHeight / 4,
                                      child: VideoPlayerScreen(
                                        link: mViewModel
                                                .healthPostsList[index].media ??
                                            "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                        // isFillAvailableSpace: false,
                                        // isLoop: true,
                                        // isMute: false,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Wrap(
                                      children: (mViewModel
                                                  .healthPostsList[index]
                                                  .hashtags ??
                                              '')
                                          .split(',')
                                          .map((tag) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                tag,
                                                style: getAppStyle(
                                                    color: CommonColors
                                                        .secondaryColor,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5),
                                              ),
                                              kCommonSpaceH5,
                                              Container(
                                                width: 1,
                                                height: 15,
                                                color: CommonColors.mGrey,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      mViewModel.healthPostsList[index]
                                              .description ??
                                          '',
                                      style: getAppStyle(
                                        color: CommonColors.mGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          mViewModel.likeHealthMixPostApi(
                                              healthMixId: mViewModel
                                                  .healthPostsList[index].id,
                                              isLike:
                                                  mViewModel.isLikedList[index]
                                                      ? 0
                                                      : 1);
                                          setState(() {
                                            mViewModel.isLikedList[index] =
                                                !mViewModel.isLikedList[index];
                                          });
                                        },
                                        icon: Icon(
                                            mViewModel.isLikedList[index]
                                                ? Icons.thumb_up
                                                : Icons
                                                    .thumb_up_off_alt_outlined,
                                            color: CommonColors.primaryColor),
                                      ),
                                      // kCommonSpaceH3,
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(Icons.thumb_down_alt_rounded,
                                      //         color: CommonColors.primaryColor)),
                                      kCommonSpaceH3,
                                      IconButton(
                                          onPressed: () {
                                            if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "image") {
                                              // print("File type image");
                                              shareNetworkImage(
                                                mViewModel
                                                    .healthPostsList[index]
                                                    .media,
                                                text: mViewModel
                                                    .healthPostsList[index]
                                                    .description,
                                              );
                                            } else if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "link") {
                                              // print("File type link");
                                              share(
                                                  mViewModel
                                                      .healthPostsList[index]
                                                      .media,
                                                  text: mViewModel
                                                      .healthPostsList[index]
                                                      .description);
                                            }
                                          },
                                          icon: const Icon(Icons.share_rounded,
                                              color:
                                                  CommonColors.primaryColor)),
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.like,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.dislike,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.share,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 25, left: 10, right: 10, top: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Look what your fav celebs have to say about us!",
                        textAlign: TextAlign.center,
                        style: getAppStyle(
                          color: CommonColors.black87,
                          fontSize: 18,
                          height: 1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kCommonSpaceV15,
                      ListView.builder(
                        itemCount: mViewModel.healthPostsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 3, left: 3, top: 3, bottom: 8),
                            child: Container(
                              // width: kDeviceWidth / 1,
                              // height: kDeviceHeight / 2.2,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: CommonColors.mWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor:
                                              CommonColors.mTransparent,
                                          backgroundImage: AssetImage(
                                            LocalImages.img_app_logo,
                                          ),
                                          radius: 25,
                                        ),
                                        kCommonSpaceH10,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Neow',
                                              style: getAppStyle(
                                                color: CommonColors.blackColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              mViewModel.healthPostsList[index]
                                                      .diffrenceTime ??
                                                  '',
                                              style: getAppStyle(
                                                color: CommonColors.mGrey,
                                                fontSize: 14,
                                                height: 0.5,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                        // Expanded(
                                        //   child: Align(
                                        //     alignment: Alignment.topRight,
                                        //     child: PopupMenuButton<SampleItem>(
                                        //       initialValue: selectedMenu,
                                        //       onSelected: (SampleItem item) {
                                        //         setState(() {
                                        //           selectedMenu = item;
                                        //         });
                                        //       },
                                        //       itemBuilder: (BuildContext
                                        //               context) =>
                                        //           <PopupMenuEntry<SampleItem>>[
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemOne,
                                        //           child: Text('Block User'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemTwo,
                                        //           child: Text('Report Post'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemThree,
                                        //           child: Text('Report User'),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'image')
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute<void>(
                                          fullscreenDialog: true,
                                          builder: (BuildContext context) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Image.network(
                                                height: kDeviceHeight / 1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                mViewModel
                                                        .healthPostsList[index]
                                                        .media ??
                                                    "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        height: kDeviceHeight / 3.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(mViewModel
                                                    .healthPostsList[index]
                                                    .media ??
                                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'link')
                                    SizedBox(
                                      height: kDeviceHeight / 4,
                                      child: VideoPlayerScreen(
                                        link: mViewModel
                                                .healthPostsList[index].media ??
                                            "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                        // isFillAvailableSpace: false,
                                        // isLoop: true,
                                        // isMute: false,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Wrap(
                                      children: (mViewModel
                                                  .healthPostsList[index]
                                                  .hashtags ??
                                              '')
                                          .split(',')
                                          .map((tag) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                tag,
                                                style: getAppStyle(
                                                    color: CommonColors
                                                        .secondaryColor,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5),
                                              ),
                                              kCommonSpaceH5,
                                              Container(
                                                width: 1,
                                                height: 15,
                                                color: CommonColors.mGrey,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      mViewModel.healthPostsList[index]
                                              .description ??
                                          '',
                                      style: getAppStyle(
                                        color: CommonColors.mGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          mViewModel.likeHealthMixPostApi(
                                              healthMixId: mViewModel
                                                  .healthPostsList[index].id,
                                              isLike:
                                                  mViewModel.isLikedList[index]
                                                      ? 0
                                                      : 1);
                                          setState(() {
                                            mViewModel.isLikedList[index] =
                                                !mViewModel.isLikedList[index];
                                          });
                                        },
                                        icon: Icon(
                                            mViewModel.isLikedList[index]
                                                ? Icons.thumb_up
                                                : Icons
                                                    .thumb_up_off_alt_outlined,
                                            color: CommonColors.primaryColor),
                                      ),
                                      // kCommonSpaceH3,
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(Icons.thumb_down_alt_rounded,
                                      //         color: CommonColors.primaryColor)),
                                      kCommonSpaceH3,
                                      IconButton(
                                          onPressed: () {
                                            if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "image") {
                                              // print("File type image");
                                              shareNetworkImage(
                                                mViewModel
                                                    .healthPostsList[index]
                                                    .media,
                                                text: mViewModel
                                                    .healthPostsList[index]
                                                    .description,
                                              );
                                            } else if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "link") {
                                              // print("File type link");
                                              share(
                                                  mViewModel
                                                      .healthPostsList[index]
                                                      .media,
                                                  text: mViewModel
                                                      .healthPostsList[index]
                                                      .description);
                                            }
                                          },
                                          icon: const Icon(Icons.share_rounded,
                                              color:
                                                  CommonColors.primaryColor)),
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.like,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.dislike,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.share,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 25, left: 10, right: 10, top: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "A dedicated section offering insights on diverse topics impacting your life directly, empowering you to succeed confidently.",
                        textAlign: TextAlign.center,
                        style: getAppStyle(
                          color: CommonColors.black87,
                          fontSize: 18,
                          height: 1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kCommonSpaceV15,
                      ListView.builder(
                        itemCount: mViewModel.healthPostsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 3, left: 3, top: 3, bottom: 8),
                            child: Container(
                              // width: kDeviceWidth / 1,
                              // height: kDeviceHeight / 2.2,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: CommonColors.mWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor:
                                              CommonColors.mTransparent,
                                          backgroundImage: AssetImage(
                                            LocalImages.img_app_logo,
                                          ),
                                          radius: 25,
                                        ),
                                        kCommonSpaceH10,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Neow',
                                              style: getAppStyle(
                                                color: CommonColors.blackColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              mViewModel.healthPostsList[index]
                                                      .diffrenceTime ??
                                                  '',
                                              style: getAppStyle(
                                                color: CommonColors.mGrey,
                                                fontSize: 14,
                                                height: 0.5,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                        // Expanded(
                                        //   child: Align(
                                        //     alignment: Alignment.topRight,
                                        //     child: PopupMenuButton<SampleItem>(
                                        //       initialValue: selectedMenu,
                                        //       onSelected: (SampleItem item) {
                                        //         setState(() {
                                        //           selectedMenu = item;
                                        //         });
                                        //       },
                                        //       itemBuilder: (BuildContext
                                        //               context) =>
                                        //           <PopupMenuEntry<SampleItem>>[
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemOne,
                                        //           child: Text('Block User'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemTwo,
                                        //           child: Text('Report Post'),
                                        //         ),
                                        //         const PopupMenuItem<SampleItem>(
                                        //           value: SampleItem.itemThree,
                                        //           child: Text('Report User'),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'image')
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute<void>(
                                          fullscreenDialog: true,
                                          builder: (BuildContext context) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Image.network(
                                                height: kDeviceHeight / 1,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                mViewModel
                                                        .healthPostsList[index]
                                                        .media ??
                                                    "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                                fit: BoxFit.contain,
                                              ),
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        height: kDeviceHeight / 3.5,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(mViewModel
                                                    .healthPostsList[index]
                                                    .media ??
                                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (mViewModel
                                          .healthPostsList[index].mediaType ==
                                      'link')
                                    SizedBox(
                                      height: kDeviceHeight / 4,
                                      child: VideoPlayerScreen(
                                        link: mViewModel
                                                .healthPostsList[index].media ??
                                            "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                        // isFillAvailableSpace: false,
                                        // isLoop: true,
                                        // isMute: false,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Wrap(
                                      children: (mViewModel
                                                  .healthPostsList[index]
                                                  .hashtags ??
                                              '')
                                          .split(',')
                                          .map((tag) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                tag,
                                                style: getAppStyle(
                                                    color: CommonColors
                                                        .secondaryColor,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5),
                                              ),
                                              kCommonSpaceH5,
                                              Container(
                                                width: 1,
                                                height: 15,
                                                color: CommonColors.mGrey,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      mViewModel.healthPostsList[index]
                                              .description ??
                                          '',
                                      style: getAppStyle(
                                        color: CommonColors.mGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          mViewModel.likeHealthMixPostApi(
                                              healthMixId: mViewModel
                                                  .healthPostsList[index].id,
                                              isLike:
                                                  mViewModel.isLikedList[index]
                                                      ? 0
                                                      : 1);
                                          setState(() {
                                            mViewModel.isLikedList[index] =
                                                !mViewModel.isLikedList[index];
                                          });
                                        },
                                        icon: Icon(
                                            mViewModel.isLikedList[index]
                                                ? Icons.thumb_up
                                                : Icons
                                                    .thumb_up_off_alt_outlined,
                                            color: CommonColors.primaryColor),
                                      ),
                                      // kCommonSpaceH3,
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(Icons.thumb_down_alt_rounded,
                                      //         color: CommonColors.primaryColor)),
                                      kCommonSpaceH3,
                                      IconButton(
                                          onPressed: () {
                                            if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "image") {
                                              // print("File type image");
                                              shareNetworkImage(
                                                mViewModel
                                                    .healthPostsList[index]
                                                    .media,
                                                text: mViewModel
                                                    .healthPostsList[index]
                                                    .description,
                                              );
                                            } else if (mViewModel
                                                    .healthPostsList[index]
                                                    .mediaType ==
                                                "link") {
                                              // print("File type link");
                                              share(
                                                  mViewModel
                                                      .healthPostsList[index]
                                                      .media,
                                                  text: mViewModel
                                                      .healthPostsList[index]
                                                      .description);
                                            }
                                          },
                                          icon: const Icon(Icons.share_rounded,
                                              color:
                                                  CommonColors.primaryColor)),
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.like,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.dislike,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                      // kCommonSpaceH3,
                                      // Expanded(
                                      //   child: PrimaryButton(
                                      //     height: 40,
                                      //     onPress: () {},
                                      //     borderRadius: BorderRadius.zero,
                                      //     label: S.of(context)!.share,
                                      //     lblSize: 13,
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // SingleChildScrollView(
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 25,left: 15,right: 15,top: 15),
              //     child: Column(
              //       children: [
              //         ListView.builder(
              //           physics: NeverScrollableScrollPhysics(),
              //           itemCount: 3,
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) {
              //             return Padding(
              //               padding: const EdgeInsets.symmetric(vertical: 5),
              //               child: Container(
              //                 width: 390,
              //                 height: 362,
              //                 clipBehavior: Clip.antiAlias,
              //                 decoration: ShapeDecoration(
              //                   color: CommonColors.mWhite,
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   shadows: [
              //                     BoxShadow(
              //                       color: Color(0x3F000000),
              //                       blurRadius: 8,
              //                       offset: Offset(0, 2),
              //                       spreadRadius: 0,
              //                     )
              //                   ],
              //                 ),
              //                 child: Column(
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Row(
              //                         children: [
              //                           CircleAvatar(
              //                             backgroundImage: NetworkImage(
              //                                 "https://m.media-amazon.com/images/I/61SXghk-oNL._AC_SY500_.jpg"),
              //                             radius: 30,
              //                           ),
              //                           kCommonSpaceH10,
              //                           Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                             children: [
              //                               Text(
              //                                 'Allison Parker',
              //                                 style: getAppStyle(
              //                                   color: CommonColors.blackColor,
              //                                   fontSize: 16,
              //                                   fontWeight: FontWeight.w400,
              //                                 ),
              //                               ),
              //                               Text(
              //                                 '21 min.',
              //                                 style: getAppStyle(
              //                                   color: CommonColors.mGrey,
              //                                   fontSize: 14,
              //                                   height: 0.5,
              //                                   fontWeight: FontWeight.w400,
              //                                 ),
              //                               )
              //                             ],
              //                           ),
              //                           Expanded(
              //                             child: Align(
              //                               alignment: Alignment.topRight,
              //                               child: PopupMenuButton<SampleItem>(
              //                                 initialValue: selectedMenu,
              //                                 onSelected: (SampleItem item) {
              //                                   setState(() {
              //                                     selectedMenu = item;
              //                                   });
              //                                 },
              //                                 itemBuilder: (BuildContext
              //                                         context) =>
              //                                     <PopupMenuEntry<SampleItem>>[
              //                                   const PopupMenuItem<SampleItem>(
              //                                     value: SampleItem.itemOne,
              //                                     child: Text('Block User'),
              //                                   ),
              //                                   const PopupMenuItem<SampleItem>(
              //                                     value: SampleItem.itemTwo,
              //                                     child: Text('Report Post'),
              //                                   ),
              //                                   const PopupMenuItem<SampleItem>(
              //                                     value: SampleItem.itemThree,
              //                                     child: Text('Report User'),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     Container(
              //                       width: 390,
              //                       height: 186,
              //                       decoration: BoxDecoration(
              //                         image: DecorationImage(
              //                           image: NetworkImage(
              //                               "https://www.elfinanciero.com.mx/resizer/3Ayz6AJlmbINF9G17OKiP-E36GQ=/800x0/filters:format(jpg):quality(70)/cloudfront-us-east-1.images.arcpublishing.com/elfinanciero/LOXB2ODON5CBDK53KZONTJJ3Q4.jpeg"),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.end,
              //                           children: [
              //                             SvgPicture.asset(LocalImages.icon_like),
              //                             kCommonSpaceV5,
              //                             SvgPicture.asset(
              //                                 LocalImages.icon_dislike),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(5.0),
              //                         child: Wrap(
              //                           children: hasTagText.map((tag) {
              //                             return Padding(
              //                               padding: const EdgeInsets.symmetric(
              //                                   horizontal: 4.0),
              //                               child: Row(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 children: [
              //                                   Text(
              //                                     '#$tag',
              //                                     style: getAppStyle(
              //                                       color: CommonColors
              //                                           .secondaryColor,
              //                                       fontSize: 13,
              //                                       fontWeight: FontWeight.w600,
              //                                     ),
              //                                   ),
              //                                   kCommonSpaceH5,
              //                                   Container(
              //                                     width: 1,
              //                                     height: 15,
              //                                     color: CommonColors.mGrey,
              //                                   ),
              //                                 ],
              //                               ),
              //                             );
              //                           }).toList(),
              //                         ),
              //                       ),
              //                     ),
              //                     Row(
              //                       children: [
              //                         Expanded(
              //                           child: PrimaryButton(
              //                             height: 40,
              //                             onPress: (){},
              //                             borderRadius: BorderRadius.zero,
              //                             label: S.of(context)!.follow,
              //                             lblSize: 13,
              //                           ),
              //                         ),
              //                         kCommonSpaceH3,
              //                         Expanded(
              //                           child: ElevatedButton(
              //                             onPressed: () {},
              //                             style: ElevatedButton.styleFrom(
              //                                 shape: RoundedRectangleBorder(
              //                                   borderRadius: BorderRadius.all(
              //                                     Radius.circular(0.0),
              //                                   ),
              //                                 ),
              //                                 backgroundColor:
              //                                 CommonColors.primaryColor,
              //                                 tapTargetSize: MaterialTapTargetSize
              //                                     .shrinkWrap),
              //                             child: Text.rich(
              //                               TextSpan(
              //                                 children: [
              //                                   TextSpan(
              //                                     text: S.of(context)!.comment,
              //                                     style: getAppStyle(
              //                                       color: Colors.white,
              //                                       fontSize: 13,
              //                                       fontWeight: FontWeight.w600,
              //                                     ),
              //                                   ),
              //                                   TextSpan(
              //                                     text: '(50)',
              //                                     style: getAppStyle(
              //                                       color: CommonColors
              //                                           .secondaryColor,
              //                                       fontSize: 13,
              //                                       fontWeight: FontWeight.w600,
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                               textAlign: TextAlign.center,
              //                             ),
              //                           ),
              //                         ),
              //                         kCommonSpaceH3,
              //                         Expanded(
              //                           child: PrimaryButton(
              //                             height: 40,
              //                             onPress: (){},
              //                             borderRadius: BorderRadius.zero,
              //                             label: S.of(context)!.share,
              //                             lblSize: 13,
              //                           ),
              //                         ),
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SingleChildScrollView(
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 25,left: 15,right: 15,top: 15),
              //     child: Column(
              //       children: [
              //         kCommonSpaceV10,
              //         Container(
              //           width: 390,
              //           height: 150,
              //           decoration: ShapeDecoration(
              //             color: CommonColors.mWhite,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             shadows: [
              //               BoxShadow(
              //                 color: Color(0x3F000000),
              //                 blurRadius: 8,
              //                 offset: Offset(0, 2),
              //                 spreadRadius: 0,
              //               )
              //             ],
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Column(
              //               children: [
              //                 Text(
              //                   'Welcome to the "Period Talk" channel :)',
              //                   style: getAppStyle(
              //                     color: CommonColors.secondaryColor,
              //                     fontSize: 25,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //                 kCommonSpaceV10,
              //                 Flexible(
              //                   child: Text(
              //                     'From mood swings & cramps to delayed periods & menopause - have all your period related discussions right here.',
              //                     style: getAppStyle(
              //                       color: CommonColors.mGrey,
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.w400,
              //                       height: 1,
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //         kCommonSpaceV10,
              //         ListView.builder(
              //           physics: NeverScrollableScrollPhysics(),
              //           itemCount: 3,
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) {
              //             return Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Container(
              //                 width: 390,
              //                 height: 248,
              //                 clipBehavior: Clip.antiAlias,
              //                 decoration: ShapeDecoration(
              //                   color: CommonColors.mWhite,
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   shadows: [
              //                     BoxShadow(
              //                       color: Color(0x3F000000),
              //                       blurRadius: 8,
              //                       offset: Offset(0, 2),
              //                       spreadRadius: 0,
              //                     )
              //                   ],
              //                 ),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Row(
              //                         children: [
              //                           CircleAvatar(
              //                             backgroundImage: NetworkImage(
              //                                 "https://m.media-amazon.com/images/I/61SXghk-oNL._AC_SY500_.jpg"),
              //                             radius: 30,
              //                           ),
              //                           kCommonSpaceH10,
              //                           Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                             children: [
              //                               Text(
              //                                 'Allison Parker',
              //                                 style: getAppStyle(
              //                                   color: CommonColors.blackColor,
              //                                   fontSize: 16,
              //                                   fontWeight: FontWeight.w400,
              //                                 ),
              //                               ),
              //                               Text(
              //                                 '21 min.',
              //                                 style: getAppStyle(
              //                                   color: Color(0xFF8B8B8B),
              //                                   fontSize: 14,
              //                                   height: 0.5,
              //                                   fontWeight: FontWeight.w400,
              //                                 ),
              //                               )
              //                             ],
              //                           ),
              //                           kCommonSpaceH10,
              //                           Container(
              //                             width: 100,
              //                             height: 25,
              //                             decoration: ShapeDecoration(
              //                               color: CommonColors.primaryColor,
              //                               shape: RoundedRectangleBorder(
              //                                 borderRadius:
              //                                     BorderRadius.circular(20),
              //                               ),
              //                             ),
              //                             child: Center(
              //                               child: Text(
              //                                 'Follow +',
              //                                 style: getAppStyle(
              //                                   color: CommonColors.mWhite,
              //                                   fontSize: 16,
              //                                   fontWeight: FontWeight.w400,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                           Expanded(
              //                             child: Align(
              //                               alignment: Alignment.topRight,
              //                               child: PopupMenuButton<SampleItem>(
              //                                 initialValue: selectedMenu,
              //                                 onSelected: (SampleItem item) {
              //                                   setState(() {
              //                                     selectedMenu = item;
              //                                   });
              //                                 },
              //                                 itemBuilder: (BuildContext
              //                                         context) =>
              //                                     <PopupMenuEntry<SampleItem>>[
              //                                   const PopupMenuItem<SampleItem>(
              //                                     value: SampleItem.itemOne,
              //                                     child: Text('Block User'),
              //                                   ),
              //                                   const PopupMenuItem<SampleItem>(
              //                                     value: SampleItem.itemTwo,
              //                                     child: Text('Report Post'),
              //                                   ),
              //                                   const PopupMenuItem<SampleItem>(
              //                                     value: SampleItem.itemThree,
              //                                     child: Text('Report User'),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.only(left: 8),
              //                       child: Text(
              //                         'Doubt',
              //                         textAlign: TextAlign.center,
              //                         style: getAppStyle(
              //                           color: CommonColors.blackColor,
              //                           fontSize: 15,
              //                           fontWeight: FontWeight.w600,
              //                         ),
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding:
              //                           const EdgeInsets.only(left: 10, top: 5),
              //                       child: Text(
              //                         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
              //                         style: getAppStyle(
              //                           color: CommonColors.mGrey,
              //                           fontSize: 13,
              //                           fontWeight: FontWeight.w600,
              //                           height: 1,
              //                         ),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(5.0),
              //                         child: Wrap(
              //                           children: hasTagText.map((tag) {
              //                             return Padding(
              //                               padding: const EdgeInsets.symmetric(
              //                                   horizontal: 4.0),
              //                               child: Row(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 children: [
              //                                   Text(
              //                                     '#$tag',
              //                                     style: getAppStyle(
              //                                       color: CommonColors
              //                                           .secondaryColor,
              //                                       fontSize: 13,
              //                                       fontWeight: FontWeight.w600,
              //                                     ),
              //                                   ),
              //                                   kCommonSpaceH5,
              //                                   Container(
              //                                     width: 1,
              //                                     height: 15,
              //                                     color: CommonColors.mGrey,
              //                                   ),
              //                                 ],
              //                               ),
              //                             );
              //                           }).toList(),
              //                         ),
              //                       ),
              //                     ),
              //                     Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Expanded(
              //                           child: ElevatedButton(
              //                             onPressed: () {},
              //                             style: ElevatedButton.styleFrom(
              //                                 shape: RoundedRectangleBorder(
              //                                   borderRadius: BorderRadius.all(
              //                                     Radius.circular(0.0),
              //                                   ),
              //                                 ),
              //                                 backgroundColor:
              //                                     CommonColors.primaryColor,
              //                                 tapTargetSize: MaterialTapTargetSize
              //                                     .shrinkWrap),
              //                             child: Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.center,
              //                               children: [
              //                                 SvgPicture.asset(
              //                                     LocalImages.icon_like),
              //                                 kCommonSpaceH10,
              //                                 SvgPicture.asset(
              //                                     LocalImages.icon_dislike),
              //                               ],
              //                             ),
              //                           ),
              //                         ),
              //                         kCommonSpaceH3,
              //                         Expanded(
              //                           child: ElevatedButton(
              //                               onPressed: () {},
              //                               style: ElevatedButton.styleFrom(
              //                                   shape: RoundedRectangleBorder(
              //                                     borderRadius: BorderRadius.all(
              //                                       Radius.circular(0.0),
              //                                     ),
              //                                   ),
              //                                   backgroundColor:
              //                                       CommonColors.primaryColor,
              //                                   tapTargetSize:
              //                                       MaterialTapTargetSize
              //                                           .shrinkWrap),
              //                               child: Text.rich(
              //                                 TextSpan(
              //                                   children: [
              //                                     TextSpan(
              //                                       text: S.of(context)!.comment,
              //                                       style: getAppStyle(
              //                                         color: CommonColors.mWhite,
              //                                         fontSize: 13,
              //                                         fontWeight: FontWeight.w600,
              //                                       ),
              //                                     ),
              //                                     TextSpan(
              //                                       text: '(50)',
              //                                       style: getAppStyle(
              //                                         color: CommonColors
              //                                             .secondaryColor,
              //                                         fontSize: 13,
              //                                         fontWeight: FontWeight.w600,
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 textAlign: TextAlign.center,
              //                               )),
              //                         ),
              //                         kCommonSpaceH3,
              //                         Expanded(
              //                           child: PrimaryButton(
              //                             height: 40,
              //                             onPress: (){},
              //                             borderRadius: BorderRadius.zero,
              //                             label: S.of(context)!.share,
              //                             lblSize: 13,
              //                           ),
              //                         ),
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SingleChildScrollView(
              //   child: Padding(
              //     padding: const EdgeInsets.only(bottom: 25,left: 15,right: 15,top: 15),
              //     child: Column(
              //       children: [
              //         kCommonSpaceV10,
              //         Container(
              //           width: 390,
              //           height: 128,
              //           decoration: ShapeDecoration(
              //             color: CommonColors.mWhite,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             shadows: [
              //               BoxShadow(
              //                 color: Color(0x3F000000),
              //                 blurRadius: 8,
              //                 offset: Offset(0, 2),
              //                 spreadRadius: 0,
              //               )
              //             ],
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Column(
              //               children: [
              //                 Text(
              //                   "Welcome to 'Pregnancy' channel",
              //                   style: getAppStyle(
              //                     color: CommonColors.secondaryColor,
              //                     fontSize: 23,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //                 kCommonSpaceV10,
              //                 Flexible(
              //                   child: Text(
              //                     'From mood swings & cramps to delayed periods & menopause - have all your period related discussions right here.',
              //                     style: getAppStyle(
              //                       color: CommonColors.mGrey,
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.w400,
              //                       height: 1,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //         kCommonSpaceV10,
              //         ListView.builder(
              //           physics: NeverScrollableScrollPhysics(),
              //           itemCount: 3,
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) {
              //             return Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Container(
              //                 width: 390,
              //                 height: 439,
              //                 clipBehavior: Clip.antiAlias,
              //                 decoration: ShapeDecoration(
              //                   color: CommonColors.mWhite,
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   shadows: [
              //                     BoxShadow(
              //                       color: Color(0x3F000000),
              //                       blurRadius: 8,
              //                       offset: Offset(0, 2),
              //                       spreadRadius: 0,
              //                     )
              //                   ],
              //                 ),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Row(
              //                         children: [
              //                           CircleAvatar(
              //                             backgroundImage: NetworkImage(
              //                                 "https://m.media-amazon.com/images/I/61SXghk-oNL._AC_SY500_.jpg"),
              //                             radius: 30,
              //                           ),
              //                           kCommonSpaceH10,
              //                           Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                             children: [
              //                               Text(
              //                                 'Allison Parker',
              //                                 style: getAppStyle(
              //                                   color: CommonColors.blackColor,
              //                                   fontSize: 16,
              //                                   fontWeight: FontWeight.w400,
              //                                 ),
              //                               ),
              //                               Text(
              //                                 '21 min.',
              //                                 style: getAppStyle(
              //                                   color: CommonColors.mGrey,
              //                                   fontSize: 14,
              //                                   height: 0.5,
              //                                   fontWeight: FontWeight.w400,
              //                                 ),
              //                               )
              //                             ],
              //                           ),
              //                           Expanded(
              //                             child: Align(
              //                               alignment: Alignment.topRight,
              //                               child: PopupMenuButton<SampleItem>(
              //                                 initialValue: selectedMenu,
              //                                 onSelected: (SampleItem item) {
              //                                   setState(() {
              //                                     selectedMenu = item;
              //                                   });
              //                                 },
              //                                 itemBuilder: (BuildContext
              //                                         context) =>
              //                                     <PopupMenuEntry<SampleItem>>[
              //                                   const PopupMenuItem<SampleItem>(
              //                                     value: SampleItem.itemOne,
              //                                     child: Text('Block User'),
              //                                   ),
              //                                   const PopupMenuItem<SampleItem>(
              //                                     value: SampleItem.itemTwo,
              //                                     child: Text('Report Post'),
              //                                   ),
              //                                   const PopupMenuItem<SampleItem>(
              //                                     value: SampleItem.itemThree,
              //                                     child: Text('Report User'),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     Container(
              //                       width: 390,
              //                       height: 186,
              //                       decoration: BoxDecoration(
              //                         image: DecorationImage(
              //                           image: NetworkImage(
              //                               "http://www.carenetme.org/wp-content/uploads/2016/09/491220532_XS.jpg"),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.end,
              //                           children: [
              //                             SvgPicture.asset(LocalImages.icon_like),
              //                             kCommonSpaceV5,
              //                             SvgPicture.asset(
              //                                 LocalImages.icon_dislike),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Text(
              //                         'What does 3 pink lines n HCG means',
              //                         style: getAppStyle(
              //                           color: CommonColors.blackColor,
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.w600,
              //                         ),
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding:
              //                           const EdgeInsets.only(left: 8, bottom: 5),
              //                       child: Text(
              //                         'I have a dark pink line in C and HCg shows threepink lines. I have taken test for first time andconfused ..which part to check C and T lines of H...',
              //                         style: getAppStyle(
              //                           color: CommonColors.mGrey,
              //                           fontSize: 13,
              //                           fontWeight: FontWeight.w400,
              //                           height: 1,
              //                         ),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(5.0),
              //                         child: Wrap(
              //                           children: hasTagText.map((tag) {
              //                             return Padding(
              //                               padding: const EdgeInsets.symmetric(
              //                                   horizontal: 4.0),
              //                               child: Row(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 children: [
              //                                   Text(
              //                                     '#$tag',
              //                                     style: getAppStyle(
              //                                       color: CommonColors
              //                                           .secondaryColor,
              //                                       fontSize: 13,
              //                                       fontWeight: FontWeight.w600,
              //                                     ),
              //                                   ),
              //                                   kCommonSpaceH5,
              //                                   Container(
              //                                     width: 1,
              //                                     height: 15,
              //                                     color: CommonColors.mGrey,
              //                                   ),
              //                                 ],
              //                               ),
              //                             );
              //                           }).toList(),
              //                         ),
              //                       ),
              //                     ),
              //                     Row(
              //                       children: [
              //                         Expanded(
              //                           child: PrimaryButton(
              //                             height: 40,
              //                             onPress: (){},
              //                             borderRadius: BorderRadius.zero,
              //                             label: S.of(context)!.follow,
              //                             lblSize: 13,
              //                           ),
              //                         ),
              //                         kCommonSpaceH3,
              //                         Expanded(
              //                           child: ElevatedButton(
              //                             onPressed: () {},
              //                             style: ElevatedButton.styleFrom(
              //                                 shape: RoundedRectangleBorder(
              //                                   borderRadius: BorderRadius.all(
              //                                     Radius.circular(0.0),
              //                                   ),
              //                                 ),
              //                                 backgroundColor:
              //                                 CommonColors.primaryColor,
              //                                 tapTargetSize: MaterialTapTargetSize
              //                                     .shrinkWrap),
              //                             child: Text.rich(
              //                               TextSpan(
              //                                 children: [
              //                                   TextSpan(
              //                                     text: S.of(context)!.comment,
              //                                     style: getAppStyle(
              //                                       color: Colors.white,
              //                                       fontSize: 13,
              //                                       fontWeight: FontWeight.w600,
              //                                     ),
              //                                   ),
              //                                   TextSpan(
              //                                     text: '(50)',
              //                                     style: getAppStyle(
              //                                       color: CommonColors
              //                                           .secondaryColor,
              //                                       fontSize: 13,
              //                                       fontWeight: FontWeight.w600,
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                               textAlign: TextAlign.center,
              //                             ),
              //                           ),
              //                         ),
              //                         kCommonSpaceH3,
              //                         Expanded(
              //                           child: PrimaryButton(
              //                             height: 40,
              //                             onPress: (){},
              //                             borderRadius: BorderRadius.zero,
              //                             label: S.of(context)!.share,
              //                             lblSize: 13,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ), */
            // floatingActionButton: tabController?.index == 1
            //     ? null
            //     : FloatingActionButton.small(
            //         backgroundColor: CommonColors.mWhite,
            //         onPressed: () {},
            //         child: Icon(
            //           Icons.add,
            //           color: CommonColors.primaryColor,
            //           size: 30,
            //         ),
            //         shape: RoundedRectangleBorder(
            //             side: BorderSide(
            //                 width: 1, color: CommonColors.primaryColor),
            //             borderRadius: BorderRadius.circular(100)),
            //       ),
            ),
      ),
    );
  }
}
