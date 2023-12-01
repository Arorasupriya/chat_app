//region ImportsHeaderFile
import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/firebase/firebase_constant.dart';
import 'package:fb_chat_app/models/user_model.dart';
import 'package:fb_chat_app/screens/dashboard_screens/contact_screen.dart';
import 'package:fb_chat_app/screens/detail_screens/chat_detail_screen.dart';
import 'package:flutter/material.dart';
//endregion

//region DashboardClass
class Dashboard extends StatefulWidget {
  Dashboard({
    super.key,
  });

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
      body: FutureBuilder<List<UserModel>>(
        future: FirebaseConstant.getAllUsers(),
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
            return ListView.builder(
                // padding: EdgeInsets.zero,
                //ListView
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  UserModel currentUserData = snapshot.data![index];
                  return InkWell(
                    //Inkwell => go to next screen
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatDetailScreen(
                                    currentUserName: currentUserData.name,
                                    toId: currentUserData.id!,
                                    imgProfile: currentUserData.profilePic,
                                  )));
                    },
                    child: ListTile(
                      horizontalTitleGap: 8,
                      //ListTile
                      key: ValueKey(index),
                      leading: CircleAvatar(
                          //CircleAvatar => leading
                          radius: 30,
                          foregroundImage: NetworkImage(currentUserData
                                      .profilePic !=
                                  ""
                              ? currentUserData.profilePic
                              : "https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png")),
                      title: Row(
                        //Row => title
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              currentUserData.name.toString(),
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
                                mWeight:
                                    isRead ? FontWeight.w500 : FontWeight.bold),
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
                });
          }
          return Container();
        },
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
