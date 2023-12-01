import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/firebase/firebase_constant.dart';
import 'package:fb_chat_app/screens/clipper/custom_clipper.dart';
import 'package:fb_chat_app/screens/onboarding_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  //animation
  late AnimationController opacityController;
  late Animation<double> opacityAnimation;

  late AnimationController animationControllerFromRight;
  late Animation<Offset> offsetAnimationFromRight;

  late AnimationController offsetAnimationControllerFromLeft;
  late Animation<Offset> offsetAnimationFromLeft;

  //variable Declaration
  var formKey = GlobalKey<FormState>();
  var txtNameController = TextEditingController();
  var txtEmailController = TextEditingController();
  var txtMobileNumberController = TextEditingController();
  var txtCityController = TextEditingController();
  var txtPasswordController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    createOpacityAnimation();
    createOffSetAnimationFromRight();
    createOffSetAnimationFromLeft();
  }

  @override
  void dispose() {
    opacityController.dispose();
    animationControllerFromRight.dispose();
    offsetAnimationControllerFromLeft.dispose();
    super.dispose();
  }

  void createOpacityAnimation() {
    opacityController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(opacityController)
          ..addListener(() {
            setState(() {});
          });
    opacityController.forward();
  }

  void createOffSetAnimationFromRight() {
    animationControllerFromRight = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    offsetAnimationFromRight =
        Tween<Offset>(begin: const Offset(1.5, 0.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: animationControllerFromRight,
                curve: Curves.easeIn)); //const Interval(0.5, 1.0)
    animationControllerFromRight.forward(from: 0.0);
  }

  void createOffSetAnimationFromLeft() {
    offsetAnimationControllerFromLeft = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    offsetAnimationFromLeft =
        Tween<Offset>(begin: const Offset(-2.0, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: offsetAnimationControllerFromLeft, curve: Curves.easeIn),
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
                isRepeatingAnimation: false,
                totalRepeatCount: 1,
                animatedTexts: [
                  WavyAnimatedText("Sign Up",
                      textStyle: mTextStyle25(mWeight: FontWeight.bold)),
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
                    hSpacer(mHeight: 180),
                    SlideTransition(
                      position: offsetAnimationFromRight,
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          elevation: 1,
                          color: ColorConstant.gradientLightColor,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                            style: mTextStyle12(),
                            controller: txtNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: myDecoration(
                                mHintText: "Name",
                                mLabelText: "Enter Your Name",
                                bRadius: 12),
                          ),
                        ),
                      ),
                    ),
                    //hSpacer(mHeight: 10),
                    SlideTransition(
                      position: offsetAnimationFromLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          elevation: 1,
                          color: ColorConstant.gradientLightColor,
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
                    ),
                    //hSpacer(mHeight: 20),
                    SlideTransition(
                      position: offsetAnimationFromRight,
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          elevation: 1,
                          color: ColorConstant.gradientLightColor,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your number";
                              } else if (value.isNotEmpty) {
                                if (value.length != 10) {
                                  return "Please enter valid mobile number (10 digit)";
                                }
                              }
                              return null;
                            },
                            style: mTextStyle12(),
                            controller: txtMobileNumberController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: myDecoration(
                              mHintText: "Mobile Number",
                              mLabelText: "Enter Your Mobile Number",
                              bRadius: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //hSpacer(mHeight: 20),
                    SlideTransition(
                      position: offsetAnimationFromLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          elevation: 1,
                          color: ColorConstant.gradientLightColor,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your city";
                              }
                              return null;
                            },
                            style: mTextStyle12(),
                            controller: txtCityController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: myDecoration(
                              mHintText: "City",
                              mLabelText: "Enter City",
                              bRadius: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // hSpacer(mHeight: 20),
                    SlideTransition(
                      position: offsetAnimationFromRight,
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          elevation: 1,
                          color: ColorConstant.gradientLightColor,
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
                                mySuffixIconColor:
                                    Colors.black.withOpacity(0.7),
                                onSurFixIconTap: () {
                                  isPasswordVisible = !isPasswordVisible;
                                  setState(() {});
                                }),
                          ),
                        ),
                      ),
                    ),
                    hSpacer(mHeight: 20),
                    Opacity(
                      opacity: opacityAnimation.value,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.gradientDarkColor,
                              elevation: 2.5,
                              fixedSize: const Size(150, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11))),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              FirebaseConstant()
                                  .pCreateUserWithEmailAndPassword(
                                      txtEmailController.text.toString(),
                                      txtPasswordController.text.toString(),
                                      txtNameController.text.toString(),
                                      txtMobileNumberController.text.toString(),
                                      txtCityController.text.toString(),
                                      context);
                              formKey.currentState!.reset();
                            }
                          },
                          child: Text(
                            "Sign-Up",
                            style: mTextStyle16(),
                          )),
                    ),
                    hSpacer(mHeight: 20),
                    InkWell(
                      //splashColor: ColorConstant.gradientLightColor,
                      overlayColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.transparent;
                        }
                      }),
                      onTap: () {
                        gotoSignInScreen();
                      },
                      child: Opacity(
                        opacity: opacityAnimation.value,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                                text: "Already have an account?",
                                style: mTextStyle16(),
                                children: const [
                                  TextSpan(
                                      text: " Log in",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))
                                ]),
                          ),
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

  void gotoSignInScreen() {
    Navigator.pushReplacement(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 300),
          type: PageTransitionType.rightToLeft,
          child: const SignInScreen(),
        ));
  }
}

//region CommentedCode

/*
AnimatedTextKit(
                  isRepeatingAnimation: false,
                  totalRepeatCount: 1,
                  animatedTexts: [
                    WavyAnimatedText(
                      "Already have an account?  Log in ",
                    ),
                  ],
                )*/
//endregion
