import 'dart:async';

import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/screens/dashboard_screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      gotoNextScreen();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  
  gotoNextScreen(){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyTabView()));
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
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
                width: size.height * .80,
                height: size.width * .80,
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
}
