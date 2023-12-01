import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/firebase/firebase_constant.dart';
import 'package:fb_chat_app/models/user_model.dart';
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
        child: FutureBuilder<UserModel>(
          future: FirebaseConstant.getCurrentUserData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              var userModel = snapshot.data;
              return Column(
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
                          InkWell(
                            radius: 30,
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfileScreen(
                                            myDataModel: userModel!,
                                          )));
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
                              radius: 50,
                              backgroundImage: userModel!.profilePic == ""
                                  ? const AssetImage(
                                      "assets/icons/ic_user_default.png",
                                    ) as ImageProvider
                                  : NetworkImage(
                                      userModel.profilePic,
                                    ),
                              /*child: userModel!.profilePic == ""
                                  ? Image.asset(
                                      "assets/icons/ic_user_default.png",
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.fill,
                                      filterQuality: FilterQuality.high,
                                    )
                                  : Image.network(
                                      userModel.profilePic,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    ),*/
                            ),
                          ),
                          hSpacer(mHeight: 10),

                          ///User Name
                          Center(
                            child: Text(
                              userModel.name.toString(),
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
                                userModel.email.toString(),
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
                                userModel.mobileNumber.toString(),
                                style: mTextStyle12(
                                    mFontColor: ColorConstant.gradientDarkColor,
                                    mWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          /* ///User DOB
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
                                              ),*/

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
                                userModel.city.toString(),
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
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
