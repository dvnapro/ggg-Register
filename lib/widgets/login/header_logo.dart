import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/logo-teal-150.png',
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'CASHIER',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.teal[700],
            ),
          )
        ],
      ),
    );
  }
}
