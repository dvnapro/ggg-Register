import 'package:Register/models/byField.dart';
import 'package:Register/services/firestore_service.dart';
import 'package:Register/widgets/gridlist/product.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabbar/tabbar.dart';

import 'byfield.dart';

class TabbedProductList extends StatefulWidget {
  TabbedProductList({Key key}) : super(key: key);

  @override
  _TabbedProductListState createState() => _TabbedProductListState();
}

class _TabbedProductListState extends State<TabbedProductList> {
  final tabcontroller = PageController();
  final fire = FirestoreService();
  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SafeArea(
    //       child: Column(
    //     children: <Widget>[
    //       Expanded(
    //         child: TabbarContent(
    //           controller: tabcontroller,
    //           children: <Widget>[
    //             ProductList(),
    //             StreamProvider<List<ProductByField>>.value(
    //               value: fire.byFieldNull('stockBarcode', true),
    //               child: ProductByFieldList(),
    //             ),
    //             StreamProvider<List<ProductByField>>.value(
    //               value: fire.byFieldNull('stockPurchasePrice', true),
    //               child: ProductByFieldList(),
    //             ),
    //             StreamProvider<List<ProductByField>>.value(
    //               value: fire.byFieldNull('stockSRP', true),
    //               child: ProductByFieldList(),
    //             ),
    //             StreamProvider<List<ProductByField>>.value(
    //               value: fire.byFieldLow('stocks', 10),
    //               child: ProductByFieldList(),
    //             ),
    //             StreamProvider<List<ProductByField>>.value(
    //               value: fire.byField('stockDesc', 'retail'),
    //               child: ProductByFieldList(),
    //             ),
    //             StreamProvider<List<ProductByField>>.value(
    //               value: fire.byField('stockDesc', 'wholesale'),
    //               child: ProductByFieldList(),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Container(
    //         alignment: Alignment.center,
    //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    //         child: TabbarHeader(
    //           controller: tabcontroller,
    //           tabs: [
    //             Tab(text: "All"),
    //             Tab(text: "No Barcode"),
    //             Tab(text: "No Purchase Price"),
    //             Tab(text: "No SRP"),
    //             Tab(text: "Low Stocks"),
    //             Tab(text: "For Retail"),
    //             Tab(text: "For Wholesale"),
    //           ],
    //         ),
    //       ),
    //     ],
    //   )),
    // );
    return DefaultTabController(
        length: 7,
        child: Scaffold(
          //appBar: AppBar(
          bottomNavigationBar: BottomAppBar(
            //backgroundColor: Colors.white,
            elevation: 0,
            child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.teal,
                indicatorPadding: EdgeInsets.only(left: 30, right: 30),
                indicator: ShapeDecoration(
                    color: Colors.teal,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.teal,
                        ))),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("ALL PRODUCTS"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("NO BARCODES"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("WITH BARCODES"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("NO SRP"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("LOW STOCKS"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("FOR RETAIL"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("FOR WHOLESALE"),
                    ),
                  ),
                ]),
            //),
          ),
          body: TabBarView(children: [
            ProductList(),
            StreamProvider<List<ProductByField>>.value(
              value: fire.byFieldNull('stockBarcode', true),
              child: ProductByFieldList(),
            ),
            StreamProvider<List<ProductByField>>.value(
              value: fire.byFieldNotNull('stockBarcode', null),
              child: ProductByFieldList(),
            ),
            StreamProvider<List<ProductByField>>.value(
              value: fire.byFieldNull('stockSRP', true),
              child: ProductByFieldList(),
            ),
            StreamProvider<List<ProductByField>>.value(
              value: fire.byFieldLow('stocks', 10),
              child: ProductByFieldList(),
            ),
            StreamProvider<List<ProductByField>>.value(
              value: fire.byField('stockDesc', 'retail'),
              child: ProductByFieldList(),
            ),
            StreamProvider<List<ProductByField>>.value(
              value: fire.byField('stockDesc', 'wholesale'),
              child: ProductByFieldList(),
            ),
          ]),
        ));
  }
}
