import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SetImage extends StatefulWidget {
  const SetImage({super.key});

  @override
  State<SetImage> createState() => _SetImageState();
}

class _SetImageState extends State<SetImage> {
  late FirebaseStorage firebaseStorage;
  String imageURL = "";
  List<String> listImageURL = [];

  @override
  void initState() {
    firebaseStorage = FirebaseStorage.instance;
    var storageRef = firebaseStorage.ref().child("images");
    getImageURL(storageRef);

    ///get single image
    /*var storageRef = firebaseStorage.ref().child("images");
     var imageRef = storageRef.child("images/img_placeholder.png");
    getImageURL(imageRef);*/
    super.initState();
  }

  getImageURL(Reference storageRef) async {
    ListResult imageURLList = await storageRef.listAll();
    for (Reference eachImage in imageURLList.items) {
      imageURL = await eachImage.getDownloadURL();
      listImageURL.add(imageURL);
    }
    //imageURL = await imageRef.getDownloadURL();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: imageURL != ""
            ? ListView.builder(
                itemCount: listImageURL.length,
                itemBuilder: (context, index) {
                  return Image.network(listImageURL[index]);
                })
            : Container());
  }
}
