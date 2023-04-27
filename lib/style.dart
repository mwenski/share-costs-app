import 'package:flutter/material.dart';

abstract class Style{
  static const TextStyle headerStyle = TextStyle(
    fontFamily: 'Helvetica',
    fontSize: 24,
    color: Colors.blue,
    height: 1,
    fontWeight: FontWeight.w600
  );

  static const TextStyle subheaderStyle = TextStyle(
    fontFamily: 'Helvetica',
    fontSize: 20,
    color: Colors.blue,
    height: 1.2,
    fontWeight: FontWeight.w400
  );

  static const TextStyle labelStyle = TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 16,
      color: Colors.blue,
      height: 1.2,
      fontWeight: FontWeight.w400
  );

  static const TextStyle dateStyle = TextStyle(
    fontFamily: 'Helvetica',
    fontSize: 14,
    color: Colors.black54,
    height: 0.8,
    fontWeight: FontWeight.w300
  );

  static const TextStyle loadingStyle = TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 24,
      color: Colors.blue,
      height: 1,
      fontWeight: FontWeight.w400
  );

  static const TextStyle errorStyle = TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 24,
      color: Colors.red,
      height: 1,
      fontWeight: FontWeight.w400
  );
}