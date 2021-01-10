import 'package:Register/services/firestore_service.dart';
import 'package:Register/models/srplog.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SRPLogProvider with ChangeNotifier {
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
  int _currentSRP;
  int _newSRP;
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
  int get currentSRP => _currentSRP;
  int get newSRP => _newSRP;

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

  changeCurrentSRP(int value) {
    _currentSRP = value;
    notifyListeners();
  }

  changeNewSRP(int value) {
    _newSRP = value;
    notifyListeners();
  }

  loadValues(SRPLog log) {
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
    _currentSRP = log.currentSRP;
    _newSRP = log.newSRP;
  }

  saveSRPLog() {
    print(_logId);
    if (_logId == null) {
      var newSRPLog = SRPLog(
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
          currentSRP: currentSRP,
          newSRP: newSRP);
      firestoreService.saveSRPLog(newSRPLog);
    } else {
      var updateSRPLog = SRPLog(
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
          currentSRP: currentSRP,
          newSRP: newSRP);
      firestoreService.saveSRPLog(updateSRPLog);
    }
  }

  removeSRPLog(String logId, String productId) {
    firestoreService.removeSRPLog(logId, productId);
  }
}
