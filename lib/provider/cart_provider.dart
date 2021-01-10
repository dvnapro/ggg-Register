import 'package:Register/services/firestore_service.dart';
import 'package:Register/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _cartId;
  String _productId;
  String _transId;
  String _binderId;
  String _product;
  String _unit;
  String _barcode;
  int _oldStocks;
  int _newStocks;
  int _units;
  double _discount;
  double _discountedPrice;
  double _discountPrice;
  double _srp;
  double _totalPrice;
  String _transDate;
  String _remark;
  String _remarkBy;
  String _remarkDate;
  var uuid = Uuid();

  String get cartId => _cartId;
  String get transId => _transId;
  String get productId => _productId;
  String get binderId => _binderId;
  String get product => _product;
  String get unit => _unit;
  String get barcode => _barcode;
  int get oldStocks => _oldStocks;
  int get newStocks => _newStocks;
  String get transDate => _transDate;
  int get units => _units;
  double get srp => _srp;
  double get discount => _discount;
  double get discountPrice => _discountPrice;
  double get discountedPrice => _discountedPrice;
  double get totalPrice => _totalPrice;
  String get remark => _remark;
  String get remarkBy => _remarkBy;
  String get remarkDate => _remarkDate;

  changeCartId(String value) {
    _cartId = value;
    notifyListeners();
  }

  changeTransId(String value) {
    _transId = value;
    notifyListeners();
  }

  changeProductId(String value) {
    _productId = value;
    notifyListeners();
  }

  changeBinderId(String value) {
    _binderId = value;
    notifyListeners();
  }

  changeProduct(String value) {
    _product = value;
    notifyListeners();
  }

  changeUnit(String value) {
    _unit = value;
    notifyListeners();
  }

  changeBarcode(String value) {
    _barcode = value;
    notifyListeners();
  }

  changeOldStocks(int value) {
    _oldStocks = value;
    notifyListeners();
  }

  changeNewStocks(int value) {
    _newStocks = value;
    notifyListeners();
  }

  changeTransDate(String value) {
    _transDate = value;
    notifyListeners();
  }

  changeUnits(int value) {
    _units = value;
    notifyListeners();
  }

  changeSRP(double value) {
    _srp = value;
    notifyListeners();
  }

  changeDiscount(double value) {
    _discount = value;
    notifyListeners();
  }

  changeDiscountPrice(double value) {
    _discountPrice = value;
    notifyListeners();
  }

  changeDiscountedPrice(double value) {
    _discountPrice = value;
    notifyListeners();
  }

  changeTotalPrice(double value) {
    _totalPrice = value;
    notifyListeners();
  }

  changeRemark(String value) {
    _remark = value;
    notifyListeners();
  }

  changeRemarkBy(String value) {
    _remarkBy = value;
    notifyListeners();
  }

  changeRemarkDate(String value) {
    _remarkDate = value;
    notifyListeners();
  }

  loadValues(Cart cart) {
    _cartId = cart.cartId;
    _transId = cart.transId;
    _productId = cart.productId;
    _binderId = cart.binderId;
    _product = cart.product;
    _unit = cart.unit;
    _barcode = cart.barcode;
    _oldStocks = cart.oldStocks;
    _newStocks = cart.newStocks;
    _srp = cart.srp;
    _discount = cart.discount;
    _discountPrice = cart.discountPrice;
    _discountedPrice = cart.discountedPrice;
    _units = cart.units;
    _totalPrice = cart.totalPrice;
    _transDate = cart.transDate;
    _remark = cart.remark;
    _remarkBy = cart.remarkBy;
    _remarkDate = cart.remarkDate;
  }

  saveCart() {
    print(_cartId);
    if (_cartId == null) {
      var newCart = Cart(
          cartId: uuid.v4(),
          transId: transId,
          productId: productId,
          binderId: binderId,
          product: product,
          unit: unit,
          barcode: barcode,
          oldStocks: oldStocks,
          newStocks: newStocks,
          srp: srp,
          discount: discount,
          discountPrice: discountPrice,
          discountedPrice: discountedPrice,
          units: units,
          totalPrice: totalPrice,
          remark: remark,
          remarkDate: remarkDate,
          remarkBy: remarkBy,
          transDate: transDate);
      firestoreService.saveCart(newCart);
    } else {
      var updateCart = Cart(
          cartId: cartId,
          transId: transId,
          productId: productId,
          binderId: binderId,
          product: product,
          unit: unit,
          barcode: barcode,
          oldStocks: oldStocks,
          newStocks: newStocks,
          srp: srp,
          discount: discount,
          discountPrice: discountPrice,
          discountedPrice: discountedPrice,
          units: units,
          totalPrice: totalPrice,
          remark: remark,
          remarkDate: remarkDate,
          remarkBy: remarkBy,
          transDate: transDate);
      firestoreService.saveCart(updateCart);
    }
  }

  removeCart(String cartId, String transId) {
    firestoreService.removeCart(cartId, transId);
  }
}
