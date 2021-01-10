import 'package:Register/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:Register/models/product.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  //final Category _category = Category();
  String _productId;
  String _supplierId;
  String _name;
  String _desc;
  String _slug;
  String _sku;
  String _brand;
  String _serial;
  String _model;
  String _color;
  String _measure;
  String _material;
  String _item;
  String _tags;
  String _dateAdded;
  String _dateModified;
  String _category;
  String _collection;
  String _binder;

  String _stockUnit;
  String _stockDesc;
  int _stocks;
  double _stockPurchasePrice;
  double _stockSRP;
  String _stockBarcode;
  String _stockQRcode;

  var uuid = Uuid();

  String get sku => _sku;
  String get brandId => _brand;
  String get serial => _serial;
  String get model => _model;
  String get color => _color;
  String get measure => _measure;
  String get material => _material;
  String get item => _item;
  String get tags => _tags;
  String get name => _name;
  String get desc => _desc;
  String get productId => _productId;
  String get slug => _slug;
  String get dateAdded => _dateAdded;
  String get dateModified => _dateModified;
  String get categoryId => _category;
  String get supplierId => _supplierId;
  String get collection => _collection;

  String get binderId => _binder;

  String get stockUnit => _stockUnit;
  String get stockDesc => _stockDesc;
  int get stocks => _stocks;
  double get stockPurchasePrice => _stockPurchasePrice;
  double get stockSRP => _stockSRP;
  String get stockBarcode => _stockBarcode;
  String get stockQRcode => _stockQRcode;

  //String get categoryId => _category.categoryId;
  changeProductId(String value) {
    _productId = value;
    notifyListeners();
  }

  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changeBinder(String value) {
    _binder = value;
    notifyListeners();
  }

  changeSupplier(String value) {
    _supplierId = value;
    notifyListeners();
  }

  changeTags(String value) {
    _tags = value;
    notifyListeners();
  }

  changeItem(String value) {
    _item = value;
    notifyListeners();
  }

  changeMeasure(String value) {
    _measure = value;
    notifyListeners();
  }

  changeColor(String value) {
    _color = value;
    notifyListeners();
  }

  changeMaterial(String value) {
    _material = value;
    notifyListeners();
  }

  changeSerial(String value) {
    _serial = value;
    notifyListeners();
  }

  changeModel(String value) {
    _model = value;
    notifyListeners();
  }

  changeCollection(String value) {
    _collection = value;
    notifyListeners();
  }

  changeBrand(String value) {
    _brand = value;
    notifyListeners();
  }

  changeDesc(String value) {
    _desc = value;
    notifyListeners();
  }

  changeSlug(String value) {
    _slug = value;
    notifyListeners();
  }

  changeSku(String value) {
    _sku = value;
    notifyListeners();
  }

  changeDateModified(String value) {
    _dateModified = value;
    notifyListeners();
  }

  changeDateAdded(String value) {
    _dateAdded = value;
    notifyListeners();
  }

  changeCategory(String value) {
    _category = value;
    notifyListeners();
  }

  changeStockUnit(String value) {
    _stockUnit = value;
    notifyListeners();
  }

  changeStockDesc(String value) {
    _stockDesc = value;
    notifyListeners();
  }

  changeStocks(int value) {
    _stocks = value;
    notifyListeners();
  }

  changeStockPurchasePrice(double value) {
    _stockPurchasePrice = value;
    notifyListeners();
  }

  changeStockSRP(double value) {
    _stockSRP = value;
    notifyListeners();
  }

  changeStockBarcode(String value) {
    _stockBarcode = value;
    notifyListeners();
  }

  changeStockQRcode(String value) {
    _stockQRcode = value;
    notifyListeners();
  }

  loadValues(Product product) {
    _productId = product.productId;
    _name = product.name;
    _desc = product.desc;
    _binder = product.binderId;
    _slug = product.slug;
    _dateAdded = product.dateAdded;
    _dateModified = product.dateModified;
    _sku = product.sku;
    _brand = product.brandId;
    _category = product.categoryId;
    _serial = product.serial;
    _model = product.model;
    _color = product.color;
    _measure = product.measure;
    _material = product.material;
    _item = product.item;
    _tags = product.tags;
    _collection = product.collection;
    _supplierId = product.supplierId;

    _stockUnit = product.stockUnit;
    _stockDesc = product.stockDesc;
    _stocks = product.stocks;
    _stockPurchasePrice = product.stockPurchasePrice;
    _stockSRP = product.stockSRP;
    _stockBarcode = product.stockBarcode;
    _stockQRcode = product.stockQRcode;
  }

  saveProduct() {
    print(_productId);
    if (_productId == null) {
      var newProduct = Product(
          name: name,
          desc: desc,
          slug: slug,
          supplierId: supplierId,
          dateAdded: dateAdded,
          dateModified: dateModified,
          sku: sku,
          brandId: brandId,
          categoryId: categoryId,
          serial: serial,
          model: model,
          color: color,
          measure: measure,
          material: material,
          item: item,
          tags: tags,
          collection: collection,
          stockUnit: stockUnit,
          stockDesc: stockDesc,
          stocks: stocks,
          stockPurchasePrice: stockPurchasePrice,
          stockSRP: stockSRP,
          stockBarcode: stockBarcode,
          stockQRcode: stockQRcode,
          binderId: binderId,
          productId: uuid.v4());
      firestoreService.saveProduct(newProduct);
    } else {
      var updateProduct = Product(
          name: name,
          supplierId: supplierId,
          slug: slug,
          desc: desc,
          dateAdded: dateAdded,
          dateModified: dateModified,
          binderId: binderId,
          sku: sku,
          brandId: brandId,
          categoryId: categoryId,
          serial: serial,
          model: model,
          color: color,
          measure: measure,
          material: material,
          item: item,
          collection: collection,
          tags: tags,
          stockUnit: stockUnit,
          stockDesc: stockDesc,
          stocks: stocks,
          stockPurchasePrice: stockPurchasePrice,
          stockSRP: stockSRP,
          stockBarcode: stockBarcode,
          stockQRcode: stockQRcode,
          productId: productId);
      firestoreService.saveProduct(updateProduct);
    }
  }

  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}
