import 'package:Register/services/firestore_service.dart';
import 'package:Register/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductTransProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _transId;
  int _orderNo;
  String _receiptNo;
  String _userId;
  String _transaction;
  double _totalPrice;
  int _totalItems;
  String _discountType;
  String _status;
  String _remarks;
  String _transDate;
  DateTime _logDate;
  var uuid = Uuid();

  String get transId => _transId;
  int get orderNo => _orderNo;
  String get receiptNo => _receiptNo;
  String get userId => _userId;
  String get transaction => _transaction;
  double get totalPrice => _totalPrice;
  int get totalItems => _totalItems;
  String get discountType => _discountType;
  String get status => _status;
  String get remarks => _remarks;
  String get transDate => _transDate;
  DateTime get logDate => _logDate;

  changeTransId(String value) {
    _transId = value;
    notifyListeners();
  }

  changeOrderNo(int value) {
    _orderNo = value;
    notifyListeners();
  }

  changeReceiptNo(String value) {
    _receiptNo = value;
    notifyListeners();
  }

  changeUserId(String value) {
    _userId = value;
    notifyListeners();
  }

  changeProductTrans(String value) {
    _transaction = value;
    notifyListeners();
  }

  changeTotalPrice(double value) {
    _totalPrice = value;
    notifyListeners();
  }

  changeTotalItems(int value) {
    _totalItems = value;
    notifyListeners();
  }

  changeDiscountType(String value) {
    _discountType = value;
    notifyListeners();
  }

  changeStatus(String value) {
    _status = value;
    notifyListeners();
  }

  chagneRemarks(String value) {
    _remarks = value;
    notifyListeners();
  }

  changeTransDate(String value) {
    _transDate = value;
    notifyListeners();
  }

  // changeLogDate(DateTime value) {
  //   _logDate = value;
  //   notifyListeners();
  // }

  loadValues(ProductTrans transaction) {
    _transId = transaction.transId;
    _orderNo = transaction.orderNo;
    _receiptNo = transaction.receiptNo;
    _userId = transaction.userId;
    _transaction = transaction.transaction;
    _totalPrice = transaction.totalPrice;
    _totalItems = transaction.totalItems;
    _discountType = transaction.discountType;
    _status = transaction.status;
    _remarks = transaction.remarks;
    _transDate = transaction.transDate;
    // _logDate = transaction.logDate;
  }

  saveProductTrans() {
    print(_transId);
    if (_transId != transId) {
      var newProductTrans = ProductTrans(
        transId: transId,
        orderNo: orderNo,
        receiptNo: receiptNo,
        userId: userId,
        transaction: transaction,
        totalPrice: totalPrice,
        totalItems: totalItems,
        discountType: discountType,
        status: status,
        remarks: remarks,
        transDate: transDate,
        //logDate: logDate,
      );
      firestoreService.saveProductTrans(newProductTrans);
    } else {
      var updateProductTrans = ProductTrans(
        transId: transId,
        orderNo: orderNo,
        receiptNo: receiptNo,
        userId: userId,
        transaction: transaction,
        totalPrice: totalPrice,
        totalItems: totalItems,
        discountType: discountType,
        status: status,
        remarks: remarks,
        transDate: transDate,
        //logDate: logDate,
      );
      firestoreService.saveProductTrans(updateProductTrans);
    }
  }

  removeTrans(String transId) {
    firestoreService.removeTrans(transId);
  }
}
