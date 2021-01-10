import 'package:cloud_firestore/cloud_firestore.dart';

class PurchasePriceLog {
  final String logId;
  final String productId;
  final String userId;
  final String transId;
  final String supplierId;
  final String binderId;
  final String supplier;
  final String transaction;
  final String barcode;
  final String unit;
  final int currentPurchasePrice;
  final int newPurchasePrice;
  final String logDate;

  PurchasePriceLog(
      {this.logId,
      this.productId,
      this.userId,
      this.transId,
      this.binderId,
      this.supplierId,
      this.supplier,
      this.transaction,
      this.barcode,
      this.unit,
      this.currentPurchasePrice,
      this.newPurchasePrice,
      this.logDate});

  Map<String, dynamic> toMap() {
    return {
      'logId': logId,
      'productId': productId,
      'transId': transId,
      'userId': userId,
      'binderId': binderId,
      'supplierId': supplierId,
      'supplier': supplier,
      'transaction': transaction,
      'barcode': barcode,
      'unit': unit,
      'currentPurchasePrice': currentPurchasePrice,
      'newPurchasePrice': newPurchasePrice,
      'logDate': logDate
    };
  }

  factory PurchasePriceLog.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> Function() data = doc.data;
    return PurchasePriceLog(
      logId: data()['logId'] ?? '',
      productId: data()['productId'] ?? '',
      transId: data()['transId'] ?? '',
      binderId: data()['binderId'] ?? '',
      userId: data()['userId'] ?? '',
      supplierId: data()['supplierId'] ?? '',
      supplier: data()['supplier'] ?? '',
      barcode: data()['barcode'] ?? '',
      unit: data()['unit'] ?? '',
      currentPurchasePrice: data()['currentPurchasePrice'] ?? 0,
      newPurchasePrice: data()['newPurchasePrice'] ?? 0,
      logDate: data()['logDate'] ?? '',
    );
  }
}
