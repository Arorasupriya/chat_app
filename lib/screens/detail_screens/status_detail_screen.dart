import 'package:flutter/material.dart';

class StatusDetailScreen extends StatefulWidget {
  const StatusDetailScreen({super.key});

  @override
  State<StatusDetailScreen> createState() => _StatusDetailScreenState();
}

class _StatusDetailScreenState extends State<StatusDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Status Detail Screen"),
      ),
    );
  }
}
