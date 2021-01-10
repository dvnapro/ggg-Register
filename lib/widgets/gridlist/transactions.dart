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
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 300,
            child: (transactions != null)
                ? ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
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
                          subtitle: (transactions[index].remarks == null ||
                                  transactions[index].remarks == '')
                              ? new Text(transactions[index].transDate +
                                  "\n" +
                                  transactions[index]
                                      .status
                                      .toString()
                                      .toUpperCase())
                              : new Text(
                                  transactions[index].transDate +
                                      "\n" +
                                      transactions[index]
                                          .status
                                          .toString()
                                          .toUpperCase() +
                                      " | " +
                                      transactions[index]
                                          .remarks
                                          .toString()
                                          .toUpperCase(),
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
                                              .toInt(),
                                          transactions[index]
                                              .totalPrice
                                              .toDouble()),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 0),
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
