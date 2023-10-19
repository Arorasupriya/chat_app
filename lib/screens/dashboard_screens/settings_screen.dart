import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/screens/detail_screens/chat_detail_screen.dart';
import 'package:fb_chat_app/screens/detail_screens/profile_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> listItems = ["Profile", "Chat", "Privacy"];

  List<IconData> listIcons = [Icons.account_box, Icons.chat, Icons.security];

  List<Widget>  listScreens = [const ProfileScreen(),const ChatDetailScreen(),const ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:const IconThemeData(
          color: Colors.white
        ) ,
        title: Text(
          "Settings",
          style: mTextStyle16(mFontColor: ColorConstant.tabSelectedColor),
        ),
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
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> listScreens[index]));
            },
            child: ListTile(
              leading: Icon(
                listIcons[index],
                size: 24,
                color: ColorConstant.gradientDarkColor,
              ),
              title: Text(listItems[index].toString(), style: mTextStyle16()),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: ColorConstant.gradientDarkColor,
          );
        },
        itemCount: listItems.length,
      ),
    );
  }
}

//region Commented code
/*
return Scaffold(
     backgroundColor: ColorConstant.gradientDarkColor,
     body: Padding(
       padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
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
                   hSpacer(mHeight: 38),

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
   );*/
//endregion
