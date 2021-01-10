import 'package:Register/models/byField.dart';
import 'package:Register/models/bycategory.dart';
import 'package:Register/models/cart.dart';
import 'package:Register/models/pplog.dart';
import 'package:Register/models/product.dart';
import 'package:Register/models/srplog.dart';
import 'package:Register/models/stockslog.dart';
import 'package:Register/models/transaction.dart';
import 'package:Register/models/product_logs.dart';
import 'package:Register/models/product_photos.dart';
import 'package:Register/models/user.dart';
import 'package:Register/models/category.dart';
import 'package:Register/routes/args/args.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //****************** CATEGORY COLLECTION SERVICES ******************/

  Future<void> saveCategory(Category category) {
    return _db
        .collection('categories')
        .doc(category.categoryId)
        .set(category.toMap());
  }

  Stream<List<Category>> getCategorys() {
    return _db.collection('categories').orderBy('name').snapshots().map(
        (snapshot) => snapshot.docs
            .map((document) => Category.fromFirestore(document.data()))
            .toList());
  }

  Future<void> removeCategory(String categoryId) {
    return _db.collection('categories').doc(categoryId).delete();
  }

  //************** SUBCATEGORY COLLECTION SERVICES ***************/

  //****************** USER COLLECTION SERVICES ******************/

  Stream<List<UserData>> getUsers() {
    return _db.collection('users').snapshots().map((snapshot) => snapshot.docs
        .map((document) => UserData.fromFirestore(document.data()))
        .toList());
  }

  Future<void> updateUser(UserData user) {
    return _db.collection('users').doc(user.userId).set(user.toMap());
  }

  Future<void> removeUser(String userId) {
    return _db.collection('users').doc(userId).delete();
  }

  Future<void> saveProduct(Product product) {
    return _db.collection('items').doc(product.productId).set(product.toMap());
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('items').orderBy('name').snapshots().map((snapshot) =>
        snapshot.docs
            .map((document) => Product.fromFirestore(document.data()))
            .toList());
  }

  Future<void> removeProduct(String productId) {
    return _db.collection('items').doc(productId).delete();
  }

