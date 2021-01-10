import 'package:Register/screens/home.dart';
import 'package:Register/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var _role;

  void initState() {
    _role = null;
    super.initState();
  }

  void dispose() {
    _role.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authUser = context.watch<User>();

    if (authUser != null) {
      final id = authUser.uid;
      login(id).then(
        (String role) {
          if (this.mounted) {
            setState(
              () {
                _role = role.toString();
              },
            );
          }
        },
      );
      // return Scaffold(
      //   body: Container(child: Text(id + " /n " + _role)),
      // );
      if (_role == 'register') {
        return HomePage();
      } else {
        return LoginPage();
      }
    } else {
      return LoginPage();
    }
  }

  Future<String> login(String id) async {
    var userData = await _db.collection('users').doc(id).get();
    Map<String, dynamic> users = userData.data();

    if (users['role'] != null) {
      if (users['role'] == 'register') {
        //Navigator.pop(context);
        //return HomePage();
        final role = users['role'];
        return await role;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   @override
//   Widget build(BuildContext context) {

//   }

// }
