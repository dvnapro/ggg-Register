import 'package:Register/models/byField.dart';
// import 'package:Register/models/bycategory.dart';
// import 'package:Register/models/product.dart';
import 'package:Register/routes/args/args.dart';
import 'package:Register/services/firestore_service.dart';
import 'package:Register/store/edit_product.dart';
// import 'package:Register/widgets/gridlist/byCategory.dart';
import 'package:Register/widgets/gridlist/byfield.dart';
// import 'package:Register/widgets/gridlist/product.dart';
import 'package:Register/widgets/gridlist/tabbedproduct.dart';
//import 'package:Register/widgets/gridlist/productsbycategory.dart';
import 'package:Register/widgets/text/header.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Register/widgets/nav/drawer.dart';
import 'package:Register/widgets/nav/navbar.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductPage extends StatelessWidget {
  final fire = FirestoreService();
  static const String routeName = '/product';
  var now = new DateTime.now();
  final tabcontroller = PageController();

  @override
  Widget build(BuildContext context) {
    //final products = Provider.of<List<Product>>(context);
    void editProduct() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EditProduct()));
    }

    final CategoryArgs args = ModalRoute.of(context).settings.arguments;

    void searchbar() {}
    return Scaffold(
      appBar:
          NavBar(IconButton(icon: Icon(Icons.search), onPressed: searchbar)),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          pageHeader(
            text: (args == null)
                ? 'PRODUCTS LIST'
                : args.catname.toUpperCase() + ' ITEMS',
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              //padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //child: (args != null) ? ProductByCategoryList() : ProductList(),
              child: (args != null)
                  ? StreamProvider<List<ProductByField>>.value(
                      value: fire.byField('categoryId', args.catname),
                      child: ProductByFieldList(),
                    )
                  //: ProductList(),
                  : TabbedProductList(),
            ),
          )
        ],
      ),
      drawer: Drawer(child: NavDrawer()),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 30),
      //   child: FloatingActionButton(
      //     onPressed: editProduct,
      //     tooltip: 'Increment',
      //     child: Container(child: Icon(Icons.add)),
      //     //elevation: 40,
      //     //mini: true,

      //     backgroundColor: Colors.cyan[600],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.blue,
      //   notchMargin: 50,
      //   shape: CircularNotchedRectangle(),
      //   child: Container(
      //     height: 20,
      //   ),
      // ),
    );
  }
}
