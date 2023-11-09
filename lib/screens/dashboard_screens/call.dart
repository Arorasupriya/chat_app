import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/screens/detail_screens/call_detail_screen.dart';
import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool isVideoCall = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Resent",
            style: mTextStyle16(
                mWeight: FontWeight.bold, mFontColor: Colors.blueGrey),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                //ListView
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: InkWell(
                      //Inkwell => go to next screen (CallDetailScreen())
                      onTap: () {
                        print("Tapped index$index");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CallDetailScreen()));
                      },
                      child: ListTile(
                        trailing: isVideoCall
                            ? const Icon(
                                Icons.video_call,
                                size: 24,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.call,
                                size: 24,
                                color: Colors.green,
                              ),
                        leading: CircleAvatar(
                          child: Image.asset(
                            "assets/icons/ic_profile.png",
                            width: 40,
                            height: 40,
                          ),
                        ),
                        title: Text(
                          "Supriya Arora",
                          style: mTextStyle16(
                              mWeight: FontWeight.w400,
                              mFontColor: ColorConstant.mattBlackColor),
                        ),
                        subtitle: Text(
                          "time",
                          style: mTextStyle16(mFontColor: Colors.blueGrey),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    ));
  }
}
