import 'package:Register/routes/routes.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  //void dashboard() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          //_drawerItem(
          // icon: Icons.add_shopping_cart_outlined,
          // text: 'Register',
          // onTap: () =>
          //     Navigator.pushReplacementNamed(context, Routes.register)),
          _drawerItem(
              icon: Icons.home,
              text: 'Dashboard',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.dashboard)),
          _drawerItem(
              icon: Icons.list,
              text: 'Products',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.product)),
          _drawerItem(
              icon: Icons.sort,
              text: 'Categories',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.categories)),
          _drawerItem(
              icon: Icons.brightness_auto_rounded,
              text: 'Brands',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.brand)),
          // _drawerItem(
          //     icon: Icons.store,
          //     text: 'Suppliers',
          //     onTap: () =>
          //         Navigator.pushReplacementNamed(context, Routes.supplier)),
          _drawerItem(
              icon: Icons.legend_toggle_sharp,
              text: 'Report',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.reports)),
        ],
      ),
    );
  }
}

Widget _drawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(
          'assets/drawer_bg.png',
        ),
      )),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Menu",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}

Widget _drawerItem({IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon, color: Colors.teal[700]),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.teal[700]),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
