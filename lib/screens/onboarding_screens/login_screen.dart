import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/global_methods_and_variables.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/screens/clipper/custom_clipper.dart';
import 'package:fb_chat_app/screens/dashboard_screens/tab_screen.dart';
import 'package:fb_chat_app/screens/onboarding_screens/sing_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  var formKey = GlobalKey<FormState>();
  var txtEmailController = TextEditingController();
  var txtPasswordController = TextEditingController();

  late AnimationController animationControllerFromRight;
  late Animation<Offset> offsetAnimation;

  late AnimationController offsetAnimationControllerFromLeft;
  late Animation<Offset> offsetAnimationFromLeft;

  bool isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    createOffSetAnimationFromLeft();
    createOffSetAnimationFromRight();
  }

  @override
  void dispose() {
    animationControllerFromRight.dispose();
    offsetAnimationControllerFromLeft.dispose();
    super.dispose();
  }

  void createOffSetAnimationFromRight() {
    animationControllerFromRight = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    offsetAnimation =
        Tween<Offset>(begin: const Offset(1.5, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: animationControllerFromRight,
                curve: Curves.elasticInOut)); //const Interval(0.5, 1.0)
    animationControllerFromRight.forward(from: 0.0);
  }

  void createOffSetAnimationFromLeft() {
    offsetAnimationControllerFromLeft = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    offsetAnimationFromLeft =
        Tween<Offset>(begin: const Offset(-2.0, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: offsetAnimationControllerFromLeft,
          curve: Curves.elasticInOut),
    );
    offsetAnimationControllerFromLeft.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gradientLightColor,
        body: SingleChildScrollView(
          child: Stack(children: [
            ClipPath(
              clipper: LoginPageClipper(),
              child: Container(
                height: deviceHeight * 0.30,
                width: deviceWidth,
                color: ColorConstant.gradientDarkColor,
              ),
            ),
            Positioned(
              top: deviceHeight * 0.13,
              left: deviceWidth * 0.35,
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText("Sign In",
                      textStyle: mTextStyle25(mWeight: FontWeight.bold),
                      speed: Duration(milliseconds: 500),
                      colors: [
                        Colors.black,
                        ColorConstant.gradientLightColor,
                      ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    hSpacer(mHeight: 250),
                    //hSpacer(mHeight: 10),
                    SlideTransition(
                      position: offsetAnimationFromLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                          style: mTextStyle12(),
                          controller: txtEmailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: myDecoration(
                            mHintText: "Email Address",
                            mLabelText: "Enter Your Email",
                            bRadius: 12,
                          ),
                        ),
                      ),
                    ),
                    // hSpacer(mHeight: 20),
                    SlideTransition(
                      position: offsetAnimation,
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            } else if (value.isNotEmpty) {
                              if (value.length < 8) {
                                return "Must be at least 8 characters";
                              }
                            }
                            return null;
                          },
                          controller: txtPasswordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          obscureText: isPasswordVisible,
                          obscuringCharacter: "*",
                          decoration: myDecoration(
                              mHintText: "Password",
                              mLabelText: "Password",
                              bRadius: 12,
                              surFixIconName: isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              mySuffixIconColor: Colors.black.withOpacity(0.7),
                              onSurFixIconTap: () {
                                isPasswordVisible = !isPasswordVisible;
                                setState(() {});
                              }),
                        ),
                      ),
                    ),
                    hSpacer(mHeight: 50),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.gradientDarkColor,
                            elevation: 2.5,
                            fixedSize: const Size(150, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11))),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            //create FirebaseAuth.instance
                            var auth = FirebaseAuth.instance;
                            bool isLoggedIn;
                            String userId;

                            try {
                              // get all values in variable
                              var userEmail = txtEmailController.text;
                              var userPassword = txtPasswordController.text;

                              var credential =
                                  await auth.signInWithEmailAndPassword(
                                      email: userEmail,
                                      password: userPassword); //

                              print(
                                  "user added id ===> ${credential.user!.uid}");

                              //save data in SharedPreference
                              isLoggedIn = true;
                              userId = credential.user!.uid;
                              setUserDataInSP(isLoggedIn, userId);
                              print("========> $isLoggedIn,$userId");
                              print("SuccessFully logged in ");

                              //pass id in next screen
                              var idData = await getUserIdFromSP();
                              //navigate to next screen
                              gotoSignInScreen(idData);

                              //clear all text controllers
                              txtEmailController.clear();
                              txtPasswordController.clear();
                            } on FirebaseAuthException catch (e) {
                              var title = "Login Alert";
                              if (e.code == 'user-not-found') {
                                var content = 'No user found for that email.';
                                ShowAlertBox(content, title);
                              } else if (e.code ==
                                  'INVALID_LOGIN_CREDENTIALS') {
                                var content = 'Invalid login credential';
                                ShowAlertBox(content, title);
                              }
                              print("error${e.code}");
                            } catch (e) {
                              debugPrint(e as String?);
                            }
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: mTextStyle16(),
                        )),
                    hSpacer(mHeight: 30),
                    InkWell(
                      overlayColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.transparent;
                        }
                      }),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                              text: "Don't have an account?",
                              style: mTextStyle16(),
                              children: const [
                                TextSpan(
                                    text: " Sign up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void gotoSignInScreen(String uid) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyTabView(
                  getUid: uid,
                )));
  }

  void ShowAlertBox(String content, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ok",
                    style: mTextStyle16(),
                  ))
            ],
          );
        });
  }
}
