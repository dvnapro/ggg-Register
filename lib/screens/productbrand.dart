import 'package:Register/models/byField.dart';
import 'package:Register/routes/args/args.dart';
import 'package:Register/services/firestore_service.dart';
import 'package:Register/store/edit_product.dart';
import 'package:Register/widgets/gridlist/byfield.dart';
import 'package:Register/widgets/gridlist/product.dart';
import 'package:Register/widgets/text/header.dart';
import 'package:flutter/material.dart';
import 'package:Register/widgets/nav/drawer.dart';
import 'package:Register/widgets/nav/navbar.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductBrandPage extends StatelessWidget {
  static const String routeName = '/productbrand';
  final fire = FirestoreService();
  var now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    void editProduct() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EditProduct()));
    }

    final BrandArgs bargs = ModalRoute.of(context).settings.arguments;
    print(bargs.toString());

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
            text: (bargs == null)
                ? 'PRODUCTS LIST'
                : bargs.brandId.toUpperCase() + ' ITEMS',
          ),
          Expanded(
            child: Container(
              //padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: (bargs != null)
                  ? StreamProvider<List<ProductByField>>.value(
                      value: fire.byField('brandId', bargs.brandId),
                      child: ProductByFieldList(),
                    )
                  : ProductList(),
            ),
          )
        ],
      ),
      drawer: Drawer(child: NavDrawer()),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: editProduct,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
