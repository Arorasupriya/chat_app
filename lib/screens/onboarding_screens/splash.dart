import 'dart:async';
import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/global_methods_and_variables.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/screens/dashboard_screens/tab_screen.dart';
import 'package:fb_chat_app/screens/onboarding_screens/sing_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    Timer(const Duration(seconds: 5), () {
      isUserSignIn();
    });
  }

  isUserSignIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? signInStatus = pref.getBool(AppVariables.IS_LOGGED_IN_USER) ?? false;
    String? getUserId = pref.getString(AppVariables.USER_ID) ?? "";
    print("get SP data in Splash $signInStatus,$getUserId");
    if (signInStatus) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyTabView(getUid: getUserId)));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignUpScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              ColorConstant.gradientDarkColor,
              ColorConstant.gradientLightColor
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/animations/animation_lnslszxp.json",
                width: deviceHeight * 0.8,
                height: deviceWidth * 0.8,
                fit: BoxFit.fill,
                controller: controller, onLoaded: (composition) {
              controller
                ..duration = composition.duration
                ..forward()
                ..repeat(reverse: true);
            }),
            Center(
              child: Text(
                "Chatify",
                style: mTextStyle25(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
