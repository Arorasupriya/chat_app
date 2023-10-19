import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/screens/detail_screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstant.gradientDarkColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
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
                  "Profile",
                  style:
                  mTextStyle16(mFontColor: ColorConstant.tabSelectedColor),
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
                    InkWell(
                      radius: 30,
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EditProfileScreen()));
                      },
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.edit,
                            size: 25,
                            color: ColorConstant.gradientDarkColor,
                          ),
                        ),
                      ),
                    ),
                    hSpacer(mHeight: 25),

                    ///profile image
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        child: Image.asset(
                          "assets/icons/ic_profile.png",
                          width: 60,
                          height: 60,
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                    hSpacer(mHeight: 10),

                    ///User Name
                    Center(
                      child: Text(
                        "Supriya Arora",
                        style: mTextStyle16(
                            mFontColor: ColorConstant.gradientDarkColor,
                            mWeight: FontWeight.bold),
                      ),
                    ),
                    hSpacer(mHeight: 20),

                    ///User Email Address
                    Text(
                      "Email",
                      style: mTextStyle12(
                          mFontColor: ColorConstant.gradientDarkColor,
                          mWeight: FontWeight.w400),
                    ),
                    hSpacer(mHeight: 5),
                    Container(
                      width: size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "supriya@gmial.com",
                          style: mTextStyle12(
                              mFontColor: ColorConstant.gradientDarkColor,
                              mWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    ///User Mobile Number
                    hSpacer(mHeight: 20),
                    Text(
                      "Mobile Number",
                      style: mTextStyle12(
                          mFontColor: ColorConstant.gradientDarkColor,
                          mWeight: FontWeight.w400),
                    ),
                    hSpacer(mHeight: 5),
                    Container(
                      width: size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "9689547834",
                          style: mTextStyle12(
                              mFontColor: ColorConstant.gradientDarkColor,
                              mWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    ///User DOB
                    hSpacer(mHeight: 20),
                    Text(
                      "DOB",
                      style: mTextStyle12(
                          mFontColor: ColorConstant.gradientDarkColor,
                          mWeight: FontWeight.w400),
                    ),
                    hSpacer(mHeight: 5),
                    Container(
                      width: size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "29-NOV-1995",
                          style: mTextStyle12(
                              mFontColor: ColorConstant.gradientDarkColor,
                              mWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    ///User City
                    hSpacer(mHeight: 20),
                    Text(
                      "City",
                      style: mTextStyle12(
                          mFontColor: ColorConstant.gradientDarkColor,
                          mWeight: FontWeight.w400),
                    ),
                    hSpacer(mHeight: 5),
                    Container(
                      width: size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Mumbai",
                          style: mTextStyle12(
                              mFontColor: ColorConstant.gradientDarkColor,
                              mWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
