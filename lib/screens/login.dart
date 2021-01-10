import 'package:Register/widgets/login/header_logo.dart';
import 'package:Register/widgets/login/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String routeName;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //@override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(50),
            //border: Border.all(color: Colors.brown[900], width: 3),
            color: Colors.white54),
        child: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 150.0,
              ),
              LoginLogo(),
              SizedBox(
                height: 80.0,
              ),
              Container(
                width: 500,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: LoginForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
