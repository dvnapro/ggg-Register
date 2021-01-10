import 'package:Register/models/byField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScannedItem extends StatelessWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<ProductByField>>(context);
    int len;
    //print(products[0].toString());

    if (products.length == null) {
      len = 0;
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      len = products.length;
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(20),
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

                print(pbrandname(index));
                pvariant(index) {
                  var pcolor = products[index].color;
                  var pmaterial = products[index].material;
                  var pmeasure = products[index].measure;
                  var color = "";
                  var material = "";
                  var measure = "";
                  if (pcolor != null || pcolor != '') {
                    color = pcolor.toString().toUpperCase();
                  } else {
                    color = "No Color";
                  }
                  if (pmaterial != null || pmaterial != '') {
                    material = " | " + pmaterial.toString().toUpperCase();
                  } else {
                    material = " | No Material";
                  }
                  if (pmeasure != null || pmeasure != '') {
                    measure = " | " + pmeasure.toString().toUpperCase();
                  } else {
                    measure = " | No Measure";
                  }
                  // if (pcolor == null && pmeasure == null && pmaterial == null ||
                  //     pcolor == "" && pmeasure == "" && pmaterial == "") {
                  //   return "( Color, material and measure not yet set )";
                  // }
                  return "( " + color + "" + material + "" + measure + " )";
                }

                print(pvariant(index));
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

                print(pitemcategory(index));
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
                    Text(
                      "QR / Barcode:",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        products[index].stockBarcode.toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Product:",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        pbrandname(index),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Description:",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        pvariant(index) + "\n" + pdesc(index),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Product SRP:",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        psrp(index),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            )
          : Center(
              child: Text("Item not found"),
            ),
    );
  }
}
