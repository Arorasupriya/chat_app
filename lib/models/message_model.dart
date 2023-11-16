class MessageModel {
  String? messageContent;
  String? messageType;

  MessageModel({this.messageContent, this.messageType});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        messageContent: json["messageContent"],
        messageType: json["messageType"]);
  }

  Map<String, dynamic> toJson() {
    return {"messageContent": messageContent, "messageType": messageType};
  }
}
