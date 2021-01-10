import 'package:Register/models/bySupplier.dart';
import 'package:Register/models/supplier.dart';
import 'package:Register/services/supplier_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class SupplierBySupplierProvider with ChangeNotifier {
  final fss = FirestoreSupplierService();
  String _company;
  String _supplierId;
  String _supplierContactPerson;
  String _supplierContactNo;
  String _supplierAddress;
  String _supplierEmail;
  String _logoUrl;
  String _dateAdded;
  String _dateUpdated;
  var uuid = Uuid();

  String get company => _company;
  String get supplierId => _supplierId;
  String get supplierContactPerson => _supplierContactPerson;
  String get supplierContactNo => _supplierContactNo;
  String get supplierAddress => _supplierAddress;
  String get supplierEmail => _supplierEmail;
  String get logoUrl => _logoUrl;
  String get dateAdded => _dateAdded;
  String get dateUpdated => _dateUpdated;

  changeCompany(String val) {
    _company = val;
    notifyListeners();
  }

  changeSupplierId(String val) {
    _supplierId = val;
    notifyListeners();
  }

  changeSupplierContactPerson(String val) {
    _supplierContactPerson = val;
    notifyListeners();
  }

  changeSupplierContactNo(String val) {
    _supplierContactNo = val;
    notifyListeners();
  }

  changeSupplierAddress(String val) {
    _supplierAddress = val;
    notifyListeners();
  }

  changeSupplierEmail(String val) {
    _supplierAddress = val;
    notifyListeners();
  }

  changeLogoUrl(String val) {
    _logoUrl = val;
    notifyListeners();
  }

  changeDateAdded(String val) {
    _dateAdded = val;
    notifyListeners();
  }

  changeDateUpdated(String val) {
    _dateUpdated = val;
    notifyListeners();
  }

  loadValues(Supplier supplier) {
    _company = supplier.company;
    _supplierId = supplier.supplierId;
    _supplierContactPerson = supplier.supplierContactPerson;
    _supplierContactNo = supplier.supplierContactNo;
    _supplierAddress = supplier.supplierAddress;
    _supplierEmail = supplier.supplierEmail;
    _logoUrl = supplier.logoUrl;
    _dateUpdated = supplier.dateUpdated;
    _dateAdded = supplier.dateAdded;
  }

  saveSupplierBySupplier() {
    print(_supplierId);
    if (_supplierId == null) {
      var newSupplierBySupplier = SupplierBySupplier(
          company: company,
          supplierAddress: supplierAddress,
          supplierContactNo: supplierContactNo,
          supplierContactPerson: supplierContactPerson,
          supplierEmail: supplierEmail,
          logoUrl: logoUrl,
          dateAdded: dateAdded,
          dateUpdated: dateUpdated,
          supplierId: uuid.v4());
      fss.saveSupplierBySupplier(newSupplierBySupplier);
    } else {
      var updateSupplierBySupplier = SupplierBySupplier(
          company: company,
          supplierAddress: supplierAddress,
          supplierContactNo: supplierContactNo,
          supplierContactPerson: supplierContactPerson,
          supplierEmail: supplierEmail,
          logoUrl: logoUrl,
          dateAdded: dateAdded,
          dateUpdated: dateUpdated,
          supplierId: supplierId);
      fss.saveSupplierBySupplier(updateSupplierBySupplier);
    }
  }

  removeSupplierBySupplier(String supplier) {
    fss.removeSupplierBySupplier(supplierId);
  }
}
