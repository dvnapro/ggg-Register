import 'package:Register/models/product_logs.dart';
import 'package:Register/services/firestore_service.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class ProductLogProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _logId;
  String _userId;
  String _transId;
  String _productId;
  String _transaction;
  String _field;
  String _oldvalue;
  String _newvalue;
  String _logdate;

  String get logId => _logId;
  String get userId => _userId;
  String get productId => _productId;
  String get transId => _transId;
  String get transaction => _transaction;
  String get field => _field;
  String get oldvalue => _oldvalue;
  String get newvalue => _newvalue;
  String get logdate => _logdate;
  var uuid = Uuid();

  changeLogId(String value) {
    _logId = value;
    notifyListeners();
  }

  changeUserId(String value) {
    _userId = value;
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

  changeTransaction(String value) {
    _transaction = value;
    notifyListeners();
  }

  changeField(String value) {
    _field = value;
    notifyListeners();
  }

  changeOldValue(String value) {
    _oldvalue = value;
    notifyListeners();
  }

  changeNewValue(String value) {
    _newvalue = value;
    notifyListeners();
  }

  changeLogDate(String value) {
    _logdate = value;
    notifyListeners();
  }

  loadValues(ProductLog log) {
    _logId = log.logId;
    _userId = log.userId;
    _productId = log.productId;
    _transId = log.transId;
    _transaction = log.transaction;
    _field = log.field;
    _oldvalue = log.oldvalue;
    _newvalue = log.newvalue;
    _logdate = log.logdate;
  }

  saveProductLog() {
    print(_logId);
    if (_logId == null) {
      var newProductLog = ProductLog(
          logId: uuid.v4(),
          userId: userId,
          transId: transId,
          productId: productId,
          transaction: transaction,
          field: field,
          oldvalue: oldvalue,
          newvalue: newvalue,
          logdate: logdate);
      firestoreService.saveProductLog(newProductLog);
    } else {
      var editProductLog = ProductLog(
          logId: logId,
          userId: userId,
          transId: transId,
          productId: productId,
          transaction: transaction,
          field: field,
          oldvalue: oldvalue,
          newvalue: newvalue,
          logdate: logdate);
      firestoreService.saveProductLog(editProductLog);
    }
  }
}
