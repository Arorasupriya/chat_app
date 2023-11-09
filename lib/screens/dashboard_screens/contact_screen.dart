import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  static const platform = MethodChannel('flutter_contacts/launch_contacts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Center(
        child: TextButton(
          child: const Text("Launch contact activity"),
          onPressed: () {},
        ),
      ),
    );
  }

  void launchContacts() async {
    try {
      await platform.invokeMethod('launch');
    } on PlatformException catch (e) {
      print("Failed to launch contacts: ${e.message}");
    }
    setState(() {});
  }
}
