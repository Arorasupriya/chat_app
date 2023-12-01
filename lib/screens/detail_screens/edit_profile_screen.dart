import 'dart:io';

import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/constants/custom_widget.dart';
import 'package:fb_chat_app/constants/my_text_styles.dart';
import 'package:fb_chat_app/firebase/firebase_constant.dart';
import 'package:fb_chat_app/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  late UserModel myDataModel;

  EditProfileScreen({super.key, required this.myDataModel});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late FirebaseStorage firebaseStorage;

  var txtUserNameController = TextEditingController();
  var txtUserEmailController = TextEditingController();
  var txtUserNumberController = TextEditingController();
  var txtUserCityController = TextEditingController();
  var txtUserDOBController = TextEditingController();

  //Create Date picker
  DateTime? birthDate;
  late String birthDateInString;
  File? takeImage;

  @override
  void initState() {
    firebaseStorage = FirebaseStorage.instance;
    txtUserNameController =
        TextEditingController(text: widget.myDataModel.name.toString());
    txtUserEmailController =
        TextEditingController(text: widget.myDataModel.email.toString());
    txtUserNumberController =
        TextEditingController(text: widget.myDataModel.mobileNumber.toString());
    txtUserCityController =
        TextEditingController(text: widget.myDataModel.city.toString());
    super.initState();
  }

  //BuildMethod
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorConstant.gradientDarkColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: ColorConstant.tabSelectedColor,
                        size: 24,
                      )),
                  Text(
                    "Edit Profile",
                    style: mTextStyle16(
                        mFontColor: ColorConstant.tabSelectedColor),
                  )
                ],
              ),
              hSpacer(),
              Container(
                height: size.height - 100,
                width: size.width,
                decoration: const BoxDecoration(
                    color: ColorConstant.tabSelectedColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      hSpacer(mHeight: 25),

                      ///profile image
                      Center(
                        child: SizedBox(
                          height: size.height * .15,
                          width: size.width * .30,
                          child: Stack(children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: widget.myDataModel.profilePic == ""
                                        ? const AssetImage(
                                                "assets/icons/ic_user_default.png")
                                            as ImageProvider
                                        : NetworkImage(
                                            widget.myDataModel.profilePic)),
                              ),
                            ),
                            Positioned(
                              right: 2,
                              bottom: 10,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        ColorConstant.gradientDarkColor,
                                    padding: EdgeInsets.zero,
                                    fixedSize: const Size(30, 30),
                                    shape: const CircleBorder()),
                                onPressed: () {
                                  //open Image Picker
                                  print("tap on camera button");
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return showDialogFrame();
                                      });
                                },
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 24,
                                  color: ColorConstant.tabSelectedColor,
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),

                      hSpacer(mHeight: 20),
                      setTextFrame(
                        txtUserNameController,
                        widget.myDataModel.name.toString(),
                        TextInputType.name,
                        TextInputAction.next,
                      ),
                      hSpacer(mHeight: 20),
                      setTextFrame(
                          txtUserEmailController,
                          widget.myDataModel.email.toString(),
                          TextInputType.emailAddress,
                          TextInputAction.next),
                      hSpacer(mHeight: 20),
                      setTextFrame(
                          txtUserNumberController,
                          widget.myDataModel.mobileNumber.toString(),
                          TextInputType.number,
                          TextInputAction.next),
                      hSpacer(mHeight: 20),
                      setTextFrame(
                          txtUserCityController,
                          widget.myDataModel.city.toString(),
                          TextInputType.text,
                          TextInputAction.next),
                      hSpacer(mHeight: 20),
                      /* setTextFrameWithIcon(
                          txtUserDOBController,
                          "DOB",
                          TextInputType.text,
                          TextInputAction.done,
                          InkWell(
                            onTap: () {
                              selectDate(context);
                            },
                            child: const Icon(
                              Icons.date_range,
                              size: 24,
                              color: ColorConstant.gradientDarkColor,
                            ),
                          )),*/
                      hSpacer(mHeight: 50),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(100, 50),
                                backgroundColor:
                                    ColorConstant.gradientDarkColor),
                            onPressed: () {
                              saveImageInFirebaseStorage();
                              print("Save all updates");
                            },
                            child: Text(
                              "Save",
                              style: mTextStyle16(
                                  mWeight: FontWeight.bold,
                                  mFontColor: ColorConstant.tabSelectedColor),
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Private function
  setTextFrame(
    TextEditingController controller,
    String hint,
    TextInputType keyboardType,
    TextInputAction textInputAction,
  ) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        style: mTextStyle12(),
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide:
                const BorderSide(color: ColorConstant.gradientDarkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide:
                const BorderSide(color: ColorConstant.gradientDarkColor),
          ),
        ),
      ),
    );
  }

  setTextFrameWithIcon(
      TextEditingController controller,
      String hint,
      TextInputType keyboardType,
      TextInputAction textInputAction,
      Widget icon) {
    return SizedBox(
      height: 50,
      child: TextField(
        readOnly: true,
        style: mTextStyle12(),
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide:
                const BorderSide(color: ColorConstant.gradientDarkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide:
                const BorderSide(color: ColorConstant.gradientDarkColor),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2300));
    if (pickedDate != null && pickedDate != birthDate) {
      setState(() {
        birthDate = pickedDate;

        //Format Date
        birthDateInString =
            "${birthDate!.month}/${birthDate!.day}/${birthDate!.year}"; // 10/19/2023
        print("date DOB $birthDateInString ");
        txtUserDOBController.text = birthDateInString;
      });
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 100);
      if (image == null) return;

      // final tempImage = File(image.path);
      var croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedImage != null) {
        takeImage = File(croppedImage.path);
      }
      setState(() {});
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

  saveImageInFirebaseStorage() {
    if (takeImage != null) {
      var currentTime = DateTime.now().millisecondsSinceEpoch;
      var ref = firebaseStorage
          .ref()
          .child("images/profile_images/img_$currentTime.jpg");
      try {
        ref.putFile(takeImage!).then((p0) async {
          print("image uploaded");

          var downloadImageUrl = await p0.ref.getDownloadURL();
          print("downloadImageUrl===> $downloadImageUrl");

          print(
              "${txtUserNameController.text.toString()} ${txtUserCityController.text.toString()},");
          FirebaseConstant.updateUserData(
              downloadImageUrl,
              txtUserNameController.text.toString(),
              txtUserCityController.text.toString(),
              txtUserEmailController.text.toString(),
              txtUserNumberController.text.toString());
        });
      } catch (e) {
        print("Error===> ${e.toString()}");
      }
      //get values how much file uploaded use below line
      //ref.putFile(takeImage!).asStream().listen((event) { });
    }
  }
}
