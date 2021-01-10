import 'package:Register/methods/addPhotos.dart';
import 'package:Register/models/brand.dart';
import 'package:Register/models/category.dart';
import 'package:Register/models/product.dart';
import 'package:Register/provider/product_photo_provider.dart';
import 'package:Register/provider/product_provider.dart';
import 'package:Register/widgets/forms/form.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'package:images_picker/images_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
//import 'dart:io';

import 'dart:async';

//import 'package:flutter/services.dart';

class EditProduct extends StatefulWidget {
  final Product product;

  EditProduct([this.product]);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  //FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController productname = TextEditingController();
  //final TextEditingController productitem = TextEditingController();
  final TextEditingController productserial = TextEditingController();
  final TextEditingController productmodel = TextEditingController();
  final TextEditingController productdesc = TextEditingController();
  final TextEditingController productsku = TextEditingController();
  final TextEditingController productcolor = TextEditingController();
  final TextEditingController productmaterial = TextEditingController();
  final TextEditingController productmeasure = TextEditingController();
  final TextEditingController producttags = TextEditingController();
  final TextEditingController productstockunit = TextEditingController();
  final TextEditingController productstockdesc = TextEditingController();
  final TextEditingController productstocks = TextEditingController();
  final TextEditingController productpurchaseprice = TextEditingController();
  final TextEditingController productsrp = TextEditingController();
  final TextEditingController productbarcode = TextEditingController();

  String _category;
  String _brand;
  String binderId;
  String str;
  String _err;
  bool _isSuccess = false;

  var path = [];
  List<Asset> images = List<Asset>();
  List paths;
  var binder = Uuid();
  var now = new DateTime.now();
  var catvalue;
  var bvalue;

  getId(String str) {
    var arr = str.split('-');
    int i = arr.length;
    return arr[i - 1];
  }

