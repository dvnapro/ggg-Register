import 'dart:async';

import 'package:Register/provider/product_stocks_log_provider.dart';
import 'package:Register/provider/cart_provider.dart';
import 'package:Register/provider/trans_provider.dart';
//import 'package:Register/widgets/trans/desc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:Register/routes/routes.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:Register/widgets/forms/form.dart';

import 'package:Register/services/firestore_service.dart';
//import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';

class TransPage extends StatefulWidget {
  final String trans;
  final String status;
  final int xitems;
  final double xprice;
  TransPage([this.trans, this.status, this.xitems, this.xprice]);
  @override
  _TransPageState createState() => _TransPageState();
}

class _TransPageState extends State<TransPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController _searchBarcode = TextEditingController();
  String _qrInfo = 'Scan a QR/Bar code';
  Map cartItems;

  String x = "";
  // dynamic productId;
  // dynamic binderId;
  // dynamic brand;
  // dynamic name;
  // dynamic srp;
  // dynamic unit;
  // dynamic color;
  // dynamic material;
  // dynamic measure;
  // dynamic descri;
  // dynamic qrcode;
  int _runits = 1;
  int _wunits = 1;
  int _rdiscount = 0;
  int _wdiscount = 0;
  int _totalItems = 0;
  int curStocks = 0;
  double totalSales = 0.00;
  double _totalSales = 0.00;
  String brandname;
  String xdesc;
  String _barcode;
  var sbrand;
  var sname;
  dynamic ssrp;
  var scolor;
  var smaterial;
  var smeasure;
  var sproductId;
  var sbinderId;
  var sunit;
  var sstocks;
  var sstockDesc;
  var sbarcode;
  var spsrp;
  var uuid = Uuid();
  String transId;
  final fire = FirestoreService();

  static int currentTimeInSeconds() {
    var ms = (new DateTime.now()).millisecondsSinceEpoch;
    return (ms / 1000).round();
  }

  // var orderNo = (widget.trans!=null) ? currentTimeInSeconds().toString() : widget.trans;
  var orderNo;
  @override
  void initState() {
    super.initState();
    // getTransItems(orderNo);
    orderNo = (widget.trans == null)
        ? currentTimeInSeconds().toString()
        : widget.trans.toString();
    // _totalItems =
    //     (widget.xitems == 0 || widget.xitems == null) ? 0 : widget.xitems;
    _totalItems = 0;
    _searchBarcode.text = "";
    // totalSales = (widget.status == 'completed') ? widget.xprice : 0;
    //camState = true;
    print(widget.trans.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  transcode() {
    return transId = uuid.v4().toString();
  }

  // _qrCallback(String code) {
  //   setState(() {
  //     //_camState = false;
  //     x = code;
  //     getCode(x);
  //   });
  // // }
  // trans(int len, double x) async {
  //   setState(() {
  //     _totalItems = len;
  //     _totalSales = x;
  //   });
  // }

  Future<void> scanQR() async {
    x = null;
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
      //if (widget.status == 'complete') {
      _barcode = barcodeScanRes.toString();
      _searchBarcode.text = barcodeScanRes.toString().toUpperCase();
      //} else {
      x = barcodeScanRes;
      //}
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    x = null;
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
      x = barcodeScanRes;
    });
  }

  void _addRUnit() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 1,
            maxValue: curStocks,
            title: new Text("Pick a new units/pieces"),
            initialIntegerValue: _runits,
          );
        }).then((int value) {
      if (value != null) {
        setState(() => _runits = value);
      }
    });
  }

  void _addWUnit() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 1,
            maxValue: curStocks,
            title: new Text("Pick a new units/pieces"),
            initialIntegerValue: _wunits,
          );
        }).then((int value) {
      if (value != null) {
        setState(() => _wunits = value);
      }
    });
  }

  void _addRDiscount() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 0,
            maxValue: 15,
            title: new Text("Pick a new discount"),
            initialIntegerValue: _rdiscount,
          );
        }).then((int value) {
      if (value != null) {
        setState(() => _rdiscount = value);
      }
    });
  }

  void _addWDiscount() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 0,
            maxValue: 15,
            title: new Text("Pick a new discount"),
            initialIntegerValue: _wdiscount,
          );
        }).then((int value) {
      if (value != null) {
        setState(() => _wdiscount = value);
      }
    });
  }

  void _showDeleteTransDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete This Transaction?'),
            content: const Text(
                'This will delete this transaction from your database.'),
            actions: <Widget>[
              FlatButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text('Go Back and Delete'),
                onPressed: () {
                  final productProvider =
                      Provider.of<ProductTransProvider>(context, listen: false);
                  _db
                      .collection('transx')
                      .doc(orderNo)
                      .collection('cart')
                      .where('transId', isEqualTo: orderNo)
                      .get()
                      .then((value) => {
                            if (value.docs.isEmpty)
                              {
                                productProvider.removeTrans(orderNo),
                                Navigator.pushReplacementNamed(
                                    context, Routes.viewtrans)
                              }
                            else
                              {
                                showDialog<int>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Alert!"),
                                        content: Text(
                                            "Cannot delete transaction #: ${orderNo.toString()} because it's not empty."),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(
                                                  context, Routes.viewtrans);
                                            },
                                          ),
                                        ],
                                      );
                                    })
                              }
                          });

                  // setState(() {
                  //   x = "";
                  // });
                },
              )
            ],
          );
        });
  }

  Future<void> getTransItems(var orderNo) async {
    await _db
        .collection('transx')
        .doc(orderNo)
        .collection('cart')
        .where('transId', isEqualTo: orderNo)
        .get()
        .then((value) => {
              setState(() {
                _totalItems = value.docs.length.toInt();
              })
            });
  }

  // String qr;
  // bool camState = false;

  @override
  Widget build(BuildContext context) {
    final transProvider = Provider.of<ProductTransProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final stocksProvider = Provider.of<StocksLogProvider>(context);
    // final productProvider = Provider.of<ProductProvider>(context);
    final authUser = context.watch<User>();
    final uid = authUser.uid.toString();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    var now = formatter.format(DateTime.now());

    print(widget.trans.toString() +
        " | " +
        widget.xitems.toString() +
        " | " +
        _totalItems.toString());
    if (widget.trans == null) {
      transProvider.changeTransId(orderNo);
      // transProvider.changeOrderNo(orderNo);
      transProvider.changeUserId(uid);
      transProvider.changeTotalPrice(0.00);
      // transProvider.changeTotalItems(_totalItems.toInt());
      transProvider.changeTransDate(now.toString());

      transProvider.changeProductTrans("sales");
      transProvider.changeStatus("in-progress");
      transProvider.saveProductTrans();
    }
    // if (x != null) {
    //   asyncConfirmDialog(context, x);
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('CASHIER TRANSACTIONS'),
        // leading: (widget.status == null || widget.status == 'in-progress')
        //     ? (_totalItems == 0)
        //         ? new IconButton(
        //             icon: new Icon(Icons.arrow_back),
        //             onPressed: () {
        //               _showDeleteTransDialog();
        //             },
        //           )
        //         : null
        //     : (_totalItems == 0)
        //         ? new IconButton(
        //             icon: new Icon(Icons.arrow_back),
        //             onPressed: () {
        //               _showDeleteTransDialog();
        //             },
        //           )
        //         : null,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            (widget.status == null || widget.status == 'in-progress')
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "SCAN",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Icon(Icons.shopping_cart_outlined,
                                color: Colors.teal),
                          ],
                        ),
                        onTap: () => scanBarcodeNormal(),
                      ),
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "SCAN",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Icon(Icons.qr_code_outlined, color: Colors.teal)
                          ],
                        ),
                        onTap: () => {scanQR()},
                      ),
                    ],
                  )
                : SizedBox(
                    width: 0,
                  ),
            SizedBox(height: 10),
            (widget.status == null || widget.status == 'in-progress')
                ? Stack(
                    // child: Row(
                    //   children: <Widget>[
                    //     SizedBox(width: 10),
                    // child: Center(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        //margin: EdgeInsets.only(left: 10, right: 10),
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width - 20,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: (x != null || x != "")
                            ? Stack(
                                children: <Widget>[
                                  StreamBuilder<QuerySnapshot>(
                                    stream: _db
                                        .collection('items')
                                        .where('stockBarcode', isEqualTo: x)
                                        .snapshots(),
                                    builder: (context, snapshots) {
                                      if (!snapshots.hasData) {
                                        return Center(
                                          child: Text("Item not found..."),
                                        );
                                      } else {
                                        return new ListView.builder(
                                          itemCount: snapshots.data.docs.length,
                                          itemBuilder: (context, index) {
                                            var brand = snapshots
                                                .data.docs[index]['brandId'];
                                            var name = snapshots
                                                .data.docs[index]['name'];
                                            dynamic srp = snapshots
                                                .data.docs[index]['stockSRP'];
                                            var color = snapshots
                                                .data.docs[index]['color'];
                                            var material = snapshots
                                                .data.docs[index]['material'];
                                            var measure = snapshots
                                                .data.docs[index]['measure'];
                                            var productId = snapshots
                                                .data.docs[index]['productId'];
                                            var unit = snapshots
                                                .data.docs[index]['stockUnit'];
                                            var stocks = snapshots
                                                .data.docs[index]['stocks'];
                                            var stockDesc = snapshots
                                                .data.docs[index]['stockDesc'];
                                            var barcode = snapshots.data
                                                .docs[index]['stockBarcode'];
                                            var binderId = snapshots
                                                .data.docs[index]['binderId'];

                                            return new Container(
                                              margin: new EdgeInsets.all(5.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white),
                                              child: new ListTile(
                                                title: new FittedBox(
                                                  child: new Text(
                                                      "[ ${brand.toString().toUpperCase()} ] ${name.toString().toUpperCase()} \n${color.toString().toUpperCase()} | ${material.toString().toUpperCase()} ${measure.toString().toUpperCase()}"),
                                                ),
                                                subtitle: (stockDesc ==
                                                        "retail")
                                                    ? new Text(
                                                        "Retail Price: ${(srp.toStringAsFixed(2)).toString()} \nStocks: ${stocks.toString()}")
                                                    : new Text(
                                                        "Wholesale Price: ${(srp.toStringAsFixed(2)).toString()} \nStocks: ${stocks.toString()}"),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        new Text("Units",
                                                            style: TextStyle(
                                                                fontSize: 10)),
                                                        new SizedBox(
                                                            height: 10),
                                                        new GestureDetector(
                                                            child:
                                                                new Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 3,
                                                                      bottom:
                                                                          3),
                                                              decoration: BoxDecoration(
                                                                  border: Border
                                                                      .all(),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: (stockDesc ==
                                                                      "retail")
                                                                  ? Text(_runits
                                                                      .toString())
                                                                  : Text(_wunits
                                                                      .toString()),
                                                            ),
                                                            onTap: () async {
                                                              setState(() {
                                                                curStocks = stocks =
                                                                    snapshots
                                                                            .data
                                                                            .docs[index]
                                                                        [
                                                                        'stocks'];
                                                              });
                                                              (stockDesc ==
                                                                      "retail")
                                                                  ? _addRUnit()
                                                                  : _addWUnit();
                                                            }),
                                                      ],
                                                    ),
                                                    SizedBox(width: 10),
                                                    Column(
                                                      children: <Widget>[
                                                        new Text("Discount",
                                                            style: TextStyle(
                                                                fontSize: 10)),
                                                        new SizedBox(
                                                            height: 10),
                                                        new GestureDetector(
                                                          child: new Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3),
                                                            decoration: BoxDecoration(
                                                                border: Border
                                                                    .all(),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: (stockDesc ==
                                                                    "retail")
                                                                ? Text(_rdiscount
                                                                        .toString() +
                                                                    " %")
                                                                : Text(_wdiscount
                                                                        .toString() +
                                                                    " %"),
                                                          ),
                                                          onTap: (stockDesc ==
                                                                  "retail")
                                                              ? _addRDiscount
                                                              : _addWDiscount,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 10),
                                                    Column(
                                                      children: <Widget>[
                                                        new Text(
                                                            "Total \nPrice",
                                                            style: TextStyle(
                                                                fontSize: 10)),
                                                        new SizedBox(height: 7),
                                                        (stockDesc == "retail")
                                                            ? new FittedBox(
                                                                child: new Text(
                                                                  ((((srp - (srp * (_rdiscount / 100))) *
                                                                              _runits))
                                                                          .toStringAsFixed(
                                                                              2))
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              )
                                                            : new FittedBox(
                                                                child: new Text(
                                                                  ((((srp - (srp * (_wdiscount / 100))) *
                                                                              _wunits))
                                                                          .toStringAsFixed(
                                                                              2))
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 10),
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons
                                                            .add_shopping_cart_outlined,
                                                        color: Colors.green,
                                                        size: 32,
                                                      ),
                                                      onPressed: () async {
                                                        var checkBarcode =
                                                            await dupCheck(
                                                                orderNo
                                                                    .toString(),
                                                                'stockBarcode',
                                                                x.toString());
                                                        setState(
                                                          () {
                                                            sbrand = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                ['brandId'];
                                                            sname = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                ['name'];
                                                            ssrp = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                ['stockSRP'];
                                                            scolor = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                ['color'];
                                                            smaterial = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                ['material'];
                                                            smeasure = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                ['measure'];
                                                            sproductId = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                ['productId'];
                                                            sunit = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                ['stockUnit'];
                                                            sstocks = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                ['stocks'];
                                                            sstockDesc = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                ['stockDesc'];
                                                            sbarcode = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                [
                                                                'stockBarcode'];
                                                            sbinderId = snapshots
                                                                    .data
                                                                    .docs[index]
                                                                ['binderId'];
                                                            cartProvider
                                                                .changeTransId(
                                                                    orderNo);
                                                            cartProvider
                                                                .changeProductId(
                                                                    productId);
                                                            cartProvider
                                                                .changeProduct(
                                                                    "[ ${brand.toString().toUpperCase()} ] ${name.toString().toUpperCase()} \n${color.toString().toUpperCase()} | ${material.toString().toUpperCase()} ${measure.toString().toUpperCase()}");
                                                            cartProvider
                                                                .changeBinderId(
                                                                    binderId);
                                                            cartProvider
                                                                .changeBarcode(
                                                                    barcode);
                                                            cartProvider
                                                                .changeUnit(
                                                                    unit);
                                                            cartProvider
                                                                .changeOldStocks(
                                                                    stocks
                                                                        .toInt());
                                                            cartProvider.changeNewStocks(
                                                                (stockDesc ==
                                                                        "retail")
                                                                    ? stocks -
                                                                        _runits
                                                                            .toInt()
                                                                    : stocks -
                                                                        _wunits
                                                                            .toInt());
                                                            cartProvider.changeUnits(
                                                                (stockDesc ==
                                                                        "retail")
                                                                    ? _runits
                                                                        .toInt()
                                                                    : _wunits
                                                                        .toInt());
                                                            cartProvider
                                                                .changeSRP(srp
                                                                    .toDouble());
                                                            if (_rdiscount ==
                                                                    0 ||
                                                                _wdiscount ==
                                                                    0) {
                                                              cartProvider
                                                                  .changeDiscount(
                                                                      0.00);
                                                            } else {
                                                              cartProvider.changeDiscount((stockDesc ==
                                                                      "retail")
                                                                  ? _rdiscount
                                                                      .toDouble()
                                                                  : _wdiscount
                                                                      .toDouble());
                                                            }
                                                            cartProvider.changeTotalPrice(
                                                                (stockDesc ==
                                                                        "retail")
                                                                    ? (((srp -
                                                                            (srp *
                                                                                (_rdiscount /
                                                                                    100))) *
                                                                        _runits))
                                                                    : (((srp -
                                                                            (srp *
                                                                                (_wdiscount / 100))) *
                                                                        _wunits)));
                                                            cartProvider
                                                                .changeTransDate(
                                                                    now.toString());
                                                            stocksProvider
                                                                .changeProductId(
                                                                    productId
                                                                        .toString());
                                                            stocksProvider
                                                                .changeUserId(uid
                                                                    .toString());
                                                            stocksProvider
                                                                .changeTransaction(
                                                                    'sale');
                                                            stocksProvider
                                                                .changeTransId(
                                                                    transId
                                                                        .toString());
                                                            stocksProvider
                                                                .changeBinderId(
                                                                    binderId
                                                                        .toString());
                                                            stocksProvider
                                                                .changeBarcode(
                                                                    barcode
                                                                        .toString());
                                                            stocksProvider
                                                                .changeUnit(unit
                                                                    .toString());
                                                            stocksProvider
                                                                .changeCurrentStocks(
                                                                    stocks
                                                                        .toInt());
                                                            stocksProvider.changeNewStocks(
                                                                (stockDesc ==
                                                                        "retail")
                                                                    ? stocks -
                                                                        _runits
                                                                            .toInt()
                                                                    : stocks -
                                                                        _wunits
                                                                            .toInt());
                                                            stocksProvider
                                                                .changelogDate(
                                                                    DateTime.now()
                                                                        .toString());

                                                            x = "";
                                                            if (!checkBarcode) {
                                                              // transProvider
                                                              //     .changeTransId(
                                                              //         transId);
                                                              // transProvider
                                                              //     .changeTotalItems(
                                                              //         _totalItems +
                                                              //             1);
                                                              // transProvider
                                                              //     .saveProductTrans();
                                                              // cartProvider
                                                              //     .saveCart();
                                                              _db
                                                                  .collection(
                                                                      'items')
                                                                  .doc(
                                                                      productId)
                                                                  .update({
                                                                "stocks": (stockDesc ==
                                                                        "retail")
                                                                    ? stocks -
                                                                        _runits
                                                                            .toInt()
                                                                    : stocks -
                                                                        _wunits
                                                                            .toInt(),
                                                              });
                                                              // _db
                                                              //     .collection(
                                                              //         'transx')
                                                              //     .doc(
                                                              //         orderNo)
                                                              //     .update({
                                                              //   "totalItems":
                                                              //       _totalItems +=
                                                              //           1,
                                                              // });
                                                              // productProvider
                                                              //     .changeProductId(
                                                              //         productId
                                                              //             .toString());
                                                              // productProvider.changeStocks((stockDesc ==
                                                              //         "retail")
                                                              //     ? curStocks -
                                                              //         _runits
                                                              //             .toInt()
                                                              //     : curStocks -
                                                              //         _wunits
                                                              //             .toInt());
                                                              // productProvider
                                                              //     .saveProduct();
                                                              stocksProvider
                                                                  .saveStocksLog();
                                                              cartProvider
                                                                  .saveCart();
                                                              _totalItems += 1;
                                                              _runits = 1;
                                                              _wunits = 1;
                                                              _rdiscount = 0;
                                                              _wdiscount = 0;
                                                              print("Total number of items: " +
                                                                  _totalItems
                                                                      .toString());

                                                              scanBarcodeNormal();
                                                            }
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                _qrInfo,
                              )),
                      ),
                    ],
                    //)
                    //   ],
                    // ),
                  )
                // : SizedBox(
                //     height: 0,
                //   ),
                : inputTextFieldWithSuffixButton(
                    label: 'Search Order Number',
                    width: MediaQuery.of(context).size.width - 40,
                    controller: _searchBarcode,
                    iconbutton: IconButton(
                      icon: Icon(Icons.qr_code_scanner),
                      onPressed: () async => scanQR(),
                    ),
                    onChange: (value) {
                      setState(
                        () {
                          _barcode = value.toString().toUpperCase();
                        },
                      );
                    },
                  ),
            Container(
              padding: EdgeInsets.all(20),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      StreamBuilder<QuerySnapshot>(
                          stream: (_barcode == 'in-progress' ||
                                  _barcode == null ||
                                  _barcode == "")
                              ? _db
                                  .collection('transx')
                                  .doc(orderNo)
                                  .collection('cart')
                                  .snapshots()
                              : _db
                                  .collection('transx')
                                  .doc(orderNo)
                                  .collection('cart')
                                  .where('barcode',
                                      isEqualTo: _barcode.toString())
                                  .snapshots(),
                          builder: (context, snapshots) {
                            var len = snapshots.data.docs.length;

                            // setState(() {
                            //   _totalItems = len;
                            // });
                            sales(len) {
                              totalSales = 0.00;
                              snapshots.data.docs.forEach((element) {
                                totalSales += element['totalPrice'];
                              });

                              // setState(() {
                              transProvider.changeTotalItems(len.toInt());
                              transProvider.changeTotalPrice(totalSales);

                              // });
                              // trans(len, totalSales);

                              return totalSales;
                            }

                            // items() {
                            //   var len = snapshots.data.docs.length;
                            //   return len;
                            // }

                            if (!snapshots.hasData) {
                              return Center(
                                child: Text('Cart empty...'),
                              );
                            } else {
                              return new Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("Date: "),
                                      Text(
                                        now.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text("Order No: "),
                                      Text(
                                        orderNo,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text("Total Items: "),
                                      Text(
                                        len.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text("Total Amount: ₱ "),
                                      Text(
                                        (widget.status == 'completed')
                                            ? widget.xprice.toString()
                                            : sales(len).toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.8,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      itemCount: len,
                                      itemBuilder: (context, index) {
                                        // setState(() {
                                        //   totalSales += transactions[index].totalPrice;
                                        // });
                                        //sales(transactions.length);
                                        return new Container(
                                          margin:
                                              new EdgeInsets.only(bottom: 7.5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white),
                                          child: new ListTile(
                                            leading: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: 5),
                                              child: Text(
                                                  (index + 1).toString(),
                                                  textAlign: TextAlign.center),
                                            ),
                                            title: new Text(
                                                snapshots.data.docs[index]
                                                        ['product'] +
                                                    "\nTotal Price: ₱ " +
                                                    snapshots
                                                        .data
                                                        .docs[index]
                                                            ['totalPrice']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            subtitle:
                                                (snapshots.data.docs[index]
                                                                ['remark'] ==
                                                            null ||
                                                        snapshots.data
                                                                    .docs[index]
                                                                ['remark'] ==
                                                            "")
                                                    ? new Text(
                                                        "Total Units: " +
                                                            snapshots
                                                                .data
                                                                .docs[index]
                                                                    ['units']
                                                                .toString() +
                                                            "       SRP: ₱ " +
                                                            snapshots
                                                                .data
                                                                .docs[index]
                                                                    ['srp']
                                                                .toString() +
                                                            "       Discount: " +
                                                            discount(
                                                                    snapshots
                                                                            .data
                                                                            .docs[index]
                                                                        ['srp'],
                                                                    snapshots
                                                                            .data
                                                                            .docs[index]
                                                                        [
                                                                        'units'],
                                                                    snapshots
                                                                            .data
                                                                            .docs[index]
                                                                        [
                                                                        'totalPrice'])
                                                                .toString() +
                                                            // snapshots.data
                                                            //     .docs[index]['discount']
                                                            //     .toString() +
                                                            " %",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      )
                                                    : new Text(
                                                        "Total Units: " +
                                                            snapshots
                                                                .data
                                                                .docs[index]
                                                                    ['units']
                                                                .toString() +
                                                            "       SRP: ₱ " +
                                                            snapshots
                                                                .data
                                                                .docs[index]
                                                                    ['srp']
                                                                .toString() +
                                                            "       Discount: " +
                                                            discount(
                                                                    snapshots
                                                                            .data
                                                                            .docs[index]
                                                                        ['srp'],
                                                                    snapshots
                                                                            .data
                                                                            .docs[index][
                                                                        'units'],
                                                                    snapshots
                                                                            .data
                                                                            .docs[index][
                                                                        'totalPrice'])
                                                                .toString() +
                                                            // snapshots.data
                                                            //     .docs[index]['discount']
                                                            //     .toString() +
                                                            " %\nReturn/Refund Date: " +
                                                            snapshots.data
                                                                    .docs[index]
                                                                ['remarkDate'],
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                            // ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                (widget.status == null ||
                                                        widget.status ==
                                                            'in-progress')
                                                    ? IconButton(
                                                        icon: Icon(
                                                          Icons.delete_outline,
                                                          color: Colors.red,
                                                          size: 25,
                                                        ),
                                                        onPressed: () async {
                                                          // asyncConfirmDeleteCartDialog(
                                                          //     context,
                                                          //     orderNo,
                                                          // snapshots.data
                                                          //             .docs[
                                                          //         index]
                                                          //     ['cartId']);
                                                          return showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                false, // user must tap button for close dialog!
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Delete This Product?'),
                                                                content: const Text(
                                                                    'This will delete the product from your cart.'),
                                                                actions: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                  FlatButton(
                                                                    child: const Text(
                                                                        'Delete'),
                                                                    onPressed:
                                                                        () async {
                                                                      await _db
                                                                          .collection(
                                                                              'items')
                                                                          .doc(snapshots
                                                                              .data
                                                                              .docs[index]['productId']
                                                                              .toString())
                                                                          .get()
                                                                          .then((value) => {
                                                                                _db.collection('items').doc(snapshots.data.docs[index]['productId'].toString()).update({
                                                                                  "stocks": snapshots.data.docs[index]['units'].toInt() + value.data()['stocks'],
                                                                                })
                                                                              });

                                                                      stocksProvider
                                                                          .changeProductId(
                                                                              sproductId.toString());
                                                                      stocksProvider
                                                                          .changeUserId(
                                                                              uid.toString());
                                                                      stocksProvider
                                                                          .changeTransaction(
                                                                              'revoked');
                                                                      stocksProvider
                                                                          .changeTransId(
                                                                              transId.toString());
                                                                      stocksProvider
                                                                          .changeBinderId(
                                                                              sbinderId.toString());
                                                                      stocksProvider.changeBarcode(snapshots
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                              [
                                                                              'barcode']
                                                                          .toString());
                                                                      stocksProvider
                                                                          .changeUnit(
                                                                              sunit.toString());
                                                                      stocksProvider.changeCurrentStocks(snapshots
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                              [
                                                                              'newStocks']
                                                                          .toInt());
                                                                      stocksProvider.changeNewStocks(snapshots
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                              [
                                                                              'oldStocks']
                                                                          .toInt());
                                                                      stocksProvider
                                                                          .changelogDate(
                                                                              now.toString());
                                                                      stocksProvider
                                                                          .saveStocksLog();
                                                                      // productProvider
                                                                      //     .changeProductId(
                                                                      //         sproductId
                                                                      //             .toString());
                                                                      // productProvider
                                                                      //     .changeStocks(snapshots
                                                                      //         .data
                                                                      //         .docs[
                                                                      //             index]
                                                                      //             [
                                                                      //             'currentStocks']
                                                                      //         .toInt());
                                                                      // });
                                                                      cartProvider.removeCart(
                                                                          snapshots
                                                                              .data
                                                                              .docs[index]['cartId'],
                                                                          orderNo);
                                                                      setState(
                                                                          () {
                                                                        _totalItems -=
                                                                            1;
                                                                        print("Total Items: " +
                                                                            _totalItems.toString());
                                                                      });

                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  )
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      )

                                                    //====================================== REFUND RETURN BUTTON =================================//
                                                    : (snapshots.data.docs[
                                                                        index][
                                                                    'remark'] ==
                                                                null ||
                                                            snapshots.data.docs[
                                                                        index][
                                                                    'remark'] ==
                                                                "")
                                                        ? IconButton(
                                                            icon: Icon(
                                                              Icons
                                                                  .refresh_outlined,
                                                              color:
                                                                  Colors.teal,
                                                              size: 25,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              // asyncConfirmDeleteCartDialog(
                                                              //     context,
                                                              //     orderNo,
                                                              // snapshots.data
                                                              //             .docs[
                                                              //         index]
                                                              //     ['cartId']);
                                                              return showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    false, // user must tap button for close dialog!
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Return/Refund This Product?'),
                                                                    content:
                                                                        const Text(
                                                                            'This will mark the product as returned on your cart transaction.'),
                                                                    actions: <
                                                                        Widget>[
                                                                      FlatButton(
                                                                        child: const Text(
                                                                            'Cancel'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                      FlatButton(
                                                                        child: const Text(
                                                                            'Continue Return/Refund'),
                                                                        onPressed:
                                                                            () async {
                                                                          await _db
                                                                              .collection('items')
                                                                              .doc(snapshots.data.docs[index]['productId'].toString())
                                                                              .get()
                                                                              .then((value) => {
                                                                                    _db.collection('items').doc(snapshots.data.docs[index]['productId'].toString()).update({
                                                                                      "stocks": snapshots.data.docs[index]['units'].toInt() + value.data()['stocks'],
                                                                                    }),
                                                                                    stocksProvider.changeCurrentStocks(value.data()['stocks'].toInt()),
                                                                                    stocksProvider.changeNewStocks(snapshots.data.docs[index]['units'].toInt() + value.data()['stocks'].toInt()),
                                                                                    stocksProvider.changeProductId(sproductId.toString()),
                                                                                    stocksProvider.changeUserId(uid.toString()),
                                                                                    stocksProvider.changeTransaction('return/refund'),
                                                                                    stocksProvider.changeTransId(transId.toString()),
                                                                                    stocksProvider.changeBinderId(sbinderId.toString()),
                                                                                    stocksProvider.changeBarcode(snapshots.data.docs[index]['barcode'].toString()),
                                                                                    stocksProvider.changeUnit(sunit.toString()),
                                                                                    stocksProvider.changeCurrentStocks(snapshots.data.docs[index]['newStocks'].toInt()),
                                                                                    stocksProvider.changeNewStocks(snapshots.data.docs[index]['oldStocks'].toInt()),
                                                                                    stocksProvider.changelogDate(now.toString()),
                                                                                    stocksProvider.saveStocksLog(),
                                                                                  });
                                                                          await _db
                                                                              .collection('transx')
                                                                              .doc(orderNo)
                                                                              .get()
                                                                              .then((value) => {
                                                                                    _db.collection('transx').doc(orderNo).update({
                                                                                      "totalPrice": value.data()['totalPrice'] - snapshots.data.docs[index]['totalPrice'].toDouble(),
                                                                                      "remarks": 'with return/refund'
                                                                                    }),
                                                                                    // transProvider.changeTransId(widget.trans.toString()),
                                                                                    // transProvider.changeTotalPrice(value.data()['totalPrice'] - snapshots.data.docs[index]['totalPrice'].toDouble()),
                                                                                    // transProvider.saveProductTrans(),
                                                                                  });
                                                                          await _db
                                                                              .collection('transx')
                                                                              .doc(orderNo)
                                                                              .collection('cart')
                                                                              .doc(snapshots.data.docs[index]['cartId'].toString())
                                                                              .update({
                                                                            "remark":
                                                                                'return/refund',
                                                                            "remarkBy":
                                                                                uid.toString(),
                                                                            "remarkDate":
                                                                                DateTime.now().toString(),
                                                                          });

                                                                          // setState(
                                                                          //     () {
                                                                          //   _totalItems -=
                                                                          //       1;
                                                                          //   print("Total Items: " +
                                                                          //       _totalItems.toString());
                                                                          // });

                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      )
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )
                                                        : SizedBox(
                                                            width: 0,
                                                          ),
                                                // : SizedBox(
                                                //     width: 0,
                                                //   ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                      // Row(
                      //   children: <Widget>[
                      //     Text("Date: "),
                      //     Text(
                      //       now.toString(),
                      //       style: TextStyle(fontWeight: FontWeight.w700),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: <Widget>[
                      //     Text("Order No: "),
                      //     Text(
                      //       orderNo,
                      //       style: TextStyle(fontWeight: FontWeight.w700),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: <Widget>[
                      //     Text("Total Items: "),
                      //     Text(
                      //       "## | " + totalItems().toString(),
                      //       style: TextStyle(fontWeight: FontWeight.w700),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: <Widget>[
                      //     Text("Total Price: "),
                      //     Text(
                      //       "##",
                      //       style: TextStyle(fontWeight: FontWeight.w700),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: (widget.status == null ||
              widget.status == 'in-progress')
          ? StreamBuilder<QuerySnapshot>(
              stream: _db
                  .collection('transx')
                  .doc(orderNo)
                  .collection('cart')
                  .snapshots(),
              builder: (context, snapshots) {
                var len = snapshots.data.docs.length;
                // setState(() {
                //   _totalItems = len;
                // });
                sales(len) {
                  totalSales = 0.00;
                  snapshots.data.docs.forEach((element) {
                    totalSales += element['totalPrice'];
                  });

                  // setState(() {
                  // transProvider.changeTotalItems(len.toInt());
                  // transProvider.changeTotalPrice(totalSales);

                  // });
                  // trans(len, totalSales);

                  return totalSales;
                }

                if (snapshots.hasData) {
                  if (snapshots.data.docs.isEmpty) {
                    return FloatingActionButton.extended(
                      onPressed: () {
                        showDialog<int>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Alert!"),
                                content: Text(
                                    "Are you sure you want to delete transaction #: ${orderNo.toString()}?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      transProvider.removeTrans(orderNo);

                                      Navigator.pushReplacementNamed(
                                          context, Routes.viewtrans);
                                    },
                                  ),
                                ],
                              );
                            });
                        // Navigator.pushReplacementNamed(
                        //     context, Routes.viewtrans);
                      },
                      icon: Icon(Icons.delete_forever_outlined),
                      label: Text("DELETE TRANSACTION"),
                      backgroundColor: Colors.red,
                    );
                  }
                  return FloatingActionButton.extended(
                    onPressed: () {
                      transProvider.changeTransId(orderNo);
                      // transProvider.changeOrderNo(orderNo);
                      transProvider.changeUserId(uid);
                      transProvider.changeTransDate(now.toString());
                      transProvider.changeTotalItems(len.toInt());
                      transProvider.changeTotalPrice((sales(len)).toDouble());
                      transProvider.changeProductTrans("sales");
                      transProvider.changeStatus("completed");
                      transProvider.saveProductTrans();

                      Navigator.pushReplacementNamed(context, Routes.viewtrans);
                    },
                    icon: Icon(Icons.payment_outlined),
                    label: Text("CHECKOUT"),
                  );
                } else {}
              })
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.dashboard);
              },
              tooltip: 'Home',
              child: Container(
                child: Icon(Icons.home_outlined),
              ),
            ),
    );
  }

  Future<bool> dupCheck(String transId, String field, String value) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final result = await _db
        .collection('trans')
        .doc(transId)
        .collection('cart')
        .where(field, isEqualTo: value)
        .get();

    if (result.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  discount(double srp, int unit, double total) {
    double discount = (((srp) - (total / unit)) / srp) * 100;
    return discount;
  }
}
