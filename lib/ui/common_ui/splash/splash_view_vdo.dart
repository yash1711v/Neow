import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:just_audio/just_audio.dart';
import 'package:naveli_2023/ui/common_ui/splash/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../database/app_preferences.dart';
import '../../../utils/local_images.dart';
import '../../naveli_ui/cycle_info/welcom_gif_view.dart';

class SplashViewVdo extends StatefulWidget {
  const SplashViewVdo({super.key});

  @override
  State<SplashViewVdo> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashViewVdo> {
  late SplashViewModel mViewModel;
  late GifController firstController;
  late GifController secondController;
  late AudioPlayer player1;
  late AudioPlayer player2;
  late VideoPlayerController vdo_Controller;
  bool isPlayingFirstGif = true;
  bool isMute = true;
  bool isPlayingStart = false;
  loadVideoPlayer(String vpath) {
    vdo_Controller = VideoPlayerController.asset(vpath);
    vdo_Controller.addListener(() {
      setState(() {});
    });
    vdo_Controller.initialize().then((value) {
      vdo_Controller.play();
      vdo_Controller.setLooping(true);
      setState(() {});
    });
  }

  loadSecondVideoPlayer(String vpath) {
    vdo_Controller = VideoPlayerController.asset(vpath);
    vdo_Controller.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });

    });
    vdo_Controller.initialize().then((value) {
      vdo_Controller.play();
      // vdo_Controller.setLooping(true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadVideoPlayer('assets/video/door_animation_starting.mp4');
    Future.delayed(Duration.zero, () {
      mViewModel.checkIsFirstTime();
    });
    /* firstController = GifController(
      autoPlay: true,
      loop: false,
    );
    secondController = GifController(
      autoPlay: false,
      loop: false,
      onFinish: onFinished, // Set onFinish callback for the second GIF
    );


     */
    player1 = AudioPlayer();
    player2 = AudioPlayer();
    player1.setAsset(LocalImages.au_knock_door);
    player2.setAsset(LocalImages.knock_door_full_video);
  }

  void onFinished() {
    mViewModel.onFinishGIF();
  }

  Future<void> playAudio1() async {
    setState(() {
      isPlayingStart = true;
    });
    print(
        "Play Audio =============================================================");
    try {
      await player1.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> playAudio2() async {
    try {
      await player2.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void toggleGif() {
    setState(() {
      playAudio1();
      playAudio2();
      isPlayingFirstGif = !isPlayingFirstGif;
      if (isPlayingFirstGif) {
        firstController.play();
        secondController.pause();
      } else {
        firstController.pause();
        secondController.play();
      }
    });
  }

  void toggleMute() {
    setState(() {
      isMute = !isMute;
    });
  }


  skipVideo() {
    vdo_Controller.pause();
    vdo_Controller.dispose();
    mViewModel.onFinishGIF(); // Move to next screen or animation
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SplashViewModel>(context);
    return AppPreferences.instance.getIsFirstTime()
        ? Scaffold(
      body: GestureDetector(
        onTap: () async {
          // toggleGif();
          if (isPlayingStart) {
            print("False ==");
          } else {
            playAudio1();
            // playAudio2();

            Future.delayed(const Duration(seconds: 1), () {
              loadSecondVideoPlayer('assets/video/new_Door_Open.mp4');

              // condition TRUE --> set first time false after 1 second
              Future.delayed(const Duration(seconds: 28), () {
                // updating after 1 second because in Splash view we fetch with singleton instance
                loadSecondVideoPlayer('assets/video/logoanimation.mp4');
                if (AppPreferences.instance.getIsFirstTime()) {
                  Future.delayed(const Duration(seconds: 7), () {
                    vdo_Controller.setLooping(false);
                    vdo_Controller.pause();
                    setState(() {});
                    mViewModel.onFinishGIF();
                    AppPreferences.instance
                        .setIsFirstTime(false); //need to change
                  });
                }
              });
            });
          }
        },
        child: FittedBox(
          fit: BoxFit.none,
          child: SizedBox(
            width: vdo_Controller.value.size.width,
            height: vdo_Controller.value.size.height,
            child: Stack(
              children: [
                VideoPlayer(vdo_Controller),
                Positioned(
                  top: 100,
                  right: 50,
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
          ),
        ), /* Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 7.8/16,

                     child: VideoPlayer(vdo_Controller),
                  ),
                ],
              ), */
      ),
      floatingActionButton: SizedBox(
        height: 30.0,
        width: 30.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                // pause

                if (isMute) {
                  vdo_Controller.setVolume(0.0);
                } else {
                  // play
                  vdo_Controller.setVolume(1.0);
                }
                toggleMute();
              });
            },
            // icon
            child: Icon(
              isMute ? Icons.volume_up : Icons.volume_off,
            ),
          ),
        ),
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