  void initState() {
    str = binder.v4().toString();
    _err = "";

    //binderId = getId(str);
    if (widget.product == null) {
      // _category = "";
      // _brand = "";
      binderId = getId(str);
      productname.text = "";
      productdesc.text = "";
      //productitem.text = "";
      productserial.text = "";
      productmodel.text = "";
      productsku.text = "";
      productcolor.text = "";
      productmaterial.text = "";
      productmeasure.text = "";
      producttags.text = "";
      productstockunit.text = "";
      productstockdesc.text = "";
      productstocks.text = "0";
      productpurchaseprice.text = "0";
      productsrp.text = "0";
      productbarcode.text = "";

      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(Product());
      });
    } else {
      catvalue = widget.product.categoryId.toString();
      bvalue = widget.product.brandId.toString();
      binderId = widget.product.binderId;
      productname.text = widget.product.name;
      productdesc.text = widget.product.desc;
      //productitem.text = widget.product.item;
      productserial.text = widget.product.serial;
      productmodel.text = widget.product.model;
      productsku.text = widget.product.sku;
      productcolor.text = widget.product.color;
      productmaterial.text = widget.product.material;
      productmeasure.text = widget.product.measure;
      producttags.text = widget.product.tags;
      productstockunit.text = widget.product.stockUnit;
      productstockdesc.text = widget.product.stockDesc;
      productstocks.text = widget.product.stocks.toString();
      productpurchaseprice.text = widget.product.stockPurchasePrice.toString();
      productsrp.text = widget.product.stockSRP.toString();
      productbarcode.text = widget.product.stockBarcode.toString();

      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(widget.product);
      });
    }

    super.initState();
  }

  void dispose() {
    productname.dispose();
    super.dispose();
  }

  void newText(String value) {
    setState(() {
      //_text = value;
    });
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  //get catnames => null;
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context);
    final brands = Provider.of<List<Brand>>(context);
    // final products = Provider.of<List<Product>>(context);

    final productProvider = Provider.of<ProductProvider>(context);
    //final photoProvider = Provider.of<ProductPhotoProvider>(context);

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
        productbarcode.text = barcodeScanRes;
        productProvider.changeStockBarcode(barcodeScanRes);
      });
    }

    List<DropdownMenuItem> catnames() {
      List<DropdownMenuItem> catnames = [];
      for (int i = 0; i < categories.length; i++) {
        String catname = categories[i].name;
        catnames.add(DropdownMenuItem(
          child: Text(
            catname,
            style: TextStyle(),
          ),
          value: "$catname",
        ));
      }
      return catnames;
    }

    List<DropdownMenuItem> bnames() {
      List<DropdownMenuItem> bnames = [];
      for (int i = 0; i < brands.length; i++) {
        String bname = brands[i].brand;
        bnames.add(DropdownMenuItem(
          child: Text(
            bname,
            style: TextStyle(),
          ),
          value: "$bname",
        ));
      }
      return bnames;
    }

    List<dynamic> netImages() {
      List imgs = [];
      for (int i = 0; i < path.length; i++) {
        imgs.add(NetworkImage(path[i]));
      }
      return imgs;
    }
    //ListItem _selectedItem;

    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: ListView(
        children: <Widget>[
//*******************CATEGORY SELECTION****************/
          formHeader(text: 'Product Identification'),
          Center(
            child: Text(
              binderId,
              style: TextStyle(color: Colors.teal[700]),
            ),
          ),

          SizedBox(
            height: 7,
          ),
          Row(
            // mainAxisAlignment:
            //     MainAxisAlignment.center, //Center Row contents horizontally,
            // crossAxisAlignment:
            //     CrossAxisAlignment.center, //Center Row contents vertically,
            children: <Widget>[
              formLabel(text: 'Category '),
              Container(
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Colors.grey[500],
                      width: 1,
                      style: BorderStyle.solid),
                ),
                width: MediaQuery.of(context).size.width - 170,
                child: DropdownButton(
                  items: catnames(),
                  onChanged: (catvalue) {
                    productProvider
                        .changeCategory(catvalue.toString().toLowerCase());
                    final snackbar = SnackBar(
                        content: Text(
                      catvalue,
                      style: TextStyle(color: Colors.teal[700]),
                    ));
                    //ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    setState(() {
                      _category = catvalue;
                    });
                  },
                  value: _category,
                  underline: Container(),
                  isExpanded: true,
                  hint: new Text(
                    (widget.product != null)
                        ? widget.product.categoryId.toString()
                        : 'Choose Category',
                    //'Choose Category',
                    style: TextStyle(color: Colors.teal[700]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
//*******************BRAND SELECTION****************/
          Row(
            children: <Widget>[
              formLabel(text: 'Brand '),
              Container(
                padding: EdgeInsets.only(left: 5),
                width: MediaQuery.of(context).size.width - 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Colors.grey[500],
                        width: 1,
                        style: BorderStyle.solid)),
                child: DropdownButton(
                  items: bnames(),
                  onChanged: (bvalue) {
                    productProvider
                        .changeBrand(bvalue.toString().toLowerCase());
                    final snackbar = SnackBar(
                        content: Text(
                      bvalue,
                      style: TextStyle(color: Colors.teal[700]),
                    ));
                    // ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    setState(() {
                      _brand = bvalue;
                    });
                  },
                  value: _brand,
                  underline: Container(),
                  isExpanded: true,
                  hint: new Text(
                    (widget.product != null)
                        ? widget.product.brandId.toString()
                        : 'Choose Brand ',
                    //'Choose Brand ',
                    style: TextStyle(color: Colors.teal[700]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Product Name '),
              inputTextField(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productname,
                  hint: 'Product Name',
                  onChange: (value) {
                    productProvider.changeName(value.toString().toLowerCase());
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Product Model '),
              inputTextField(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productmodel,
                  hint: 'Product Model',
                  onChange: (value) {
                    productProvider.changeModel(value.toString().toLowerCase());
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Product Serial '),
              inputTextField(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productserial,
                  hint: 'Product Serial',
                  onChange: (value) {
                    productProvider
                        .changeSerial(value.toString().toLowerCase());
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Description '),
              inputTextArea(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productdesc,
                  hint: 'Product Description',
                  onChange: (value) {
                    productProvider.changeDesc(value.toString().toLowerCase());
                  }),
            ],
          ),
          Divider(),
//************************ PRODUCT VARIANT *********************///
          formHeader(text: 'Product Variant Specifics'),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'SKU '),
              inputTextArea(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productsku,
                  hint: 'Stock Keeping Unit',
                  onChange: (value) {
                    productProvider.changeSku(value.toString().toLowerCase());
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Color '),
              inputTextArea(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productcolor,
                  hint: 'Product Color',
                  onChange: (value) {
                    productProvider.changeColor(value.toString().toLowerCase());
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Measure '),
              inputTextArea(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productmeasure,
                  hint: 'Product Measurement like size, volume or weight',
                  onChange: (value) {
                    productProvider
                        .changeMeasure(value.toString().toLowerCase());
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Material '),
              inputTextArea(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productmaterial,
                  hint: 'Product Materials like metal, alloy, fabric, etc',
                  onChange: (value) {
                    productProvider
                        .changeMaterial(value.toString().toLowerCase());
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Tags '),
              inputTextArea(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: producttags,
                  hint: 'Product Tags like bike, rough road, white pedal',
                  onChange: (value) {
                    productProvider.changeTags(value);
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
//********************** STOCKS AND PRICES *******************//
          Row(
            children: <Widget>[
              formLabel(text: 'Stock Unit'),
              inputTextField(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productstockunit,
                  hint: 'Write if pieces, boxex, bundles, etc',
                  onChange: (value) {
                    productProvider.changeStockUnit(value);
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Unit Description '),
              inputTextArea(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productstockdesc,
                  hint: 'Description of the Stock Unit',
                  onChange: (value) {
                    productProvider.changeStockDesc(value);
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Stocks'),
              inputIntField(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productstocks,
                  hint: 'Number of stocks',
                  onChange: (value) {
                    productProvider.changeStocks(int.parse(value));
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Purchase Price'),
              inputIntField(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productpurchaseprice,
                  hint: 'Purchase Price',
                  onChange: (value) {
                    productProvider
                        .changeStockPurchasePrice(double.parse(value));
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'SRP'),
              inputIntField(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: productsrp,
                  hint: 'SRP',
                  onChange: (value) {
                    productProvider.changeStockSRP(double.parse(value));
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Barcode'),
              inputTextFieldWithSuffixButton(
                width: MediaQuery.of(context).size.width - 170,
                controller: productbarcode,
                hint: 'Input Barcode here',
                onChange: (value) {
                  productProvider.changeStockBarcode(value);
                },
                iconbutton: IconButton(
                  icon: Icon(Icons.qr_code_scanner),
                  onPressed: () => scanBarcodeNormal(),
                ),
              ),
            ],
          ),

          (_isSuccess)
              ? (path.isNotEmpty)
                  ? SizedBox(
                      height: 200,
                      width: 300,
                      child: Carousel(
                        images: netImages(),
                        autoplay: false,
                        dotSize: 4.0,
                        dotSpacing: 15.0,
                        dotColor: Colors.white,
                        indicatorBgPadding: 5.0,
                        dotBgColor: Colors.black12.withOpacity(0.7),
                        boxFit: BoxFit.contain,
                        borderRadius: true,
                      ),
                    )
                  : Center(
                      child: Text(_err,
                          style: TextStyle(
                            color: Colors.green,
                          )))
              : (_err != null)
                  ? Center(
                      child: Text(_err, style: TextStyle(color: Colors.red)))
                  : SizedBox(height: 5),
          Divider(),
          formButton(
              text: 'Add Product Photos',
              onPressed: () async {
                if (productname.text != "") {
                  // var dupname =
                  //     await dupCheck('name', productname.text.toLowerCase());
                  // if (dupname) {
                  //   //error statement here
                  //   setState(() {
                  //     _isSuccess = false;
                  //     _err =
                  //         "Product already exist please use different name and try again.";
                  //   });
                  // } else {
                  uploadImages(binderId);
                  print(path);
                  setState(() {
                    _isSuccess = true;
                    _err = "saving...";
                  });
                  // }
                } else {
                  setState(() {
                    _isSuccess = false;
                    _err = "Please enter Product name first";
                  });
                }
              },
              color: Colors.blue[600]),
          SizedBox(
            height: 7,
          ),
          formButton(
              text: 'Add New Variant',
              onPressed: () async {
                if (productname.text == "" || _category == "" || _brand == "") {
                  setState(() {
                    _isSuccess = false;
                    _err = "Please enter Product name first";
                  });
                } else {
                  var dupMaterial = await dupCheck('material',
                      productmaterial.text.toString().toLowerCase());
                  var dupColor = await dupCheck(
                      'color', productcolor.text.toString().toLowerCase());
                  var dupSize = await dupCheck(
                      'size', productmeasure.text.toString().toLowerCase());
                  var dupName = await dupCheck(
                      'name', productname.text.toString().toLowerCase());

                  if (dupName) {
                    if (dupMaterial && dupColor && dupSize) {
                      setState(() {
                        _isSuccess = false;
                        _err =
                            "Product with the same variant already exist please use different product item and try again.";
                      });
                    }
                  }
                  if (widget.product != null) {
                    productProvider.loadValues(Product());
                    productProvider.changeCategory(
                        widget.product.categoryId.toString().toLowerCase());
                    productProvider.changeBrand(
                        widget.product.brandId.toString().toLowerCase());
                    productProvider.changeName(productname.text.toLowerCase());
                    //productProvider.changeItem(productitem.text.toLowerCase());
                    productProvider
                        .changeModel(productmodel.text.toLowerCase());
                    productProvider
                        .changeSerial(productserial.text.toLowerCase());
                    productProvider.changeDesc(productdesc.text.toLowerCase());
                    productProvider.changeSku(productsku.text.toLowerCase());
                    productProvider
                        .changeColor(productcolor.text.toLowerCase());
                    productProvider
                        .changeMaterial(productmaterial.text.toLowerCase());
                    productProvider
                        .changeMeasure(productmeasure.text.toLowerCase());
                    productProvider.changeTags(producttags.text.toLowerCase());
                    productProvider
                        .changeStockUnit(productstockunit.text.toLowerCase());
                    productProvider.changeStocks(int.parse(productstocks.text));
                    productProvider
                        .changeStockDesc(productstockdesc.text.toLowerCase());
                    productProvider.changeStockPurchasePrice(
                        double.parse(productpurchaseprice.text));
                    productProvider
                        .changeStockSRP(double.parse(productsrp.text));
                    productProvider
                        .changeStockBarcode(productbarcode.text.toLowerCase());
                    productProvider.changeDateAdded(now.toString());
                    productProvider.changeBinder(binderId);
                    productProvider.saveProduct();
                  } else {
                    productProvider.changeStocks(int.parse(productstocks.text));

                    productProvider.changeStockPurchasePrice(
                        double.parse(productpurchaseprice.text));
                    productProvider
                        .changeStockSRP(double.parse(productsrp.text));
                    productProvider.changeDateAdded(now.toString());
                    productProvider.changeBinder(binderId);
                    productProvider.saveProduct();
                  }
                  // productProvider.changeCategory(_category.toLowerCase());
                  // productProvider.changeBrand(_brand.toLowerCase());

                  setState(() {
                    _isSuccess = true;
                    _err = "Product variant successfully added!";

                    productsku.clear();
                    productmaterial.clear();
                    productmeasure.clear();
                    productcolor.clear();
                    // productstockunit.clear();
                    // productstockdesc.clear();
                    // productstocks.clear();
                    // productpurchaseprice.clear();
                    // productsrp.clear();
                    // productbarcode.clear();
                  });
                }
              },
              color: Colors.teal),
          SizedBox(
            height: 7,
          ),
          formButton(
              text: 'Save',
              onPressed: () async {
                if (productname.text == "" || _category == "" || _brand == "") {
                  setState(() {
                    _isSuccess = false;
                    _err = "Please enter Product name first";
                  });
                } else {
                  var dupMaterial = await dupCheck('material',
                      productmaterial.text.toString().toLowerCase());
                  var dupColor = await dupCheck(
                      'color', productcolor.text.toString().toLowerCase());
                  var dupSize = await dupCheck(
                      'size', productmeasure.text.toString().toLowerCase());
                  var dupName = await dupCheck(
                      'name', productname.text.toString().toLowerCase());

                  if (dupName) {
                    if (dupMaterial && dupColor && dupSize) {
                      setState(() {
                        _isSuccess = false;
                        _err =
                            "Product with the same variant already exist please use different product item and try again.";
                      });
                    }
                  }
                  if (widget.product != null) {
                    productProvider.changeDateModified(now.toString());
                    productProvider.changeBinder(binderId);
                    productProvider.saveProduct();
                  } else {
                    productProvider.changeStocks(int.parse(productstocks.text));

                    productProvider.changeStockPurchasePrice(
                        double.parse(productpurchaseprice.text));
                    productProvider
                        .changeStockSRP(double.parse(productsrp.text));
                    productProvider.changeDateAdded(now.toString());
                    productProvider.changeBinder(binderId);
                    productProvider.saveProduct();
                  }
                  // productProvider.changeCategory(_category.toLowerCase());
                  // productProvider.changeBrand(_brand.toLowerCase());

                  Navigator.of(context).pop();
                }
              },
              color: Colors.green),
          SizedBox(
            height: 7,
          ),
          formButton(
            text: 'Cancel',
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.grey,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<bool> dupCheck(String field, String value) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final result =
        await _db.collection('products').where(field, isEqualTo: value).get();

    if (result.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> uploadImages(binderId) async {
    final photoProvider =
        Provider.of<ProductPhotoProvider>(context, listen: false);
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    var now = new DateTime.now();
    //var uuid = Uuid();

    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      try {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 300,
          enableCamera: true,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#abcdef",
            actionBarTitle: "Example App",
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ),
        );
      } on Exception catch (e) {
        error = e.toString();
      }

      if (resultList != null) {
        setState(() {
          images = resultList;
        });
        for (var file in images) {
          print(file);
          postImages(file, binderId).then((downloadUrl) {
            setState(
              () {
                path.add(downloadUrl);
                photoProvider.changeUrl(downloadUrl);
                photoProvider.changeBindId(binderId);
                photoProvider.changeDateAdded(now.toString());
                photoProvider.saveProductPhoto();
                _isSuccess = true;

                print(downloadUrl);
              },
            );
          });
        }
      } else {
        print('No Path Received');
        setState(() {
          _isSuccess = false;
          _err = "Upload error, no path received";
        });
      }
    } else {
      print('Grant Permissions and try again');
      setState(() {
        _isSuccess = false;
        _err = "Permission error. Please grant permission and try again";
      });
    }
  }
}
