//region ImportsHeaderFile
import 'package:fb_chat_app/screens/dashboard_screens/contact_screen.dart';
import 'package:fb_chat_app/screens/splash.dart';
import 'package:flutter/material.dart';

//endregion

//region MainMethod
void main() {
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
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
