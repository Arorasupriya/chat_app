import 'dart:io';

import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var txtUserNameController = TextEditingController();
  var txtUserEmailController = TextEditingController();
  var txtUserNumberController = TextEditingController();
  var txtUserCityController = TextEditingController();
  var txtUserDOBController = TextEditingController();

  //Create Date picker
  DateTime? birthDate;
  late String birthDateInString;

  //Image Picker

  String pickedImageURL = "";

  //Private function
  setTextFrame(
    TextEditingController controller,
    String hint,
    TextInputType keyboardType,
    TextInputAction textInputAction,
  ) {
    return SizedBox(
      height: 50,
      child: TextField(
        style: mTextStyle12(),
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide:
                const BorderSide(color: ColorConstant.gradientDarkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide:
                const BorderSide(color: ColorConstant.gradientDarkColor),
          ),
        ),
      ),
    );
  }

  setTextFrameWithIcon(
      TextEditingController controller,
      String hint,
      TextInputType keyboardType,
      TextInputAction textInputAction,
      Widget icon) {
    return SizedBox(
      height: 50,
      child: TextField(
        readOnly: true,
        style: mTextStyle12(),
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide:
                const BorderSide(color: ColorConstant.gradientDarkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide:
                const BorderSide(color: ColorConstant.gradientDarkColor),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2300));
    if (pickedDate != null && pickedDate != birthDate) {
      setState(() {
        birthDate = pickedDate;

        //Format Date
        birthDateInString =
            "${birthDate!.month}/${birthDate!.day}/${birthDate!.year}"; // 10/19/2023
        print("date DOB $birthDateInString ");
        txtUserDOBController.text = birthDateInString;
      });
    }
  }

  //BuildMethod
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorConstant.gradientDarkColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: ColorConstant.tabSelectedColor,
                        size: 24,
                      )),
                  Text(
                    "Edit Profile",
                    style: mTextStyle16(
                        mFontColor: ColorConstant.tabSelectedColor),
                  )
                ],
              ),
              hSpacer(),
              Container(
                height: size.height - 100,
                width: size.width,
                decoration: const BoxDecoration(
                    color: ColorConstant.tabSelectedColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      hSpacer(mHeight: 25),

                      ///profile image
                      Center(
                        child: SizedBox(
                          height: size.height * .15,
                          width: size.width * .30,
                          child: Stack(children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                image: pickedImageURL != ""
                                    ? DecorationImage(
                                        image: FileImage(File(pickedImageURL)))
                                    : const DecorationImage(
                                        image: AssetImage(
                                            "assets/icons/ic_user_default.png"),
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            Positioned(
                              right: 2,
                              bottom: 10,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        ColorConstant.gradientDarkColor,
                                    padding: EdgeInsets.zero,
                                    fixedSize: const Size(30, 30),
                                    shape: const CircleBorder()),
                                onPressed: () {
                                  //open Image Picker
                                  print("tap on camera button");
                                },
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 24,
                                  color: ColorConstant.tabSelectedColor,
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),

                      hSpacer(mHeight: 20),
                      setTextFrame(
                        txtUserNameController,
                        "User Name",
                        TextInputType.name,
                        TextInputAction.next,
                      ),
                      hSpacer(mHeight: 20),
                      setTextFrame(txtUserEmailController, "User Email",
                          TextInputType.emailAddress, TextInputAction.next),
                      hSpacer(mHeight: 20),
                      setTextFrame(
                          txtUserNumberController,
                          "User Mobile Number",
                          TextInputType.number,
                          TextInputAction.next),
                      hSpacer(mHeight: 20),
                      setTextFrame(txtUserCityController, "City Name",
                          TextInputType.text, TextInputAction.next),
                      hSpacer(mHeight: 20),
                      setTextFrameWithIcon(
                          txtUserDOBController,
                          "DOB",
                          TextInputType.text,
                          TextInputAction.done,
                          InkWell(
                            onTap: () {
                              selectDate(context);
                            },
                            child: const Icon(
                              Icons.date_range,
                              size: 24,
                              color: ColorConstant.gradientDarkColor,
                            ),
                          )),
                      hSpacer(mHeight: 50),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(100, 50),
                                backgroundColor:
                                    ColorConstant.gradientDarkColor),
                            onPressed: () {
                              print("Save all updates");
                            },
                            child: Text(
                              "Save",
                              style: mTextStyle16(
                                  mWeight: FontWeight.bold,
                                  mFontColor: ColorConstant.tabSelectedColor),
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
