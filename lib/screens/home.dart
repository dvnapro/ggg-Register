// import 'package:Register/methods/alertDelete.dart';
import 'package:Register/models/byField.dart';
import 'package:Register/models/product.dart';
// import 'package:Register/screens/viewproduct.dart';
import 'package:Register/services/firestore_service.dart';
import 'package:Register/widgets/forms/form.dart';
import 'package:Register/widgets/gridlist/byfield.dart';
// import 'package:Register/store/edit_product.dart';
import 'package:Register/widgets/gridlist/product.dart';
import 'package:Register/widgets/gridlist/tabbedproduct.dart';
import 'package:Register/widgets/text/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Register/widgets/nav/drawer.dart';
import 'package:Register/widgets/nav/navbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:Register/widgets/datatable/products.dart';
// import 'package:Register/methods/search.dart';
// import 'package:Register/models/product.dart';
// import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  //final List<String> list = List.generate(10, (index) => "Text $index");

  static const String routeName = '/dashboard';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController barcode = TextEditingController();
  String _scanBarcode = '';
  Map<String, dynamic> itemList = {};
  Map<String, dynamic> itemLists = {};
  Product product;
  int len = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    barcode.dispose();
    super.dispose();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      barcode.text = barcodeScanRes;
    });
  }

  Future<void> getItem(barcode) async {
    _db
        .collection("items")
        .where('stockBarcode', isEqualTo: barcode)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if (itemList.length < querySnapshot.docs.length) {
          setState(() {
            itemList.addAll(result.data());
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final fire = FirestoreService();
    final products = Provider.of<List<Product>>(context);
    getItem(_scanBarcode);

    if (products != null) {
      setState(() {
        len = products.length;
      });
      if (products.length > 0) {
        for (int i = 0; i < len; i++) {
          if (_scanBarcode != products[i].stockBarcode) {
            setState(() {
              len = 1;
            });
          }
        }
      }
    }

    return Scaffold(
      appBar: NavBar(IconButton(
        icon: Icon(Icons.search),
        /*onPressed: searchbar*/ onPressed: null,
      )),
      body: Center(
        child: Column(
          children: [
            Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Center(child: pageHeader(text: "Products Master List")),
                SizedBox(
                  height: 10,
                ),
                inputIntFieldWithSuffixButton(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: barcode,
                  hint: 'Input Barcode here',
                  onChange: (value) {
                    setState(() {
                      _scanBarcode = value;
                    });
                  },
                  iconbutton: IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                    onPressed: () => scanBarcodeNormal(),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            (_scanBarcode == "")
                ? Expanded(child: TabbedProductList())
                : Expanded(
                    child: StreamProvider<List<ProductByField>>.value(
                      value: fire.byField('stockBarcode', _scanBarcode),
                      child: ProductByFieldList(),
                    ),
                  ),
          ],
        ),
        //child: CircularProgressIndicator(),
      ),
      drawer: Drawer(child: NavDrawer()),
    );
  }
}
