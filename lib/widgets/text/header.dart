import 'package:flutter/material.dart';

Widget pageHeader({String text}) {
  return Container(
    //padding: const EdgeInsets.all(20.0),
    alignment: Alignment.center,
    child: Text(
      text,
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal[600]),
    ),
  );
}
