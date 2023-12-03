//region ImportsHeaderFile
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/firebase/firebase_constant.dart';
import 'package:fb_chat_app/models/message_model.dart';
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
                  return StreamBuilder(
                    stream: FirebaseConstant.lastMsgRead(currentUserData.id!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            message = snapshot.data!.docs;
                        MessageModel? lastMsgModel;
                        if (message.isNotEmpty) {
                          lastMsgModel =
                              MessageModel.fromJson(message[0].data());
                        }
                        return InkWell(
                          //Inkwell => go to next screen
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatDetailScreen(
                                          currentUserName: currentUserData.name,
                                          toId: currentUserData.id!,
                                          imgProfile:
                                              currentUserData.profilePic,
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
                                        mFontColor:
                                            ColorConstant.mattBlackColor,
                                        mWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  message.isNotEmpty
                                      ? FirebaseConstant
                                              .convertDateTimeToFormat(
                                                  lastMsgModel!.sent)
                                          .format(context)
                                      : "",
                                  style: mTextStyle12(
                                      mFontColor: lastMsgModel!.read != ""
                                          ? Colors.blueGrey
                                          : ColorConstant.fontTitleBlackColor,
                                      mWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            subtitle: Row(
                              //Row => subtitle
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                        message.isEmpty
                                            ? ""
                                            : lastMsgModel.message,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: mTextStyle12(
                                            mFontColor: Colors.blueGrey,
                                            mWeight: FontWeight.bold))),
                                message.isNotEmpty
                                    ? showReadStatus(
                                        lastMsgModel, currentUserData.id!)
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
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

  Widget showReadStatus(MessageModel lastMsg, String chatUserId) {
    if (lastMsg.fromId == FirebaseConstant.CURRENT_USER_ID) {
      return Icon(
        Icons.done_all,
        size: 20,
        color: lastMsg.read != "" ? Colors.blue : Colors.grey,
      );
    } else {
      return StreamBuilder(
        stream: FirebaseConstant.getUnReadCount(chatUserId),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            var messages = snapshot.data!.docs;
            if (messages.isEmpty) {
              return const SizedBox();
            } else {
              return Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    '${messages.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          }
          return const SizedBox();
        },
      );
    }
  }
//endregion
}
//endregion
