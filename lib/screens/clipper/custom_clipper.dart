import 'package:flutter/material.dart';

class LoginPageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path myPath = Path();
    myPath.lineTo(size.width, 0);
    myPath.lineTo(size.width, size.height * 0.5);
    myPath.quadraticBezierTo(
        size.width * 0.5, size.height, 0, size.height * 0.5);
    myPath.close();
    return myPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
