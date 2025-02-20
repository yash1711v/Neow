// import 'package:flutter/material.dart';
// import 'package:gif_view/gif_view.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:provider/provider.dart';
// import 'package:vector_math/vector_math.dart' as math;
// import '../../../database/app_preferences.dart';
// import '../../../utils/common_colors.dart';
import '../../../utils/constant.dart';
// import '../../../utils/local_images.dart';
// import '../../naveli_ui/cycle_info/welcom_gif_view.dart';
// import 'splash_view_model.dart';
//
// class SplashView extends StatefulWidget {
//   const SplashView({Key? key}) : super(key: key);
//
//   @override
//   State<SplashView> createState() => _SplashViewState();
// }
//
// class _SplashViewState extends State<SplashView> {
//   late SplashViewModel mViewModel;
//   late GifController controller;
//   late AudioPlayer player;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = GifController(
//       autoPlay: false,
//       loop: false,
//       onFinish: onFinished,
//     );
//     Future.delayed(Duration.zero, () {
//       mViewModel.checkIsFirstTime();
//     });
//     Future.delayed(Duration(seconds: 3), () {
//       if (AppPreferences.instance.getIsFirstTime()) {
//         showHintDialog();
//       }
//     });
//     player = AudioPlayer();
//     player.setAsset(LocalImages.au_knock_door);
//   }
//
//   void showHintDialog() {
//     showGeneralDialog(
//       barrierColor: CommonColors.mTransparent,
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
//         return Transform(
//           transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//           child: Opacity(
//             opacity: a1.value,
//             child: AlertDialog(
//               backgroundColor: CommonColors.mTransparent,
//               elevation: 0,
//               // shape: OutlineInputBorder(
//               //     borderSide: BorderSide(color: CommonColors.darkPrimaryColor),
//               //     borderRadius: BorderRadius.circular(16.0)),
//               title: Image.asset(LocalImages.img_double_tap,fit: BoxFit.cover,)
//             ),
//           ),
//         );
//       },
//       transitionDuration: Duration(milliseconds: 800),
//       barrierDismissible: false,
//       barrierLabel: '',
//       context: context,
//       pageBuilder: (context, animation1, animation2) {
//         return SizedBox.shrink();
//       },
//     );
//
//     // Close the dialog after 3 seconds
//     Future.delayed(Duration(seconds: 3), () {
//       Navigator.of(context).pop();
//     });
//   }
//
//   void onFinished() {
//     mViewModel.onFinishGIF();
//   }
//
//   Future<void> playAudio() async {
//     try {
//       await player.play();
//     } catch (e) {
//       print("Error playing audio: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     mViewModel = Provider.of<SplashViewModel>(context);
//     return AppPreferences.instance.getIsFirstTime()
//         ? Scaffold(
//             body: GestureDetector(
//               // onTap: () {
//               //       showHintDialog();
//               // },
//               onDoubleTap: () {
//                 controller.play();
//                 playAudio();
//                 if (AppPreferences.instance.getIsFirstTime()) {
//                   // condition TRUE --> set first time false after 1 second
//                   Future.delayed(const Duration(seconds: 1), () {
//                     // updating after 1 second because in Splash view we fetch with singletone instance
//                     AppPreferences.instance.setIsFirstTime(false);
//                   });
//                 }
//               },
//               child: GifView.asset(
//                 LocalImages.gif_splash_door,
//                 controller: controller,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//               ),
//             ),
//           )
//         : const WelComeGifView();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     player.dispose();
//   }
// }

///

import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../database/app_preferences.dart';
import '../../../utils/local_images.dart';
import '../../naveli_ui/cycle_info/welcom_gif_view.dart';
import 'splash_view_model.dart';
class SplashViewVdo extends StatefulWidget {
  const SplashViewVdo({super.key});

  @override
  State<SplashViewVdo> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashViewVdo> {
  late SplashViewModel mViewModel;
  late VideoPlayerController vdo_Controller;
  late AudioPlayer player1;
  late AudioPlayer player2;

  bool isMute = true;
  bool isPlayingStart = false;

  loadVideoPlayer(String vpath) {
    vdo_Controller = VideoPlayerController.asset(vpath);
    vdo_Controller.addListener(() {
      setState(() {});
    });
    vdo_Controller.initialize().then((_) {
      vdo_Controller.play();
      vdo_Controller.setLooping(true);
      setState(() {});
    });
  }

  skipVideo() {
    vdo_Controller.pause();
    vdo_Controller.dispose();
    mViewModel.onFinishGIF(); // Move to next screen or animation
  }

  @override
  void initState() {
    super.initState();
    loadVideoPlayer('assets/video/door_animation_starting.mp4');
    Future.delayed(Duration.zero, () {
      mViewModel.checkIsFirstTime();
    });

    player1 = AudioPlayer();
    player2 = AudioPlayer();
    player1.setAsset(LocalImages.au_knock_door);
    player2.setAsset(LocalImages.knock_door_full_video);
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SplashViewModel>(context);
    return AppPreferences.instance.getIsFirstTime()
        ? Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              if (!isPlayingStart) {
                skipVideo();
              }
            },
            child: Center(
              child: VideoPlayer(vdo_Controller),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: skipVideo,
              style: TextButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (isMute) {
              vdo_Controller.setVolume(0.0);
            } else {
              vdo_Controller.setVolume(1.0);
            }
            isMute = !isMute;
          });
        },
        child: Icon(isMute ? Icons.volume_up : Icons.volume_off),
      ),
    )
        : const WelComeGifView();
  }

  @override
  void dispose() {
    player1.dispose();
    player2.dispose();
    vdo_Controller.dispose();
    super.dispose();
  }
}

