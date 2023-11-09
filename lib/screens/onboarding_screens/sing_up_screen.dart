import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/models/user_model.dart';
import 'package:fb_chat_app/screens/clipper/custom_clipper.dart';
import 'package:fb_chat_app/screens/onboarding_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  var txtNameController = TextEditingController();
  var txtEmailController = TextEditingController();
  var txtMobileNumberController = TextEditingController();
  var txtCityController = TextEditingController();
  var txtPasswordController = TextEditingController();

  bool isPasswordVisible = true;

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
              child: Text(
                "Sign Up",
                style: mTextStyle25(mWeight: FontWeight.bold),
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
                    Padding(
                      padding: const EdgeInsets.all(11.0),
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
                    //hSpacer(mHeight: 10),
                    Padding(
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
                    //hSpacer(mHeight: 20),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
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
                    //hSpacer(mHeight: 20),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
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
                    // hSpacer(mHeight: 20),
                    Padding(
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
                    hSpacer(mHeight: 20),
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

                            try {
                              // get all values in variable
                              var userName = txtNameController.text;
                              var userEmail = txtEmailController.text;
                              var userMobileNumber =
                                  txtMobileNumberController.text;
                              var userCity = txtCityController.text;
                              var userPassword = txtPasswordController.text;

                              var credential =
                                  await auth.createUserWithEmailAndPassword(
                                      email: userEmail,
                                      password: userPassword); //

                              var db = FirebaseFirestore.instance;
                              db
                                  .collection("users")
                                  .doc(credential.user!.uid)
                                  .set(UserModel(
                                          name: userName,
                                          email: userEmail,
                                          mobileNumber: userMobileNumber,
                                          city: userCity,
                                          id: credential.user!.uid)
                                      .toJson());
                              print(
                                  "user added id ===> ${credential.user!.uid}");
                              print("Signup successfully");

                              //clear all text controllers
                              txtNameController.clear();
                              txtEmailController.clear();
                              txtMobileNumberController.clear();
                              txtCityController.clear();
                              txtPasswordController.clear();
                              gotoSignInScreen();
                            } on FirebaseAuthException catch (e) {
                              var title = "Sign up Alert";
                              if (e.code == 'weak-password') {
                                var strMessage =
                                    'The password provided is too weak.';
                                ShowAlertBox(strMessage, title);
                              } else if (e.code == 'email-already-in-use') {
                                var strMessage =
                                    'The account already exists for that email.';
                                ShowAlertBox(strMessage, title);
                              }
                              debugPrint(e.code);
                            } catch (e) {
                              debugPrint(e as String?);
                            }
                          }
                        },
                        child: Text(
                          "Sign-Up",
                          style: mTextStyle16(),
                        )),
                    hSpacer(mHeight: 20),
                    InkWell(
                      onTap: () {
                        gotoSignInScreen();
                      },
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
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
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
                    txtNameController.clear();
                    txtEmailController.clear();
                    txtMobileNumberController.clear();
                    txtCityController.clear();
                    txtPasswordController.clear();
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
