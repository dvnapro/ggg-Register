import 'package:Register/methods/alertDelete.dart';
import 'package:Register/models/product.dart';
import 'package:Register/routes/args/args.dart';
import 'package:Register/screens/viewproduct.dart';

import 'package:Register/store/edit_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductByCategoryList extends StatefulWidget {
  @override
  _ProductByCategoryListState createState() => _ProductByCategoryListState();
}

class _ProductByCategoryListState extends State<ProductByCategoryList> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  int len;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    final CategoryArgs args = ModalRoute.of(context).settings.arguments;
    //print(products[0].toString());
    if (products != null) {
      setState(() {
        len = products.length;
      });
    }
    // for (int i = 0; i < len; i++) {
    //   if (args.catname.toString().toLowerCase() !=
    //       products[i].categoryId.toString().toLowerCase()) {
    //     setState(() {
    //       len = 1;
    //     });
    //   }
    // }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: (products != null)
          // ? Text(products[0].productId.toString() +
          //     " | " +
          //     products[0].binderId.toString())
          ? ListView.builder(
              itemCount: len,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                print("arges " + args.catname);
                print("Product Value " + products[index].categoryId.toString());
                pbrandname(index) {
                  var pbrand = products[index].brandId;
                  var pname = products[index].name;
                  var brand;
                  var name;
                  if (pbrand != null) {
                    brand = "[ " + pbrand.toString().toUpperCase() + " ]";
                  }
                  if (pname != null) {
                    name = pname.toString().toUpperCase();
                  }
                  return brand + " " + name;
                }

                pvariant(index) {
                  var pcolor = products[index].color;
                  var pmaterial = products[index].material;
                  var pmeasure = products[index].measure;
                  var color = "";
                  var material = "";
                  var measure = "";
                  if (pcolor != null || pcolor != "") {
                    color = pcolor.toString().toUpperCase();
                  }
                  if (pmaterial != null || pmaterial != "") {
                    material = " | " + pmaterial.toString().toUpperCase();
                  }
                  if (pmeasure != null || pmeasure != "") {
                    measure = " | " + pmeasure.toString().toUpperCase();
                  }
                  if (pcolor == null && pmeasure == null && pmaterial == null ||
                      pcolor == "" && pmeasure == "" && pmaterial == "") {
                    return "";
                  }
                  return "( " + color + "" + material + "" + measure + " )";
                }

                pitemcategory(index) {
                  var pcategory = products[index].categoryId;
                  //var pitem = products[index].item;
                  var category = "";
                  //var item = "";
                  if (pcategory != null) {
                    category = pcategory.toString().toUpperCase();
                  }
                  // if (pitem != null) {
                  //   item = " | " + pitem.toString().toUpperCase();
                  // }
                  return category + "";
                }

                pdesc(index) {
                  var pdesc = products[index].desc;
                  var desc = "";
                  if (pdesc != null) {
                    desc = toBeginningOfSentenceCase(pdesc);
                  }
                  return desc;
                }

                pstocks(index) {
                  var pstocks = products[index].stocks;
                  var stocks = "0";
                  if (pstocks != null) {
                    stocks = pstocks.toString();
                  }
                  return stocks;
                }

                psrp(index) {
                  var psrp = products[index].stockSRP;
                  var srp = "";
                  if (psrp != null) {
                    srp = (psrp.toStringAsFixed(2)).toString();
                    List<String> srpt = srp.split('.');
                    srp = "₱" + srpt[0].toString() + "." + srpt[1].toString();
                  }
                  return srp;
                }

                ppp(index) {
                  var ppp = products[index].stockPurchasePrice;
                  var pp = "";
                  if (ppp != null) {
                    pp = (ppp.toStringAsFixed(2)).toString();
                    List<String> pppt = pp.split('.');
                    pp = "₱" + pppt[0].toString() + "." + pppt[1].toString();
                  }
                  return pp;
                }

                punit(index) {
                  var punit = products[index].stockUnit;
                  var unit = "";
                  if (punit != null) {
                    unit = toBeginningOfSentenceCase(punit);
                  }
                  return unit;
                }

                return (args.catname != products[index].categoryId)
                    // ? Container(
                    //     height: 600,
                    //     child: Center(
                    //       child: Text(
                    //         "No Products currently available for " +
                    //             args.catname.toString().toLowerCase(),
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold, fontSize: 24),
                    //       ),
                    //     ))
                    ? SizedBox(
                        width: 10,
                      )
                    : Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              //border: Border.all(width: 2, color: Colors.green),
                              boxShadow: [
                                //color: Colors.white, //background color of box
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2.0, // soften the shadow
                                  spreadRadius: 1, //extend the shadow
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
                                              isEqualTo:
                                                  products[index].binderId)
                                          .limit(1)
                                          .snapshots(),
                                      builder: (context, snapshots) {
                                        if (!snapshots.hasData) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        if (snapshots.hasError) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        if (snapshots.data.docs.isEmpty) {
                                          return Container(
                                            width: 100,
                                            height: 100,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(5),
                                            //margin: EdgeInsets.all(10),
                                            child: Center(
                                              child: Text("NO PICTURE",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          );
                                        }
                                        var url = snapshots.data.docs[0]['url'];
                                        return new Container(
                                          //padding: EdgeInsets.all(5),
                                          height: 100,
                                          width: 100,
                                          decoration: new BoxDecoration(
                                            image: new DecorationImage(
                                              image: NetworkImage(url),
                                              fit: BoxFit.fill,
                                            ), // color: Colors.teal,
                                          ),
                                          // child: Image(
                                          //   width: 100,
                                          //   height: 150,
                                          //   fit: BoxFit.fill,
                                          //   image: NetworkImage(url),
                                          // ),
                                        );
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    //padding: EdgeInsets.only(top: 10),
                                    //margin: EdgeInsets.only(bottom: -10),
                                    child: Column(
                                      children: <Widget>[
                                        // Expanded(
                                        //   child: Text(
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            pbrandname(index),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(pitemcategory(index),
                                              style: TextStyle(
                                                fontSize: 12,
                                              )),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(pvariant(index),
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 12,
                                              )),
                                        ),
                                        // Container(
                                        //   alignment: Alignment.centerLeft,
                                        //   child: Text(pdesc(index),
                                        //       style: TextStyle(
                                        //         fontSize: 14,
                                        //       )),
                                        // ),
                                        Divider(),
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
                                              GestureDetector(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      top: 5,
                                                      bottom: 5),
                                                  margin:
                                                      EdgeInsets.only(right: 5),
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
                                                                  .edit_outlined,
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
                                                          EditProduct(
                                                              products[index]),
                                                    ),
                                                  );
                                                },
                                              ),
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
                                                      right: 10),
                                                  //height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Colors.red,
                                                        width: 1.0),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Center(
                                                        child: FittedBox(
                                                          child: Icon(
                                                              Icons
                                                                  .delete_outlined,
                                                              color: Colors.red,
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
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () async {
                                                  await asyncConfirmDialog(
                                                      context,
                                                      products[index]
                                                          .productId);
                                                },
                                              ),
                                              Container(
                                                //width: 50,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    top: 5,
                                                    bottom: 5),
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                //height: double.infinity,
                                                decoration: BoxDecoration(
                                                    // borderRadius:
                                                    //     BorderRadius.circular(10),
                                                    // border: Border.all(
                                                    //     color: Colors.teal, width: 1.0),
                                                    ),
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: FittedBox(
                                                        child: Text(
                                                          ppp(index),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.teal),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        "Purchase Price",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10,
                                                            color: Colors.teal),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                //width: 50,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    top: 5,
                                                    bottom: 5),
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                //height: double.infinity,
                                                decoration: BoxDecoration(
                                                    // borderRadius:
                                                    //     BorderRadius.circular(10),
                                                    // border: Border.all(
                                                    //     color: Colors.teal, width: 1.0),
                                                    ),
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: FittedBox(
                                                        child: Text(
                                                          psrp(index),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.teal),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        "SRP",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10,
                                                            color: Colors.teal),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //),
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
                                            width: 50,
                                            alignment: Alignment.bottomCenter,
                                            padding: EdgeInsets.only(
                                                left: 5,
                                                right: 5,
                                                top: 25,
                                                bottom: 30),
                                            //margin: EdgeInsets.only(top: 10),
                                            //height: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  (products[index].stocks <= 10)
                                                      ? Colors.red
                                                      : Colors.green,
                                            ),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: FittedBox(
                                                    child: Text(
                                                      pstocks(index),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    "AVAILABLE",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 8,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    "STOCKS",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                          SizedBox(height: 10),
                          //Divider(),
                        ],
                      );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
