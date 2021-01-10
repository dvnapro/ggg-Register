import 'package:Register/store/edit_supplier.dart';
import 'package:Register/widgets/gridlist/suppliers.dart';
import 'package:Register/widgets/text/header.dart';
import 'package:flutter/material.dart';
import 'package:Register/widgets/nav/drawer.dart';
import 'package:Register/widgets/nav/navbar.dart';

class SupplierPage extends StatelessWidget {
  static const String routeName = '/supplier';

  //@override

  @override
  Widget build(BuildContext context) {
    void editSupplier() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EditSupplier()));
    }

    void searchbar() {}
    return Scaffold(
      appBar:
          NavBar(IconButton(icon: Icon(Icons.search), onPressed: searchbar)),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          pageHeader(text: 'Product Suppliers'),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SuppliersList(),
            ),
          )
        ],
      ),
      drawer: Drawer(child: NavDrawer()),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: editSupplier,
      //   tooltip: 'Add new product supplier',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
