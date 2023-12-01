import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/firebase/firebase_constant.dart';
import 'package:fb_chat_app/models/message_model.dart';
import 'package:fb_chat_app/screens/detail_screens/chat_bubble_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ChatDetailScreen extends StatefulWidget {
  String? currentUserName = "";
  String toId;
  String? imgProfile;

  ChatDetailScreen(
      {super.key, this.currentUserName, this.toId = "", this.imgProfile});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  ButtonStyle myButtonStyle = ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll<Color>(
          ColorConstant.gradientLightColor),
      elevation: const MaterialStatePropertyAll<double>(2.0),
      shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))));
  ScrollController scrollController = ScrollController();

  var txtMessageBox = TextEditingController();
  int getTextLength = 0;
  bool isWrapWidgetVisible = true;
  bool isShowEmoji = false;
  String strOnlineStatus = "Online";
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatStream;
  File? takeImage;

  @override
  void initState() {
    super.initState();
    getChatStream();
  }

  getChatStream() {
    chatStream = FirebaseConstant.getAllMessage(widget.toId);
    print("toID====>${widget.toId}");
    setState(() {});
  }

  void scrollToBottom() {
    final bottomOffset = scrollController.position.maxScrollExtent;
    scrollController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          if (isShowEmoji) {
            FocusScope.of(context).unfocus();
            setState(() {
              isShowEmoji = !isShowEmoji;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: ColorConstant.gradientDarkColor,
            leadingWidth: 30,
            title: Row(
              children: [
                CircleAvatar(
                    radius: 20,
                    child: widget.imgProfile != ""
                        ? Image.network(
                            widget.imgProfile!,
                            height: 30,
                            width: 30,
                            fit: BoxFit.fill,
                          )
                        : Image.asset("assets/icons/ic_user_default.png")),
                wSpacer(mWidth: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        widget.currentUserName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: mTextStyle12(
                            mFontColor: ColorConstant.tabSelectedColor,
                            mWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      strOnlineStatus,
                      maxLines: 1,
                      style: mTextStyle12(
                          mFontColor: strOnlineStatus == "Online"
                              ? ColorConstant.tabSelectedColor
                              : ColorConstant.fontTitleBlackColor,
                          mWeight: FontWeight.w500),
                    ),
                  ],
                ),
                wSpacer(mWidth: 70),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.video_call,
                      size: 22,
                      color: ColorConstant.tabSelectedColor,
                    )),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.call,
                      size: 22,
                      color: ColorConstant.tabSelectedColor,
                    ))
              ],
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: ColorConstant.gradientDarkColor),
          ),
          body: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: chatStream,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    var allMeasses = snapshot.data!.docs;
                    print("Messages====> ${allMeasses.length}");
                    return allMeasses.isNotEmpty
                        ? ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var currMesg = MessageModel.fromJson(
                                  allMeasses[index].data());

                              return ChatBubbleUI(msg: currMesg);
                            })
                        : Container();
                  }
                  return Container();
                },
              )),
              Container(
                padding: EdgeInsets.zero,
                color: Colors.transparent,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                              controller: txtMessageBox,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              minLines: 1,
                              maxLines: 20,
                              onTap: () {
                                if (isShowEmoji) {
                                  setState(() {
                                    isShowEmoji = !isShowEmoji;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                hintText: "Type Message",
                                filled: true,
                                fillColor: Colors.blueGrey.shade50,
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      FocusScope.of(context).unfocus();
                                      isShowEmoji = !isShowEmoji;
                                    });
                                  },
                                  icon: Image.asset(
                                    "assets/icons/ic_smile.png",
                                    width: 24,
                                    height: 24,
                                    color: ColorConstant.gradientDarkColor,
                                  ),
                                ),
                                suffixIcon: Visibility(
                                  visible: isWrapWidgetVisible,
                                  child: Wrap(children: [
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 200,
                                                width: double.infinity,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          topRight:
                                                              Radius.circular(
                                                                  30)),
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GridView(
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 6,
                                                            crossAxisSpacing:
                                                                11,
                                                            mainAxisSpacing:
                                                                11),
                                                    children: [
                                                      IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          style: myButtonStyle,
                                                          onPressed: () {
                                                            pickImage(
                                                                ImageSource
                                                                    .camera);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .camera_alt_rounded,
                                                            size: 30,
                                                            color: Colors.white,
                                                          )),
                                                      IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          style: myButtonStyle,
                                                          onPressed: () {
                                                            pickImage(
                                                                ImageSource
                                                                    .gallery);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .photo_album_rounded,
                                                            size: 30,
                                                            color: Colors.white,
                                                          )),
                                                      IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          style: myButtonStyle,
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                            Icons
                                                                .file_copy_rounded,
                                                            size: 30,
                                                            color: Colors.white,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                        /* showDialog(
                                            context: context,
                                            builder: (context) {
                                              return showDialogFrame();
                                            });*/
                                      },
                                      icon: Image.asset(
                                        "assets/icons/ic_camera.png",
                                        width: 24,
                                        height: 24,
                                        color: ColorConstant.gradientDarkColor,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        "assets/icons/ic_microphone.png",
                                        width: 24,
                                        height: 24,
                                        color: ColorConstant.gradientDarkColor,
                                      ),
                                    ),
                                  ]),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConstant.gradientDarkColor),
                                    borderRadius: BorderRadius.circular(30)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: ColorConstant.gradientDarkColor),
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              onChanged: (value) {
                                if (value.length > 15) {
                                  setState(() {
                                    isWrapWidgetVisible = false;
                                  });
                                } else if (value.isEmpty) {
                                  setState(() {
                                    isWrapWidgetVisible = true;
                                  });
                                }
                              },
                              onSubmitted: (_) {
                                print("Submit");
                              })),
                      //wSpacer(mWidth: 0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // padding: EdgeInsets.zero,
                              elevation: 10,
                              backgroundColor: ColorConstant.gradientDarkColor,
                              fixedSize: const Size(50, 50),
                              shape: const CircleBorder()),
                          onPressed: () {
                            FirebaseConstant.sendMsg(
                                txtMessageBox.text.toString(), widget.toId);
                            txtMessageBox.clear();
                            scrollToBottom();
                            FocusScope.of(context).unfocus();
                          },
                          child: Image.asset(
                            "assets/icons/ic_send.png",
                            width: 40,
                            height: 40,
                            color: ColorConstant.tabSelectedColor,
                          )),
                    ],
                  ),
                ),
              ),
              if (isShowEmoji)
                SizedBox(
                  height: MediaQuery.of(context).size.height * .28,
                  child: EmojiPicker(
                    onBackspacePressed: () {},
                    textEditingController: txtMessageBox,
                    config: Config(
                      columns: 8,
                      emojiSizeMax: 30 * (Platform.isIOS ? 1.30 : 1.0),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 100);
      if (image == null) return;

      final tempImage = File(image.path);
      setState(() {
        takeImage = tempImage;
      });
    } on PlatformException catch (e) {
      print("Failed to Pick Image: $e");
    }
  }

  Widget showDialogFrame() {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetAnimationDuration: const Duration(seconds: 2),
      insetAnimationCurve: Curves.slowMiddle,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 15,
      child: Container(
        height: 250,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ColorConstant.gradientDarkColor, //drak
        ),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Select Image",
                style: mTextStyle25(
                  mFontColor: Colors.white,
                  mWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        elevation: 5),
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: FittedBox(
                      child: Text(
                        "Pick From Gallery",
                        style: mTextStyle16(
                            mFontColor: ColorConstant.gradientDarkColor,
                            mWeight: FontWeight.bold),
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      elevation: 5,
                    ),
                    onPressed: () {
                      pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: FittedBox(
                      child: Text(
                        "Pick From Camera",
                        style: mTextStyle16(
                            mFontColor: ColorConstant.gradientDarkColor,
                            mWeight: FontWeight.bold),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//how to call this //Button()
//region commented code
/*

WidgetsBinding.instance.addPostFrameCallback((_) {
                                scrollController.jumpTo(
                                    scrollController.position.maxScrollExtent);
                              });
Container(
               decoration: const BoxDecoration(
                   gradient: LinearGradient(
                       begin: Alignment.topLeft,
                       end: Alignment.bottomRight,
                       colors: [
                     ColorConstant.gradientDarkColor,
                     ColorConstant.gradientLightColor
                   ])),
               height: 60,
               width: double.infinity,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   children: [
                     IconButton(
                         onPressed: () {
                           hideKeyboard(context);
                           Navigator.pop(context);
                         },
                         icon: const Icon(
                           Icons.arrow_back_ios,
                           size: 22,
                           color: ColorConstant.tabSelectedColor,
                         )),
                     CircleAvatar(
                       radius: 20,
                       child: Image.asset(
                         "assets/icons/ic_profile.png",
                         height: 30,
                         width: 30,
                       ),
                     ),
                     wSpacer(mWidth: 5),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           "Supriya Arora",
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                           style: mTextStyle12(
                               mFontColor: ColorConstant.tabSelectedColor,
                               mWeight: FontWeight.bold),
                         ),
                         Text(
                           strOnlineStatus,
                           maxLines: 1,
                           style: mTextStyle12(
                               mFontColor: strOnlineStatus == "Online"
                                   ? ColorConstant.tabSelectedColor
                                   : ColorConstant.fontTitleBlackColor,
                               mWeight: FontWeight.bold),
                         ),
                       ],
                     ),
                     wSpacer(mWidth: 60),
                     IconButton(
                         onPressed: () {},
                         icon: const Icon(
                           Icons.video_call,
                           size: 22,
                           color: ColorConstant.tabSelectedColor,
                         )),
                     IconButton(
                         onPressed: () {},
                         icon: const Icon(
                           Icons.call,
                           size: 22,
                           color: ColorConstant.tabSelectedColor,
                         ))
                   ],
                 ),
               ),
             ),*/
/*class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20)],
      ),
      child: GestureDetector(
        child: Center(
            child: Image.asset(
          "assets/icons/ic_send.png",
          height: 20,
          width: 20,
        )),
        onTap: () {
          showPopover(
            context: context,
            bodyBuilder: (context) => const ListItems(),
            onPop: () => print('Popover was popped!'),
            direction: PopoverDirection.bottom,
            backgroundColor: Colors.white,
            width: 200,
            height: 400,
            arrowHeight: 15,
            arrowWidth: 30,
          );
        },
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..push(
                  MaterialPageRoute<SecondRoute>(
                    builder: (context) => SecondRoute(),
                  ),
                );
            },
            child: Container(
              height: 50,
              color: Colors.amber[100],
              child: const Center(child: Text('Entry A')),
            ),
          ),
          const Divider(),
          Container(
            height: 50,
            color: Colors.amber[200],
            child: const Center(child: Text('Entry B')),
          ),
          const Divider(),
          Container(
            height: 50,
            color: Colors.amber[300],
            child: const Center(child: Text('Entry C')),
          ),
          const Divider(),
          Container(
            height: 50,
            color: Colors.amber[400],
            child: const Center(child: Text('Entry D')),
          ),
          const Divider(),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry E')),
          ),
          const Divider(),
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry F')),
          ),
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Back'),
        ),
      ),
    );
  }
}*/
//endregion
