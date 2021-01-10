import 'package:Register/models/brand.dart';
import 'package:Register/services/brand_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class BrandProvider with ChangeNotifier {
  final fbs = FirestoreBrandService();
  String _brandId;
  String _brand;
  String _logoUrl;
  String _dateAdded;
  String _dateUpdated;
  var uuid = Uuid();

  String get brandId => _brandId;
  String get brand => _brand;
  String get logoUrl => _logoUrl;
  String get dateAdded => _dateAdded;
  String get dateUpdated => _dateUpdated;

  changeBrandId(String val) {
    _brandId = val;
    notifyListeners();
  }

  changeBrand(String val) {
    _brand = val;
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

  loadValues(Brand brand) {
    _brandId = brand.brandId;
    _brand = brand.brand;
    _logoUrl = brand.logoUrl;
    _dateUpdated = brand.dateUpdated;
    _dateAdded = brand.dateAdded;
  }

  saveBrand() {
    print(_brandId);
    if (_brandId == null) {
      var newBrand = Brand(
          brand: brand,
          logoUrl: logoUrl,
          dateAdded: dateAdded,
          dateUpdated: dateUpdated,
          brandId: uuid.v4());
      fbs.saveBrand(newBrand);
    } else {
      var updateBrand = Brand(
          brand: brand,
          logoUrl: logoUrl,
          dateAdded: dateAdded,
          dateUpdated: dateUpdated,
          brandId: brandId);
      fbs.saveBrand(updateBrand);
    }
  }

  removeBrand(String brand) {
    fbs.removeBrand(brandId);
  }
}
