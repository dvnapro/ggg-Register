import 'package:Register/methods/addPhotos.dart';
import 'package:Register/methods/alertDeletePhoto.dart';
import 'package:Register/models/byField.dart';
import 'package:Register/provider/product_photo_provider.dart';
import 'package:Register/store/edit_byfield.dart';
import 'package:Register/widgets/forms/form.dart';
import 'package:Register/widgets/nav/drawer.dart';
import 'package:Register/widgets/nav/navbar.dart';
import 'package:Register/widgets/text/header.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tabbar/tabbar.dart';

class ViewProductByField extends StatefulWidget {
  final ProductByField product;

  static const String routeName = '/viewproduct';

  ViewProductByField([this.product]);
  //ViewProductByField({Key key, this.product}) : super(key: key);
  @override
  _ViewProductByFieldState createState() => _ViewProductByFieldState();
}

class _ViewProductByFieldState extends State<ViewProductByField> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final controller = PageController();
  //final TabController tabcontroller = TabController();
  var path = [];
  var photoId = [];
  String _err = "";
  bool _isSuccess = false;
  List<Asset> images = List<Asset>();

  void initState() {
    //tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  void url(binder) async {
    _db
        .collection("productphotos")
        .where('binderId', isEqualTo: binder)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if (path.length < querySnapshot.docs.length) {
          setState(() {
            path.add(result.data()['url']);
            photoId.add(result.data()['photoId']);
          });
        }
      });
    });
  }

  List<dynamic> netImages() {
    List imgs = [];

    if (path != null) {
      for (int i = 0; i < path.length; i++) {
        imgs.add(
          GestureDetector(
              // child: Image(
              //   image: NetworkImage(path[i]),
              //   fit: BoxFit.fill,
              // ),
              child: CachedNetworkImage(
                imageUrl: path[i],
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Colors.white, BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) => Container(
                    width: 30,
                    height: 30,
                    child: Center(child: CircularProgressIndicator())),
              ),
              onTap: () async {
                await asyncConfirmDialogPhoto(context, photoId[i]);
              }),
        );
      }
    } else {}

    print(path.toString() + " \n photoId : \n" + photoId.toString());
    return imgs;
  }

  void editProductByField() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProductByField(widget.product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    url(widget.product.binderId.toString());
    print("init path: " + path.length.toString());
    return Scaffold(
      appBar: NavBar(
        IconButton(icon: Icon(Icons.search), onPressed: () {}),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          pageHeader(
            text: " [ " +
                widget.product.brandId.toString().toUpperCase() +
                " ] " +
                widget.product.name.toString().toUpperCase(),
          ),
          Center(
            child: Text(
              widget.product.categoryId.toString().toUpperCase() + " | " // +
              //widget.product.item.toString().toUpperCase()
              ,
              style: TextStyle(color: Colors.teal),
            ),
          ),
          Expanded(
            child: Container(
              //padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //\\child: SubCategoriesList(widget.category)
              //child: ProductList(),
              child: Column(
                children: <Widget>[
                  Text(_err.toString(),
                      style: TextStyle(
                          color: (_isSuccess) ? Colors.green : Colors.red)),
                  SizedBox(
                    height: 350.0,
                    width: double.infinity,
                    child: (path.length > 0)
                        ? Carousel(
                            images: netImages(),
                            dotSize: 4.0,
                            dotSpacing: 15.0,
                            dotColor: Colors.lightGreenAccent,
                            indicatorBgPadding: 5.0,
                            dotBgColor: Colors.teal.withOpacity(0.5),
                            borderRadius: false,
                            moveIndicatorFromBottom: 180.0,
                            noRadiusForIndicator: true,
                            overlayShadow: true,
                            overlayShadowColors: Colors.white,
                            overlayShadowSize: 0.7,
                            autoplay: false,
                            boxFit: BoxFit.fill,
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ),
                  smallButton(
                      text: 'Add Product Photos',
                      onPressed: () async {
                        uploadImages(widget.product.binderId);
                        print(path);
                        setState(() {
                          _isSuccess = true;
                          _err = "saving...";
                        });
                      },
                      color: Colors.blue[600]),
                  SizedBox(
                    height: 7,
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: new DefaultTabController(
                        length: 3,
                        child: new Scaffold(
                          appBar: new PreferredSize(
                            preferredSize: Size.fromHeight(kToolbarHeight),
                            child: new Container(
                              color: Colors.teal,
                              child: new SafeArea(
                                child: Column(
                                  children: <Widget>[
                                    new Expanded(child: new Container()),
                                    new TabBar(
                                      tabs: [
                                        Tab(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("DESCRIPTION"),
                                          ),
                                        ),
                                        Tab(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("VARIANT"),
                                          ),
                                        ),
                                        Tab(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("STOCKS"),
                                          ),
                                        ),
                                      ],
                                      indicatorSize: TabBarIndicatorSize.label,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          body: new TabBarView(
                            children: <Widget>[
                              new Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                alignment: Alignment.centerLeft,
                                child: new Column(
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product Category'),
                                        Text(
                                            widget.product.categoryId
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product Brand'),
                                        Text(
                                            widget.product.brandId
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product Name'),
                                        Text(
                                            widget.product.name
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product Model'),
                                        Text(
                                            widget.product.model
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product Serial'),
                                        Text(
                                            widget.product.serial
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    formLabel2(text: "Product Description"),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        toBeginningOfSentenceCase(
                                            widget.product.desc.toString()),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              new Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                alignment: Alignment.centerLeft,
                                child: new Column(
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product SKU'),
                                        Text(
                                            widget.product.sku
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product Color'),
                                        Text(
                                            widget.product.color
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product Material'),
                                        Text(
                                            widget.product.material
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product Measure'),
                                        Text(
                                            widget.product.measure
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product Tags'),
                                        Text(
                                            widget.product.tags
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: BarcodeWidget(
                                        barcode: Barcode
                                            .code128(), // Barcode type and settings
                                        data: widget.product.stockBarcode
                                            .toString(), // Content
                                        width: 250,
                                        height: 150,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              new Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                alignment: Alignment.centerLeft,
                                child: new Column(
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product Stock Unit'),
                                        Text(
                                            widget.product.stockUnit
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(
                                            text: 'Stock Unit Description'),
                                        Text(
                                            widget.product.stockDesc
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Available Stocks'),
                                        Text(widget.product.stocks.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product SRP'),
                                        Text(
                                            "₱" +
                                                widget.product.stockSRP
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        formLabel2(text: 'Product Code'),
                                        Text(
                                            widget.product.stockBarcode
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: BarcodeWidget(
                                        barcode: Barcode.qrCode(
                                          errorCorrectLevel:
                                              BarcodeQRCorrectionLevel.high,
                                        ),
                                        // barcode: Barcode
                                        //     .code128(), // Barcode type and settings
                                        data: widget.product.stockBarcode
                                            .toString(), // Content
                                        width: 250,
                                        height: 150,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SingleChildScrollView(
          //   child: Column(
          //     children: <Widget>[
          //Text(widget.product.name.toUpperCase()),

          //     ],
          //   ),
          // ),
        ],
      ),
      drawer: Drawer(child: NavDrawer()),
      floatingActionButton: FloatingActionButton(
        onPressed: editProductByField,
        tooltip: 'Edit',
        child: Icon(Icons.edit),
      ),
    );
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
                _err = "Photo(s) saved successfully!";
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
