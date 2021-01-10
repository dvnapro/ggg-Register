import 'package:cloud_firestore/cloud_firestore.dart';

class StocksLog {
  final String logId;
  final String productId;
  final String cartId;
  final String userId;
  final String transId;
  final String binderId;
  final String supplierId;
  final String supplier;
  final String transaction;
  final String barcode;
  final String unit;
  final int currentStocks;
  final int transUnits;
  final int newStocks;
  final String logDate;

  StocksLog(
      {this.logId,
      this.productId,
      this.cartId,
      this.userId,
      this.transId,
      this.binderId,
      this.supplierId,
      this.supplier,
      this.transaction,
      this.barcode,
      this.unit,
      this.currentStocks,
      this.transUnits,
      this.newStocks,
      this.logDate});

  Map<String, dynamic> toMap() {
    return {
      'logId': logId,
      'productId': productId,
      'cartId': cartId,
      'transId': transId,
      'userId': userId,
      'binderId': binderId,
      'supplierId': supplierId,
      'supplier': supplier,
      'transaction': transaction,
      'barcode': barcode,
      'unit': unit,
      'currentStocks': currentStocks,
      'transUnits': transUnits,
      'newStocks': newStocks,
      'logDate': logDate
    };
  }

  factory StocksLog.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> Function() data = doc.data;
    return StocksLog(
      logId: data()['logId'] ?? '',
      productId: data()['productId'] ?? '',
      cartId: data()['cartId'] ?? '',
      transId: data()['transId'] ?? '',
      binderId: data()['binderId'] ?? '',
      userId: data()['userId'] ?? '',
      supplierId: data()['supplierId'] ?? '',
      supplier: data()['supplier'] ?? '',
      barcode: data()['barcode'] ?? '',
      unit: data()['unit'] ?? '',
      currentStocks: data()['currentStocks'] ?? 0,
      transUnits: data()['transUnits'] ?? 0,
      newStocks: data()['newStocks'] ?? 0,
      logDate: data()['logDate'] ?? '',
    );
  }
}
