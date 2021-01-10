import 'package:cloud_firestore/cloud_firestore.dart';

class ProductTrans {
  final String transId;
  final int orderNo;
  final String receiptNo;
  final String userId;
  final String transaction;
  final double totalPrice;
  final int totalItems;
  final String discountType;
  final String status;
  final String remarks;
  final String transDate;
  //final DateTime logDate;

  ProductTrans({
    this.transId,
    this.orderNo,
    this.receiptNo,
    this.userId,
    this.transaction,
    this.totalPrice,
    this.totalItems,
    this.discountType,
    this.status,
    this.remarks,
    this.transDate,
    //this.logDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'transId': transId,
      'orderNo': orderNo,
      'receiptNo': receiptNo,
      'userId': userId,
      'transaction': transaction,
      'totalPrice': totalPrice,
      'totalItems': totalItems,
      'discountType': discountType,
      'status': status,
      'remarks': remarks,
      'transDate': transDate
      //'logDate': logDate
    };
  }

  factory ProductTrans.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> Function() data = doc.data;
    return ProductTrans(
        transId: data()['transId'] ?? '',
        orderNo: data()['orderNo'] ?? 00,
        receiptNo: data()['receiptNo'] ?? '',
        userId: data()['userId'] ?? '',
        transaction: data()['transaction'] ?? '',
        discountType: data()['discounttype'] ?? '',
        totalItems: data()['totalItems'] ?? 0,
        totalPrice: data()['totalPrice'] ?? 0.00,
        status: data()['status'] ?? '',
        remarks: data()['remarks'] ?? '',
        transDate: data()['transDate'] ?? ''
        //logDate: data()['logDate'] ?? '',
        );
  }
}
