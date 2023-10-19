import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/screens/dashboard_screens/call.dart';
import 'package:fb_chat_app/screens/dashboard_screens/dashboard.dart';
import 'package:fb_chat_app/screens/dashboard_screens/settings_screen.dart';
import 'package:fb_chat_app/screens/dashboard_screens/status_screen.dart';
import 'package:flutter/material.dart';

enum Item { itemOne, itemTwo, itemThree }

class MyTabView extends StatefulWidget {
  const MyTabView({super.key});

  @override
  State<MyTabView> createState() => _MyTabViewState();
}

class _MyTabViewState extends State<MyTabView> {
  Item? selectedMenu;
  
  void gotoNextScreen(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
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
                        onTap: (){
                             gotoNextScreen();
                        },
                          value: Item.itemThree,
                          child: Text(
                            "Settings",
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
        body: const TabBarView(
          ///i pass screens in TabBarView
          children: [Dashboard(), StatusScreen(), CallScreen()],
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
