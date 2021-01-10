import 'package:Register/services/firestore_service.dart';
import 'package:Register/models/stockslog.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StocksLogProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _logId;
  String _transId;
  String _productId;
  String _cartId;
  String _binderId;
  String _supplierId;
  String _userId;
  String _supplier;
  String _barcode;
  String _transaction;
  String _unit;
  int _currentStocks;
  int _transUnits;
  int _newStocks;
  String _logDate;
  var uuid = Uuid();

  String get logId => _logId;
  String get transId => _transId;
  String get productId => _productId;
  String get cartId => _cartId;
  String get binderId => _binderId;
  String get supplierId => _supplierId;
  String get userId => _userId;
  String get supplier => _supplier;
  String get transaction => _transaction;
  String get barcode => _barcode;
  String get unit => _unit;
  String get logDate => _logDate;
  int get currentStocks => _currentStocks;
  int get transUnits => _transUnits;
  int get newStocks => _newStocks;

  changeLogId(String value) {
    _logId = value;
    notifyListeners();
  }

  changeProductId(String value) {
    _productId = value;
    notifyListeners();
  }

  changeCartId(String value) {
    _cartId = value;
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

  changeCurrentStocks(int value) {
    _currentStocks = value;
    notifyListeners();
  }

  changeTransUnits(int value) {
    _transUnits = value;
    notifyListeners();
  }

  changeNewStocks(int value) {
    _newStocks = value;
    notifyListeners();
  }

  loadValues(StocksLog log) {
    _logId = log.logId;
    _productId = log.productId;
    _cartId = log.cartId;
    _transId = log.transId;
    _binderId = log.binderId;
    _supplierId = log.supplierId;
    _userId = log.userId;
    _supplier = log.supplier;
    _transaction = log.transaction;
    _barcode = log.barcode;
    _unit = log.unit;
    _logDate = log.logDate;
    _currentStocks = log.currentStocks;
    _transUnits = log.transUnits;
    _newStocks = log.newStocks;
  }

  saveStocksLog() {
    print(_logId);
    if (_logId == null) {
      var newStocksLog = StocksLog(
          logId: uuid.v4(),
          productId: productId,
          cartId: cartId,
          transId: transId,
          binderId: binderId,
          supplierId: supplierId,
          userId: userId,
          supplier: supplier,
          transaction: transaction,
          barcode: barcode,
          unit: unit,
          logDate: logDate,
          currentStocks: currentStocks,
          transUnits: transUnits,
          newStocks: newStocks);
      firestoreService.saveStocksLog(newStocksLog);
    } else {
      var updateStocksLog = StocksLog(
          logId: logId,
          productId: productId,
          cartId: cartId,
          transId: transId,
          binderId: binderId,
          supplierId: supplierId,
          userId: userId,
          supplier: supplier,
          transaction: transaction,
          barcode: barcode,
          unit: unit,
          logDate: logDate,
          currentStocks: currentStocks,
          transUnits: transUnits,
          newStocks: newStocks);
      firestoreService.saveStocksLog(updateStocksLog);
    }
  }

  removeStocksLog(String logId, String productId) {
    firestoreService.removeStocksLog(logId, productId);
  }
}
