import 'package:Register/methods/deleteTransaction.dart';
import 'package:Register/models/transaction.dart';
import 'package:Register/store/edit_trans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class ListTransactions extends StatefulWidget {
  @override
  _ListTransactionsState createState() => _ListTransactionsState();
}

class _ListTransactionsState extends State<ListTransactions> {
  //final FirebaseFirestore _db = FirebaseFirestore.instance;
  double totalSales = 0.00;

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<List<ProductTrans>>(context);

    //int len = transactions.length;
    print(transactions.length.toString());
    sales() {
      totalSales = 0.00;
      transactions.forEach((element) {
        totalSales += element.totalPrice;
      });
      return totalSales;
    }

    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Center(
            // child: Text(
            //   "Total Sales Count: " +
            //       transactions.length.toString() +
            //       "     |     Total Sales Amount: ₱ " +
            //       sales().toString(),
            // ),
            child: (transactions == null)
                ? Text(
                    "Total Sales Count: 0   |     Total Sales Amount: ₱ 0.00",
                  )
                : Text(
                    "Total Sales Count: " +
                        transactions.length.toString() +
                        "     |     Total Sales Amount: ₱ " +
                        sales().toString(),
                  ),
          ),

          // StreamBuilder<QuerySnapshot>(
          //     stream: _db.collection('trans').snapshots(),
          //     builder: (context, snapshots) {
          //       if (!snapshots.hasData) {
          //         return Center(
          //           child: Text("No transactions found..."),
          //         );
          //       } else {
          //         totalSales() {
          //           snapshots.data.docs.forEach((element) {
          //             double sum = 0.00;
          //             sum = sum + element['totalPrice'].toDouble();
          //             return sum;
          //           });
          //         }

          //         return Center(
          //           child: Text("Total Sales Count: " +
          //               snapshots.data.docs.length.toString() +
          //               "     |     Total Sales Amount: ₱ " +
          //               totalSales().toString()),
          //         );
          //         //print(snapshots.data.docs.length);
          //       }
          //     }),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 300,
            child: (transactions != null)
                ? ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      // setState(() {
                      //   totalSales += transactions[index].totalPrice;
                      // });
                      //sales(transactions.length);
                      return new Container(
                        margin: new EdgeInsets.all(5.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: new ListTile(
                          title: new Text("Order No: " +
                              transactions[index].transId.toString() +
                              "\nTotal Price: ₱ " +
                              transactions[index].totalPrice.toString()),
                          subtitle: new Text(transactions[index].transDate +
                                  "\n" +
                                  transactions[index]
                                      .status
                                      .toString()
                                      .toUpperCase()
                              // "\nTotal items: " +
                              // transactions[index].totalItems.toString(),
                              ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.teal,
                                  size: 25,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TransPage(
                                          transactions[index]
                                              .transId
                                              .toString(),
                                          transactions[index].status,
                                          transactions[index]
                                              .totalItems
                                              .toInt()),
                                    ),
                                  );
                                },
                              ),
                              // (transactions[index].status == "in-progress" ||
                              //         transactions[index].totalItems == 0)
                              //     ? IconButton(
                              //         icon: Icon(
                              //           Icons.delete_outline,
                              //           color: Colors.red,
                              //           size: 25,
                              //         ),
                              //         onPressed: () async {
                              //           asyncConfirmDeleteTransDialog(
                              //               context,
                              //               transactions[index].orderNo,
                              //               transactions[index].totalItems);
                              //         },
                              //       )
                              //     : SizedBox(width: 0),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("No transactions found"),
                  ),
          ),
        ],
      ),
    );
  }
}
