//import 'package:Inventory/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class ProductsTable extends StatelessWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  count(value) {
    int sum = value + 1;
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    //final products = Provider.of<List<Product>>(context);
    return Scaffold(
      body: Container(
        child: new StreamBuilder<QuerySnapshot>(
          stream: _db.collection('products').orderBy('categoryId').snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              Center(child: CircularProgressIndicator());
            }
            print(snapshots.data.docs.length);
            return DataTable(
              columnSpacing: 10,
              columns: [
                DataColumn(label: Text('Index')),
                DataColumn(label: Text('Product & Description')),
                DataColumn(label: Text('Variant')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Stocks')),
                DataColumn(label: Text('Actions')),
              ],
              rows: List<DataRow>.generate(
                snapshots.data.docs.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text(count(index).toString())),
                    DataCell(
                      Row(
                        children: [
                          Icon(Icons.camera_alt),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Text(snapshots.data.docs[index]['name']
                                      .toString()
                                      .toUpperCase()),
                                ),
                                Expanded(
                                  child: Text(snapshots.data.docs[index]['sku']
                                          .toString() +
                                      " " +
                                      snapshots.data.docs[index]['item']
                                          .toString()
                                          .toUpperCase()),
                                ),
                                Expanded(
                                  child: Text(snapshots
                                          .data.docs[index]['categoryId']
                                          .toString()
                                          .toUpperCase() +
                                      " " +
                                      snapshots.data.docs[index]['brandId']
                                          .toString()
                                          .toUpperCase()),
                                ),
                                Expanded(
                                  child: Text(snapshots.data.docs[index]['desc']
                                      .toString()),
                                ),
                                Expanded(
                                  child: Text(snapshots.data.docs[index]['tags']
                                      .toString()),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        children: [
                          Text(snapshots.data.docs[index]['color']
                              .toString()
                              .toUpperCase()),
                          Text(snapshots.data.docs[index]['measure']
                              .toString()
                              .toUpperCase()),
                          Text(snapshots.data.docs[index]['material']
                              .toString()
                              .toUpperCase()),
                        ],
                      ),
                    ),
                    DataCell(Text('Price')),
                    DataCell(Text('Stocks')),
                    DataCell(
                      Column(
                        children: [
                          FlatButton(
                            child: Text('View'),
                            onPressed: null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
