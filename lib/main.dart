//region ImportsHeaderFile
import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/screens/dashboard_screens/call.dart';
import 'package:fb_chat_app/screens/dashboard_screens/dashboard.dart';
import 'package:fb_chat_app/screens/dashboard_screens/status_screen.dart';
import 'package:flutter/material.dart';

//endregion

//region MainMethod
void main() {
  runApp(const MyApp());
}
//endregion

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //region BuildMethod
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        ///Add DefaultTabController here
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            ///AppBar Use IconButton=> menu text=>AppName
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    color: ColorConstant.mattBlackColor,
                  ))
            ],
            title: Text(
              "Chatify",
              style: mTextStyle16(
                  mFontColor: Colors.blueGrey, mWeight: FontWeight.w500),
            ),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                const Tab(
                  icon: Icon(Icons.chat_bubble),
                ),
                Tab(
                  child: Image.asset(
                    "assets/icons/ic_status.png",
                    width: 24,
                    height: 24,
                  ),
                ),
                const Tab(
                  icon: Icon(Icons.call),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            ///i pass screens in TabBarView
            children: [Dashboard(), StatusScreen(), CallScreen()],
          ),
        ),
      ),
    );
  }
}
