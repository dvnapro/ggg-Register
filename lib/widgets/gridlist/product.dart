import 'package:Register/methods/alertDelete.dart';
import 'package:Register/models/product.dart';
import 'package:Register/models/product_photos.dart';
import 'package:Register/screens/viewproduct.dart';

import 'package:Register/store/edit_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  int len = 0;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    final photos = Provider.of<List<ProductPhoto>>(context);
    //print(products[0].toString());
    //print("Length: " + len.toString());
    if (products != null) {
      setState(() {
        len = products.length;
      });
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: (products != null)
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: len,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                // print("Product Value " + products[index].name.toString());
                pbrandname(index) {
                  var pbrand = products[index].brandId;
                  var pname = products[index].name;
                  var brand;
                  var name;
                  if (pbrand != null || pbrand != '') {
                    brand = "[ " + pbrand.toString().toUpperCase() + " ]";
                  } else {
                    brand = "N/A";
                  }
                  if (pname != null || pname != '') {
                    name = pname.toString().toUpperCase();
                  } else {
                    name = "";
                  }
                  return brand + " " + name;
                }

                //print(pbrandname(index));
                pvariant(index) {
                  var pcolor = products[index].color;
                  var pmaterial = products[index].material;
                  var pmeasure = products[index].measure;
                  var color = "";
                  var material = "";
                  var measure = "";
                  if (pcolor != null) {
                    color = pcolor.toString().toUpperCase();
                  } else {
                    if (pcolor == "") {
                      color = "No Color";
                    }
                    color = "No Color";
                  }
                  if (pmaterial != null) {
                    material = " | " + pmaterial.toString().toUpperCase();
                  } else {
                    if (pmaterial == "") {
                      material = " | No Material";
                    }
                    material = " | No Material";
                  }
                  if (pmeasure != null) {
                    measure = " | " + pmeasure.toString().toUpperCase();
                  } else {
                    if (pmeasure == "") {
                      measure = " | No Measure";
                    }
                    measure = " | No Measure";
                  }
                  // if (pcolor == null && pmeasure == null && pmaterial == null ||
                  //     pcolor == "" && pmeasure == "" && pmaterial == "") {
                  //   return "( Color, material and measure not yet set )";
                  // }
                  return "( " + color + "" + material + "" + measure + " )";
                }

                //print(pvariant(index));
                pitemcategory(index) {
                  var pcategory = products[index].categoryId;
                  // var pitem = products[index].item;
                  var category = "";
                  //var item = "";
                  if (pcategory != null || pcategory != '') {
                    category = pcategory.toString().toUpperCase();
                  } else {
                    category = "N/A";
                  }
                  // if (pitem != null) {
                  //   item = " | " + pitem.toString().toUpperCase();
                  // }
                  return category;
                }

                //print(pitemcategory(index));
                pdesc(index) {
                  var pdesc = products[index].desc;
                  var desc = "";
                  if (pdesc != null || pdesc != '') {
                    desc = toBeginningOfSentenceCase(pdesc).toString();
                  } else {
                    desc = "N/A";
                  }
                  return desc;
                }

                // print(pdesc(index));
                pstocks(index) {
                  var pstocks = products[index].stocks;
                  var stocks = "0";
                  if (pstocks != null) {
                    stocks = pstocks.toString();
                  } else {
                    stocks = "0";
                  }
                  return stocks;
                }

                // print(pstocks(index));
                psrp(index) {
                  var psrp = products[index].stockSRP;
                  var srp = "";
                  if (psrp != null) {
                    srp = (psrp.toStringAsFixed(2)).toString();
                    List<String> srpt = srp.split('.');
                    srp = "₱" + srpt[0].toString() + "." + srpt[1].toString();
                  } else {
                    srp = "N/A";
                  }
                  return srp;
                }

                // print(psrp(index));
                ppp(index) {
                  var ppp = products[index].stockPurchasePrice;
                  var pp = "";
                  if (ppp != null) {
                    pp = (ppp.toStringAsFixed(2)).toString();
                    List<String> pppt = pp.split('.');
                    pp = "₱" + pppt[0].toString() + "." + pppt[1].toString();
                  } else {
                    pp = "N/A";
                  }
                  return pp;
                }

                // print(ppp(index));
                punit(index) {
                  var punit = products[index].stockUnit;
                  var unit = "";
                  if (punit != null) {
                    unit = toBeginningOfSentenceCase(punit).toString();
                  } else {
                    unit = "";
                  }
                  return unit.toString().toUpperCase();
                }

                // print(punit(index));
                return Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.25, // soften the shadow
                            spreadRadius: 0.25, //extend the shadow
                            offset: Offset(
                              1.0, // Move to right 10  horizontally
                              1.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                        color: Colors.grey[200],
                      ),
                      padding: EdgeInsets.only(bottom: 0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: _db
                                    .collection('productphotos')
                                    .where('binderId',
                                        isEqualTo: products[index].binderId)
                                    .limit(1)
                                    .snapshots(),
                                builder: (context, snapshots) {
                                  if (!snapshots.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshots.hasError) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshots.data.docs.isEmpty) {
                                    return Container(
                                      width: 130,
                                      height: 160,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5),
                                      child: Center(
                                        child: Text("NO PICTURE",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    );
                                  }
                                  var url = snapshots.data.docs[0]['url'];
                                  return new Container(
                                    height: 160,
                                    width: 130,
                                    // decoration: new BoxDecoration(
                                    //   image: new DecorationImage(
                                    //     image: NetworkImage(url),
                                    //     fit: BoxFit.fill,
                                    //   ), // color: Colors.teal,
                                    // ),
                                    child: CachedNetworkImage(
                                      imageUrl: url,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.colorBurn)),
                                        ),
                                      ),
                                      placeholder: (context, url) => Container(
                                          width: 30,
                                          height: 30,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator())),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              //flex: 8,
                              //padding: EdgeInsets.only(top: 10),
                              //margin: EdgeInsets.only(bottom: -10),
                              child: Column(
                                children: <Widget>[
                                  // Expanded(
                                  //   child: Text(
                                  Container(
                                    width: 600,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      pbrandname(index).toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // Container(
                                  //   alignment: Alignment.centerLeft,
                                  //   margin: EdgeInsets.only(left: 10),
                                  //   child: Text(pitemcategory(index).toString(),
                                  //       style: TextStyle(
                                  //         fontSize: 12,
                                  //       )),
                                  // ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                            pitemcategory(index).toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      (products[index].stockDesc == null)
                                          ? SizedBox(width: 5)
                                          : (products[index].stockDesc ==
                                                  "retail")
                                              ? Chip(
                                                  avatar: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue.shade800,
                                                    child: Text(
                                                      'R',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                  label: Text(
                                                    'FOR RETAIL',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .blue.shade800,
                                                        fontSize: 10),
                                                  ),
                                                )
                                              : (products[index].stockDesc ==
                                                      "wholesale")
                                                  ? Chip(
                                                      avatar: CircleAvatar(
                                                        backgroundColor: Colors
                                                            .green.shade800,
                                                        child: Text(
                                                          'W',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10),
                                                        ),
                                                      ),
                                                      label: Text(
                                                          'FOR WHOLESALE',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .green
                                                                  .shade800,
                                                              fontSize: 10)),
                                                    )
                                                  : (products[index].stockDesc ==
                                                          "sale")
                                                      ? Chip(
                                                          avatar: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.red
                                                                    .shade800,
                                                            child: Text(
                                                              'S',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                          label: Text('ON SALE',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .red
                                                                      .shade800,
                                                                  fontSize:
                                                                      10)))
                                                      : SizedBox(width: 5),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(pvariant(index).toString(),
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                        )),
                                  ),
                                  Container(
                                    //width: 50,
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.only(
                                        left: 5, right: 5, top: 5, bottom: 5),
                                    margin: EdgeInsets.only(right: 10),
                                    //height: double.infinity,
                                    decoration: BoxDecoration(
                                        // borderRadius:
                                        //     BorderRadius.circular(10),
                                        // border: Border.all(
                                        //     color: Colors.teal, width: 1.0),
                                        ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 25),
                                        Center(
                                          child: Text(
                                            "SRP",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: Colors.teal),
                                          ),
                                        ),
                                        SizedBox(width: 25),
                                        Center(
                                          child: FittedBox(
                                            child: Text(
                                              psrp(index).toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.teal),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        FittedBox(
                                          child: Row(
                                            children: <Widget>[
                                              GestureDetector(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      top: 5,
                                                      bottom: 5),
                                                  margin: EdgeInsets.only(
                                                      right: 5, left: 10),
                                                  //height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Colors.teal,
                                                        width: 1.0),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Center(
                                                        child: FittedBox(
                                                          child: Icon(
                                                              Icons
                                                                  .remove_red_eye_outlined,
                                                              color:
                                                                  Colors.teal,
                                                              size: 12),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          "PRODUCT",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.teal),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewProduct(
                                                              products[index]),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 5),
                              child: FittedBox(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 60,
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                          top: 30,
                                          bottom: 0),
                                      decoration: BoxDecoration(
                                        color: (products[index].stocks == null)
                                            ? Colors.red
                                            : (products[index].stocks <= 10)
                                                ? Colors.red
                                                : Colors.green,
                                      ),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: FittedBox(
                                              child: Text(
                                                pstocks(index).toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              "AVAILABLE",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              "STOCKS",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
