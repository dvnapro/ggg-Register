//import 'package:Register/routes/routes.dart';
import 'package:Register/services/auth_service.dart';
import 'package:Register/store/edit_trans.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:Register/methods/search.dart';
import 'package:provider/provider.dart';
import 'package:Register/screens/viewtrans.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance;

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  NavBar(IconButton iconButton);

  @override
  _NavBarState createState() => _NavBarState();

  @override
  Size get preferredSize {
    return new Size.fromHeight(kToolbarHeight);
  }
}

class _NavBarState extends State<NavBar> {
  final List<String> list = List.generate(10, (index) => "Text $index");

  void transPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TransPage()));
  }

  void viewTransPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ViewTransPage()));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            // icon: Image.asset(
            //   'assets/logo_small.png',
            // ),
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: Text(
        'CASHIER',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        // Padding(
        //     padding: EdgeInsets.only(right: 20.0),
        //     child: IconButton(
        //       onPressed: () {
        //         ////showSearch(context: context, delegate: Search(list));
        //       },
        //       icon: Icon(
        //         Icons.search,
        //       ),
        //     )),
        Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: IconButton(
              onPressed: viewTransPage,
              icon: Icon(
                Icons.list_alt_outlined,
                size: 25.0,
              ),
            )),
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: transPage,
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 25.0,
              ),
            )),

        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              icon: Icon(Icons.logout),
            )),
      ],
    );
  }
}
