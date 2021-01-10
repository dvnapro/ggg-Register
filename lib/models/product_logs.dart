import 'package:cloud_firestore/cloud_firestore.dart';

class ProductLog {
  final String logId;
  final String userId;
  final String productId;
  final String transId;
  final String transaction;
  final String field;
  final String oldvalue;
  final String newvalue;
  final String logdate;

  ProductLog(
      {this.logId,
      this.productId,
      this.userId,
      this.transId,
      this.transaction,
      this.field,
      this.oldvalue,
      this.newvalue,
      this.logdate});

  Map<String, dynamic> toMap() {
    return {
      'logId': logId,
      'userId': userId,
      'productId': productId,
      'transId': transId,
      'transaction': transaction,
      'field': field,
      'oldvalue': oldvalue,
      'newvalue': newvalue,
      'logdate': logdate
    };
  }

  factory ProductLog.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> Function() data = doc.data;
    return ProductLog(
      logId: data()['logId'] ?? '',
      userId: data()['userId'] ?? '',
      productId: data()['productId'] ?? '',
      transId: data()['transId'] ?? '',
      transaction: data()['transaction'] ?? '',
      field: data()['field'] ?? '',
      oldvalue: data()['oldvalue'] ?? '',
      newvalue: data()['newvalue'] ?? '',
      logdate: data()['logdate'] ?? '',
    );
  }
}
