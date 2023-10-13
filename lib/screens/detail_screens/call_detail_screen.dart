import 'package:flutter/material.dart';

class CallDetailScreen extends StatefulWidget {
  const CallDetailScreen({super.key});

  @override
  State<CallDetailScreen> createState() => _CallDetailScreenState();
}

class _CallDetailScreenState extends State<CallDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Call Detail Screen"),
      ),
    );
  }
}
