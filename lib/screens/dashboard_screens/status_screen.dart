import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/screens/detail_screens/status_detail_screen.dart';
import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Status",
              style: mTextStyle16(
                  mWeight: FontWeight.bold,
                  mFontColor: ColorConstant.mattBlackColor),
            ),
            hSpacer(mHeight: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StatusDetailScreen()));
              },
              child: ListTile(
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
                      mWeight: FontWeight.bold,
                      mFontColor: ColorConstant.mattBlackColor),
                ),
                subtitle: Text(
                  "time",
                  style: mTextStyle16(mFontColor: Colors.blueGrey),
                ),
              ),
            ),
            hSpacer(mHeight: 20),
            Text(
              "Resent updates",
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
                        //Inkwell => go to next screen
                        onTap: () {
                          print("Tapped index$index");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const StatusDetailScreen()));
                        },
                        child: ListTile(
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
                                mWeight: FontWeight.bold,
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
      ),
    );
  }
}
