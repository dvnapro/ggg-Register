// import 'package:Register/models/product.dart';
import 'package:Register/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _uname = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool _success;
  var _userEmail;
  var _uid;

  @override
  void initState() {
    super.initState();
    _uname.text = null;
    _pass.text = null;
    _uid = null;
    super.initState();
  }

  void dispose() {
    _uname.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text('Account Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              color: Colors.white,
              child: Container(
                //width: 500,
                child: TextField(
                  controller: _uname,
                  style: TextStyle(
                    color: Colors.teal[900],
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.email_rounded,
                        size: 40.0,
                        color: Colors.teal[600],
                      ),
                      border: const OutlineInputBorder(),
                      hintText: 'Email',
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.teal[700])),
                ),
              )),
          //==============***PASS INPUT TEXTFIELD CONTAINER***================//
          Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              color: Colors.white,
              child: Container(
                  child: TextField(
                controller: _pass,
                style: TextStyle(
                  color: Colors.teal[900],
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key_rounded,
                      size: 40.0,
                      color: Colors.teal[600],
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'Password',
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.teal[700])),
                obscureText: true,
              ))),
          //==============**LOGIN BUTTON CONTAINER***================//
          Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            color: Colors.white,
            child: FlatButton(
                //onPressed: login,
                onPressed: () {
                  //*************************ON PRESSED EVENT START*****************//
                  if (_uname.text == "" || _pass.text == "") {
                    setState(() {
                      _success = false;
                    });
                  } else {
                    if (EmailValidator.validate(_uname.text)) {
                      // final auth =
                      (context.read<AuthenticationService>().signIn(
                            email: _uname.text.trim().toLowerCase(),
                            password: _pass.text.trim().toLowerCase(),
                          )).then((String auth) {
                        setState(() {
                          _uid = auth.toString();
                          //_success = true;
                          login(_uid);
                        });
                      });
                    } else {
                      setState(() {
                        _success = false;
                      });
                    }
                  }
                },
                //**************************ON PRESSED EVENT END******************//
                textColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                color: Colors.white,
                child: Container(
                  height: 60,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.teal[700],
                      //border: Border.all(color: Colors.grey[700]),
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: const Text('LOGIN',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                )),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _success == null
                  ? ''
                  : (_success
                      ? 'Successfully signed in ' + _userEmail
                      : 'Sign in failed'),
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  void clear() {
    _uname.clear();
    _pass.clear();
  }

  void login(String id) async {
    if (id != "") {
      var userData = await _db.collection('users').doc(id).get();
      Map<String, dynamic> users = userData.data();
      if (users['role'] != null) {
        if (users['role'] == 'register') {
          //Navigator.pop(context);
          setState(() {
            _success = true;
            _userEmail = _uname.text +
                " is authorized with id" +
                id +
                " and role " +
                users['role'];
          });
        } else {
          setState(() {
            _success = true;
            _userEmail = _uname.text +
                " is not autorized width id" +
                id +
                " and role " +
                users['role'];
          });
        }
      } else {
        setState(() {
          _success = true;
          _userEmail = _uname.text + " is spy";
        });
      }
    } else {
      setState(() {
        _success = false;
        _userEmail = _uname.text + " illegal access";
      });
    }
  }
}
