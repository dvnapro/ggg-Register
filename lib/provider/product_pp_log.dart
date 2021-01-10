import 'package:Register/services/firestore_service.dart';
import 'package:Register/models/pplog.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PurchasePriceLogProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _logId;
  String _transId;
  String _productId;
  String _binderId;
  String _supplierId;
  String _userId;
  String _supplier;
  String _barcode;
  String _transaction;
  String _unit;
  int _currentPurchasePrice;
  int _newPurchasePrice;
  String _logDate;
  var uuid = Uuid();

  String get logId => _logId;
  String get transId => _transId;
  String get productId => _productId;
  String get binderId => _binderId;
  String get supplierId => _supplierId;
  String get userId => _userId;
  String get supplier => _supplier;
  String get transaction => _transaction;
  String get barcode => _barcode;
  String get unit => _unit;
  String get logDate => _logDate;
  int get currentPurchasePrice => _currentPurchasePrice;
  int get newPurchasePrice => _newPurchasePrice;

  changeLogId(String value) {
    _logId = value;
    notifyListeners();
  }

  changeProductId(String value) {
    _productId = value;
    notifyListeners();
  }

  changeTransId(String value) {
    _transId = value;
    notifyListeners();
  }

  changeBinderId(String value) {
    _binderId = value;
    notifyListeners();
  }

  changeSupplierId(String value) {
    _supplierId = value;
    notifyListeners();
  }

  changeUserId(String value) {
    _userId = value;
    notifyListeners();
  }

  changeSupplier(String value) {
    _supplier = value;
    notifyListeners();
  }

  changeTransaction(String value) {
    _transaction = value;
    notifyListeners();
  }

  changeBarcode(String value) {
    _barcode = value;
    notifyListeners();
  }

  changeUnit(String value) {
    _unit = value;
    notifyListeners();
  }

  changelogDate(String value) {
    _logDate = value;
    notifyListeners();
  }

  changeCurrentPurchasePrice(int value) {
    _currentPurchasePrice = value;
    notifyListeners();
  }

  changeNewPurchasePrice(int value) {
    _newPurchasePrice = value;
    notifyListeners();
  }

  loadValues(PurchasePriceLog log) {
    _logId = log.logId;
    _productId = log.productId;
    _transId = log.transId;
    _binderId = log.binderId;
    _supplierId = log.supplierId;
    _userId = log.userId;
    _supplier = log.supplier;
    _transaction = log.transaction;
    _barcode = log.barcode;
    _unit = log.unit;
    _logDate = log.logDate;
    _currentPurchasePrice = log.currentPurchasePrice;
    _newPurchasePrice = log.newPurchasePrice;
  }

  savePurchasePriceLog() {
    print(_logId);
    if (_logId == null) {
      var newPurchasePriceLog = PurchasePriceLog(
          logId: uuid.v4(),
          productId: productId,
          transId: transId,
          binderId: binderId,
          supplierId: supplierId,
          userId: userId,
          supplier: supplier,
          transaction: transaction,
          barcode: barcode,
          unit: unit,
          logDate: logDate,
          currentPurchasePrice: currentPurchasePrice,
          newPurchasePrice: newPurchasePrice);
      firestoreService.savePurchasePriceLog(newPurchasePriceLog);
    } else {
      var updatePurchasePriceLog = PurchasePriceLog(
          logId: logId,
          productId: productId,
          transId: transId,
          binderId: binderId,
          supplierId: supplierId,
          userId: userId,
          supplier: supplier,
          transaction: transaction,
          barcode: barcode,
          unit: unit,
          logDate: logDate,
          currentPurchasePrice: currentPurchasePrice,
          newPurchasePrice: newPurchasePrice);
      firestoreService.savePurchasePriceLog(updatePurchasePriceLog);
    }
  }

  removePurchasePriceLog(String logId, String productId) {
    firestoreService.removePurchasePriceLog(logId, productId);
  }
}
