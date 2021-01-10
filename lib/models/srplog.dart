import 'package:cloud_firestore/cloud_firestore.dart';

class SRPLog {
  final String logId;
  final String productId;
  final String userId;
  final String transId;
  final String binderId;
  final String supplierId;
  final String supplier;
  final String transaction;
  final String barcode;
  final String unit;
  final int currentSRP;
  final int newSRP;
  final String logDate;

  SRPLog(
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
      this.currentSRP,
      this.newSRP,
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
      'currentSRP': currentSRP,
      'newSRP': newSRP,
      'logDate': logDate
    };
  }

  factory SRPLog.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> Function() data = doc.data;
    return SRPLog(
      logId: data()['logId'] ?? '',
      productId: data()['productId'] ?? '',
      transId: data()['transId'] ?? '',
      binderId: data()['binderId'] ?? '',
      userId: data()['userId'] ?? '',
      supplierId: data()['supplierId'] ?? '',
      supplier: data()['supplier'] ?? '',
      barcode: data()['barcode'] ?? '',
      unit: data()['unit'] ?? '',
      currentSRP: data()['currentSRP'] ?? 0,
      newSRP: data()['newSRP'] ?? 0,
      logDate: data()['logDate'] ?? '',
    );
  }
}