////************* PRODUCT PHOTOS ***************/
  Future<void> saveProductPhoto(ProductPhoto photos) {
    return _db
        .collection('productphotos')
        .doc(photos.photoId)
        .set(photos.toMap());
  }

  Stream<List<ProductPhoto>> getProductPhotos() {
    return _db.collection('productphotos').snapshots().map((snapshot) =>
        snapshot.docs
            .map((document) => ProductPhoto.fromFirestore(document.data()))
            .toList());
  }

  Future<void> removeProductPhoto(String photoId) {
    return _db.collection('productphotos').doc(photoId).delete();
  }

  Stream<List<ProductByCategory>> byCategory(CategoryArgs args) {
    var ref =
        _db.collection('items').where('categoryId', isEqualTo: args.catname);

    return ref.snapshots().map((item) =>
        item.docs.map((doc) => ProductByCategory.fromFirestore(doc)).toList());
  }

  Stream<List<ProductByField>> byField(String field, String value) {
    var ref = _db.collection('items').where(field, isEqualTo: value);

    return ref.snapshots().map((item) =>
        item.docs.map((doc) => ProductByField.fromFirestore(doc)).toList());
  }

  Stream<List<ProductByField>> byFieldNull(String field, bool value) {
    var ref = _db.collection('items').where(field, isNull: value);

    return ref.snapshots().map((item) =>
        item.docs.map((doc) => ProductByField.fromFirestore(doc)).toList());
  }

  Stream<List<ProductByField>> byFieldNotNull(String field, String value) {
    var ref = _db.collection('items').where(field, isGreaterThan: 0);

    return ref.snapshots().map((item) =>
        item.docs.map((doc) => ProductByField.fromFirestore(doc)).toList());
  }

  Stream<List<ProductByField>> byFieldLow(String field, int value) {
    var ref = _db.collection('items').where(field, isLessThanOrEqualTo: value);

    return ref.snapshots().map((item) =>
        item.docs.map((doc) => ProductByField.fromFirestore(doc)).toList());
  }

  Future<void> saveProductByField(ProductByField product) {
    return _db.collection('items').doc(product.productId).set(product.toMap());
  }

  Future<void> removeProductByField(String productId) {
    return _db.collection('items').doc(productId).delete();
  }

  Future<void> saveProductLog(ProductLog log) {
    return _db.collection('plogs').doc(log.logId).set(log.toMap());
  }

  Future<void> saveProductTrans(ProductTrans trans) {
    return _db.collection('transx').doc(trans.transId).set(trans.toMap());
  }

  Stream<List<ProductTrans>> getTransactions() {
    var ref = _db.collection('transx');

    return ref.snapshots().map((trans) =>
        trans.docs.map((doc) => ProductTrans.fromFirestore(doc)).toList());
  }

  Stream<List<ProductTrans>> byDate(String transId1, String transId2) {
    var ref = _db
        .collection('transx')
        .where('transDate', isGreaterThanOrEqualTo: transId1)
        .where('transDate', isLessThanOrEqualTo: transId1);

    return ref.snapshots().map((trans) =>
        trans.docs.map((doc) => ProductTrans.fromFirestore(doc)).toList());
  }

  Stream<List<ProductTrans>> byToday(String today) {
    var ref = _db.collection('transx').where('transDate', isEqualTo: today);

    return ref.snapshots().map((trans) =>
        trans.docs.map((doc) => ProductTrans.fromFirestore(doc)).toList());
  }

  Stream<List<ProductTrans>> byTransField(String field, String transId) {
    var ref = _db.collection('transx').where(field, isEqualTo: transId);

    return ref.snapshots().map((trans) =>
        trans.docs.map((doc) => ProductTrans.fromFirestore(doc)).toList());
  }

  Future<void> removeTrans(String id) {
    return _db.collection('transx').doc(id).delete();
  }

  Stream<List<Cart>> getCartByTransId(String transId) {
    var ref = _db
        .collection('transx')
        .doc(transId)
        .collection('cart')
        .where('transId', isEqualTo: transId);

    return ref.snapshots().map(
        (cart) => cart.docs.map((doc) => Cart.fromFirestore(doc)).toList());
  }

  Future<void> saveCart(Cart cart) {
    return _db
        .collection('transx')
        .doc(cart.transId)
        .collection('cart')
        .doc(cart.cartId)
        .set(cart.toMap());
  }

  Future<void> removeCart(String cartId, String transId) {
    return _db
        .collection('transx')
        .doc(transId)
        .collection('cart')
        .doc(cartId)
        .delete();
  }

  Future<void> saveStocksLog(StocksLog log) {
    return _db
        .collection('items')
        .doc(log.productId)
        .collection('stocklogs')
        .doc(log.logId)
        .set(log.toMap());
  }

  Future<void> removeStocksLog(String logId, String productId) {
    return _db
        .collection('items')
        .doc(productId)
        .collection('stocklogs')
        .doc(logId)
        .delete();
  }

  Future<void> saveSRPLog(SRPLog log) {
    return _db
        .collection('items')
        .doc(log.productId)
        .collection('srplogs')
        .doc(log.logId)
        .set(log.toMap());
  }

  Future<void> removeSRPLog(String logId, String productId) {
    return _db
        .collection('items')
        .doc(productId)
        .collection('srplogs')
        .doc(logId)
        .delete();
  }

  Future<void> savePurchasePriceLog(PurchasePriceLog log) {
    return _db
        .collection('items')
        .doc(log.productId)
        .collection('pplogs')
        .doc(log.logId)
        .set(log.toMap());
  }

  Future<void> removePurchasePriceLog(String logId, String productId) {
    return _db
        .collection('items')
        .doc(productId)
        .collection('pplogs')
        .doc(logId)
        .delete();
  }
}
