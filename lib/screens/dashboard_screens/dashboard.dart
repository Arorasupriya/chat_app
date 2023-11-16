//region ImportsHeaderFile
import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/screens/dashboard_screens/contact_screen.dart';
import 'package:fb_chat_app/screens/detail_screens/chat_detail_screen.dart';
import 'package:flutter/material.dart';
//endregion

//region DashboardClass
class Dashboard extends StatefulWidget {
  String? getUserId;
  Dashboard({super.key, this.getUserId});

  @override
  State<Dashboard> createState() => _DashboardState();
}
//endregion

//region DashboardStateClass
class _DashboardState extends State<Dashboard> {
  //region VariableDeclarations
  var txtSearchController = TextEditingController();
  bool isRead = true;

  //endregion

  //PrivateMethod
  void gotoNextScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ContactScreen()));
  }

  //region BuildMethod
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SearchBar
            /* SizedBox(
              height: 50,
              child: TextField(
                controller: txtSearchController,
                decoration: myDecoration(
                  bColor: Colors.blueGrey.shade100,
                  mHintText: "",
                  mLabelText: 'Search Person',
                  preFixIconName: Icons.search,
                  mFillColor: Colors.blueGrey.shade100,
                  isFilled: true,
                ),
              ),
            ),*/

            //ChatListView
            Expanded(
              flex: 2,
              child: ListView.builder(
                  // padding: EdgeInsets.zero,
                  //ListView
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      //Inkwell => go to next screen
                      onTap: () {
                        print("Tapped index$index");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChatDetailScreen()));
                      },
                      child: ListTile(
                        horizontalTitleGap: 8,
                        //ListTile
                        key: ValueKey(index),
                        leading: CircleAvatar(
                          //CircleAvatar => leading
                          radius: 30,
                          child: Image.asset(
                            "assets/icons/ic_profile.png",
                            width: 40,
                            height: 40,
                          ),
                        ),
                        title: Row(
                          //Row => title
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "WSCubeTechFlutterDevelopment",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: mTextStyle16(
                                    mFontColor: ColorConstant.mattBlackColor,
                                    mWeight: isRead
                                        ? FontWeight.w500
                                        : FontWeight.bold),
                              ),
                            ),
                            Text(
                              "12:30 PM",
                              style: mTextStyle12(
                                  mFontColor: isRead
                                      ? Colors.blueGrey
                                      : ColorConstant.fontTitleBlackColor,
                                  mWeight: isRead
                                      ? FontWeight.w500
                                      : FontWeight.bold),
                            )
                          ],
                        ),
                        subtitle: Row(
                          //Row => subtitle
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text("current message current message",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: mTextStyle12(
                                      mFontColor: isRead
                                          ? Colors.blueGrey
                                          : ColorConstant.mattBlackColor,
                                      mWeight: isRead
                                          ? FontWeight.w500
                                          : FontWeight.bold)),
                            ),
                            isRead
                                ? Container()
                                : CircleAvatar(
                                    backgroundColor:
                                        ColorConstant.gradientDarkColor,
                                    radius: 10,
                                    child: Text(
                                      "2",
                                      style: mTextStyle12(
                                          mFontColor:
                                              ColorConstant.tabSelectedColor),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 10,
        backgroundColor: ColorConstant.gradientDarkColor,
        onPressed: () {
          gotoNextScreen();
        },
        child: Image.asset(
          "assets/icons/ic_add_chat.png",
          width: 30,
          height: 30,
          color: ColorConstant.tabSelectedColor,
        ),
      ),
    );
  }
//endregion
}
//endregion
