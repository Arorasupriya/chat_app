import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/global_methods_and_variables.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/screens/dashboard_screens/call.dart';
import 'package:fb_chat_app/screens/dashboard_screens/dashboard.dart';
import 'package:fb_chat_app/screens/dashboard_screens/map_screen.dart';
import 'package:fb_chat_app/screens/dashboard_screens/settings_screen.dart';
import 'package:fb_chat_app/screens/dashboard_screens/status_screen.dart';
import 'package:fb_chat_app/screens/onboarding_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Item { itemOne, itemTwo, itemThree, itemFour, itemFive }

class MyTabView extends StatefulWidget {
  String? getUid;

  MyTabView({super.key, this.getUid});

  @override
  State<MyTabView> createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> {
  var txtSearchController = TextEditingController();
  bool isSearching = false;
  Item? selectedMenu;

  void gotoSettingsScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  void gotoMapScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MapScreen()));
  }

  void signOut() async {
    var isLoggedIn = false;
    var userId = "";
    setUserDataInSP(isLoggedIn, userId);
    await FirebaseAuth.instance.signOut();
    print("u are successfully logout");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  @override
  void dispose() {
    txtSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      ///Add DefaultTabController here
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  ColorConstant.gradientDarkColor,
                  ColorConstant.gradientLightColor
                ])),
          ),

          ///AppBar Use IconButton=> menu text=>AppName
          actions: [
            PopupMenuButton(
                color: ColorConstant.tabSelectedColor,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Item>>[
                      PopupMenuItem<Item>(
                          value: Item.itemOne,
                          child: Text(
                            "New group",
                            style: mTextStyle12(),
                          )),
                      PopupMenuItem<Item>(
                          value: Item.itemTwo,
                          child: Text(
                            "Payment",
                            style: mTextStyle12(),
                          )),
                      PopupMenuItem<Item>(
                          onTap: () {
                            gotoSettingsScreen();
                          },
                          value: Item.itemThree,
                          child: Text(
                            "Settings",
                            style: mTextStyle12(),
                          )),
                      PopupMenuItem<Item>(
                          onTap: () {
                            gotoMapScreen();
                          },
                          value: Item.itemFour,
                          child: Text(
                            "Location",
                            style: mTextStyle12(),
                          )),
                      PopupMenuItem<Item>(
                          onTap: () {
                            signOut();
                          },
                          value: Item.itemFive,
                          child: Text(
                            "Sign Out",
                            style: mTextStyle12(),
                          )),
                    ])
          ],
          title: Text(
            "Chatify",
            style: mTextStyle16(
                mFontColor: ColorConstant.tabSelectedColor,
                mWeight: FontWeight.w500),
          ),
          bottom: TabBar(
            indicatorColor: ColorConstant.tabSelectedColor,
            dividerColor: ColorConstant.tabSelectedColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              const Tab(
                icon: Icon(
                  Icons.chat_bubble,
                  color: ColorConstant.tabSelectedColor,
                ),
              ),
              Tab(
                child: Image.asset(
                  "assets/icons/ic_status.png",
                  width: 24,
                  height: 24,
                  color: ColorConstant.tabSelectedColor,
                ),
              ),
              const Tab(
                icon: Icon(
                  Icons.call,
                  color: ColorConstant.tabSelectedColor,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          ///i pass screens in TabBarView
          children: [
            Dashboard(getUserId: widget.getUid),
            const StatusScreen(),
            const CallScreen()
          ],
        ),
      ),
    );
  }
}

/*
IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  color: ColorConstant.tabSelectedColor,
                ))*/
