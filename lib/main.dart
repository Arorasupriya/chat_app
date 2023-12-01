//region changeStatusBarColor
/*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: Colors.pink, // status bar color
  ));*/
//endregion

//region ImportsHeaderFile
import 'package:fb_chat_app/constants/app_colors.dart';
import 'package:fb_chat_app/firebase_options.dart';
import 'package:fb_chat_app/screens/detail_screens/set_profile_image.dart';
import 'package:fb_chat_app/screens/onboarding_screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//endregion

//region MainMethod
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
//endregion

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //region BuildMethod
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chatify',
        theme: ThemeData(
          //primarySwatch: Colors.cyan,
          useMaterial3: true,
        ),
        home: const SplashScreen()); // const SetImage()
  }
}
