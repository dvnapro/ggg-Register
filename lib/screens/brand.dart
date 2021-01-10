///import 'package:Register/store/edit_brand.dart';
import 'package:Register/widgets/forms/addBrand.dart';
import 'package:Register/widgets/gridlist/brands.dart';
import 'package:Register/widgets/text/header.dart';
import 'package:flutter/material.dart';
import 'package:Register/widgets/nav/drawer.dart';
import 'package:Register/widgets/nav/navbar.dart';

class BrandPage extends StatelessWidget {
  static const String routeName = '/brand';

  //@override

  @override
  Widget build(BuildContext context) {
    // void editBrand() {
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => EditBrand()));
    // }

    void searchbar() {}
    return Scaffold(
      appBar:
          NavBar(IconButton(icon: Icon(Icons.search), onPressed: searchbar)),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          pageHeader(text: 'Product Brands'),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: AddBrand(),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: BrandsList(),
            ),
          )
        ],
      ),
      drawer: Drawer(child: NavDrawer()),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: editBrand,
      //   tooltip: 'Add new brand',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
