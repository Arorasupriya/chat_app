import 'package:fb_chat_app/firebase/firebase_constant.dart';
import 'package:fb_chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubbleUI extends StatefulWidget {
  MessageModel msg;

  ChatBubbleUI({super.key, required this.msg});

  @override
  State<StatefulWidget> createState() => ChatBubbleUIState();
}

class ChatBubbleUIState extends State<ChatBubbleUI> {
  @override
  Widget build(BuildContext context) {
    var currUserID = FirebaseConstant.CURRENT_USER_ID;
    return widget.msg.fromId == currUserID ? fromMsgWidget() : toMsgWidget();
  }

  //yellow
  Widget fromMsgWidget() {
    var sentTime = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.msg.sent)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text('${sentTime.format(context)}'),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(11),
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(21),
                        topRight: Radius.circular(21),
                        bottomLeft: Radius.circular(21))),
                child: Text(widget.msg.message),
              ),
              /* if (widget.msg.msgType == "image")
                Container(
                    margin: const EdgeInsets.all(11),
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(21),
                            topRight: Radius.circular(21),
                            bottomLeft: Radius.circular(21))),
                    child: Image.network(
                      widget.msg.message,
                      width: 100,
                      height: 100,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                    )),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                      visible: widget.msg.read != "",
                      child: Text(widget.msg.read == ""
                          ? ""
                          : TimeOfDay.fromDateTime(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(widget.msg.read)))
                              .format(context)
                              .toString())),
                  const SizedBox(
                    width: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.done_all_outlined,
                      color: widget.msg.read != "" ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  //blue
  Widget toMsgWidget() {
    ///updateReadStatus
    if (widget.msg.read == "") {
      FirebaseConstant.updateReadTime(widget.msg.mId, widget.msg.fromId);
      print("fromid======>${widget.msg.fromId}mid${widget.msg.mId}");
    }

    var sentTime = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.msg.sent)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Container(
          margin: const EdgeInsets.all(11),
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(21),
                  topRight: Radius.circular(21),
                  bottomRight: Radius.circular(21))),
          child: Text(widget.msg.message),
        )),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text('${sentTime.format(context)}'),
        ),
      ],
    );
  }
}
