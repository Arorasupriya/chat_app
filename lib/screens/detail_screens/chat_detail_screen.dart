import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/global_methods_and_variables.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  var txtMessageBox = TextEditingController();
  int getTextLength = 0;
  bool isWrapWidgetVisible = true;
  bool isShowEmoji = false;
  String strOnlineStatus = "Online";

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
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        ColorConstant.gradientDarkColor,
                        ColorConstant.gradientLightColor
                      ])),
                  height: 80,
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
                ),
                const Expanded(child: Stack()),
                Container(
                  padding: EdgeInsets.zero,
                  color: Colors.transparent,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
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
                                        onPressed: () {},
                                        icon: Image.asset(
                                          "assets/icons/ic_camera.png",
                                          width: 24,
                                          height: 24,
                                          color:
                                              ColorConstant.gradientDarkColor,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Image.asset(
                                          "assets/icons/ic_microphone.png",
                                          width: 24,
                                          height: 24,
                                          color:
                                              ColorConstant.gradientDarkColor,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              ColorConstant.gradientDarkColor),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              ColorConstant.gradientDarkColor),
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
                                elevation: 5,
                                backgroundColor:
                                    ColorConstant.gradientDarkColor,
                                fixedSize: const Size(40, 40),
                                shape: const CircleBorder()),
                            onPressed: () {},
                            child: Image.asset(
                              "assets/icons/ic_send.png",
                              width: 30,
                              height: 30,
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
      ),
    );
  }
}

//how to call this //Button()
//region ShowPopOver
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
