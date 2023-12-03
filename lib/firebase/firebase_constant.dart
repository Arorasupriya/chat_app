import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_chat_app/constants/global_methods_and_variables.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/models/message_model.dart';
import 'package:fb_chat_app/models/user_model.dart';
import 'package:fb_chat_app/screens/dashboard_screens/tab_screen.dart';
import 'package:fb_chat_app/screens/onboarding_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class FirebaseConstant {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static const String USER_COLLECTION = "users";
  static const String CHATROOM_COLLECTION = "chatroom";

  static String CURRENT_USER_ID = firebaseAuth.currentUser!.uid;

  ///PrivateMethod  SignUp()
  void pCreateUserWithEmailAndPassword(
      String userEmail,
      String userPassword,
      String userName,
      String userMobileNumber,
      String userCity,
      BuildContext context) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);

      gotoSignInScreen(context);

      firebaseFirestore
          .collection(USER_COLLECTION)
          .doc(firebaseAuth.currentUser!.uid)
          .set(UserModel(
                  id: firebaseAuth.currentUser!.uid,
                  name: userName,
                  email: userEmail,
                  mobileNumber: userMobileNumber,
                  city: userCity)
              .toJson());
      print("Signup successfully");
    } on FirebaseAuthException catch (e) {
      var title = "Sign up Alert";
      if (e.code == 'weak-password') {
        var strMessage = 'The password provided is too weak.';
        showAlertBox(strMessage, title, context);
      } else if (e.code == 'email-already-in-use') {
        var strMessage = 'The account already exists for that email.';
        showAlertBox(strMessage, title, context);
      }
      debugPrint(e.code);
    } catch (e) {
      debugPrint(e as String?);
    }
  }

  ///PrivateMethod  SignIn()
  void pSignInWithEmailAndPassword(
      String userEmail, String userPassword, BuildContext context) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);

      CURRENT_USER_ID = firebaseAuth.currentUser!.uid;
      print(
          "user added id ===> $CURRENT_USER_ID,${firebaseAuth.currentUser!.displayName}");
      print("SuccessFully logged in ");
      //save data in SharedPreference
      setUserDataInSP(true, "");
      // var idData = await getUserIdFromSP();
      //pass id in next screen
      gotoDashboardScreen(context);
    } on FirebaseAuthException catch (e) {
      var title = "Login Alert";
      if (e.code == 'user-not-found') {
        var content = 'No user found for that email.';
        showAlertBox(content, title, context);
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        var content = 'Invalid login credential';
        showAlertBox(content, title, context);
      }
      print("error${e.code}");
    } catch (e) {
      debugPrint(e as String?);
    }
  }

  ///getAllUsers
  static Future<List<UserModel>> getAllUsers() async {
    //create blank list
    List<UserModel> arrUsers = [];
    //get userCollection
    var arrGetAllUser =
        (await firebaseFirestore.collection(USER_COLLECTION).get());
    //seach userCollection Documents one by one
    for (QueryDocumentSnapshot<Map<String, dynamic>> eachUser
        in arrGetAllUser.docs) {
      //corvert each data in our model
      var eachUserData = UserModel.fromJson(eachUser.data());
      //check condition
      if (eachUserData.id != firebaseAuth.currentUser!.uid) {
        arrUsers.add(eachUserData);
      }
    }
    return arrUsers;
  }

  static void updateUserData(String downloadUrl, String name, String city,
      String email, String mobileNumber) {
    firebaseFirestore
        .collection(USER_COLLECTION)
        .doc(firebaseAuth.currentUser!.uid)
        .update(UserModel(
                name: name,
                email: email,
                city: city,
                mobileNumber: mobileNumber,
                profilePic: downloadUrl,
                isOnline: false,
                isActive: true,
                id: firebaseAuth.currentUser!.uid)
            .toJson());
  }

  ///getCurrentUserData
  static Future<UserModel> getCurrentUserData() async {
    //create blank list
    UserModel? currentUserDataModel;
    var data = (await firebaseFirestore
        .collection(USER_COLLECTION)
        .doc(firebaseAuth.currentUser!.uid)
        .get());
    var userCurrent = UserModel.fromJson(data.data()!);
    print("userCurrent${userCurrent.name},"
        "${userCurrent.email},"
        "${userCurrent.mobileNumber},"
        "${userCurrent.city},"
        "${userCurrent.id},"
        "${userCurrent.isActive},"
        "${userCurrent.isOnline}");
    return userCurrent;
  }

  ///getChatUniqueId
  static String getChatId(String fromId, String toId) {
    if (fromId.hashCode <= toId.hashCode) {
      return "${fromId}_$toId";
    } else {
      return "${toId}_$fromId";
    }
  }

  //sendMessage
  static void sendMsg(String msg, String toId) {
    var chatId = getChatId(firebaseAuth.currentUser!.uid, toId);
    print("Chat ID ===> $chatId");

    var sentTime = DateTime.now().millisecondsSinceEpoch;

    var message = MessageModel(
        fromId: firebaseAuth.currentUser!.uid,
        mId: sentTime.toString(),
        message: msg,
        sent: sentTime.toString(),
        toId: toId);

    firebaseFirestore
        .collection(CHATROOM_COLLECTION)
        .doc(chatId)
        .collection("message")
        .doc(sentTime.toString())
        .set(message.toJson());
  }

  //sendImage
  static void sendImage(String image, String toId) {
    var chatId = getChatId(firebaseAuth.currentUser!.uid, toId);
    print("Chat ID ===> $chatId");

    var sentTime = DateTime.now().millisecondsSinceEpoch;

    var message = MessageModel(
        fromId: firebaseAuth.currentUser!.uid,
        mId: sentTime.toString(),
        message: image,
        msgType: "image",
        sent: sentTime.toString(),
        toId: toId);

    firebaseFirestore
        .collection(CHATROOM_COLLECTION)
        .doc(chatId)
        .collection("message")
        .doc(sentTime.toString())
        .set(message.toJson())
        .then((value) => print("value store in collection"));
  }

  //getAllMessages
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(
      String toId) {
    var chatId = getChatId(firebaseAuth.currentUser!.uid, toId);
    return firebaseFirestore
        .collection(CHATROOM_COLLECTION)
        .doc(chatId)
        .collection("message")
        .snapshots();
  }

  //updateReadtime
  static void updateReadTime(String mId, String fromId) {
    var chatId = getChatId(firebaseAuth.currentUser!.uid, fromId);
    print("chat id ===> ${firebaseAuth.currentUser!.uid}${fromId}");

    var readTime = DateTime.now().millisecondsSinceEpoch;
    print("mid fromId${mId} ===> ${fromId}");

    firebaseFirestore
        .collection(CHATROOM_COLLECTION)
        .doc(chatId)
        .collection("message")
        .doc(mId)
        .update({"read": readTime.toString()});
  }

  //lastMsgRead
  static Stream<QuerySnapshot<Map<String, dynamic>>> lastMsgRead(
      String userChatId) {
    var chatId = getChatId(CURRENT_USER_ID, userChatId);
    return firebaseFirestore
        .collection(CHATROOM_COLLECTION)
        .doc(chatId)
        .collection("message")
        .orderBy("sent", descending: true)
        .limit(1)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUnReadCount(
      String chatUserId) {
    var chatId = getChatId(CURRENT_USER_ID, chatUserId);

    return firebaseFirestore
        .collection(CHATROOM_COLLECTION)
        .doc(chatId)
        .collection("message")
        .where("fromId", isEqualTo: chatUserId)
        .where("read", isEqualTo: "")
        .snapshots();
  }

  static TimeOfDay convertDateTimeToFormat(String sentTIme) {
    TimeOfDay getSentTime = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(int.parse(sentTIme)));
    return getSentTime;
  }
} //class

///Navigate other Screens private methode
void gotoDashboardScreen(BuildContext context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => MyTabView()));
}

void gotoSignInScreen(BuildContext context) {
  Navigator.pushReplacement(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 300),
        type: PageTransitionType.rightToLeft,
        child: const SignInScreen(),
      ));
}

//Show dialog
void showAlertBox(String content, String title, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: mTextStyle16(),
                ))
          ],
        );
      });
}

//create FirebaseAuth.instance
