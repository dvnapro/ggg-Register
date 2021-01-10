//import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String productId;
  final String supplierId;
  final String name;
  final String desc;
  final String slug;
  final String sku;
  final String brandId;
  final String serial;
  final String model;
  final String color;
  final String measure;
  final String material;
  final String item;
  final String tags;
  final String dateAdded;
  final String dateModified;
  final String categoryId;
  final String collection;
  final String binderId;

  final String stockUnit;
  final String stockDesc;
  final int stocks;
  final double stockPurchasePrice;
  final double stockSRP;
  final String stockBarcode;
  final String stockQRcode;

  Product(
      {this.stockUnit,
      this.supplierId,
      this.stockDesc,
      this.stocks,
      this.stockPurchasePrice,
      this.stockSRP,
      this.stockBarcode,
      this.stockQRcode,
      this.brandId,
      this.binderId,
      this.serial,
      this.model,
      this.sku,
      this.color,
      this.measure,
      this.material,
      this.item,
      this.tags,
      this.productId,
      this.desc,
      this.name,
      this.slug,
      this.dateAdded,
      this.dateModified,
      this.collection,
      this.categoryId});

  Map<String, dynamic> toMap() {
    return {
      'sku': sku,
      'color': color,
      'measure': measure,
      'material': material,
      'item': item,
      'brandId': brandId,
      'serial': serial,
      'model': model,
      'tags': tags,
      'productId': productId,
      'supplierId': supplierId,
      'name': name,
      'desc': desc,
      'slug': slug,
      'dateAdded': dateAdded,
      'dateModified': dateModified,
      'categoryId': categoryId,
      'collection': collection,
      'stockUnit': stockUnit,
      'stockDesc': stockDesc,
      'stocks': stocks,
      'stockPurchasePrice': stockPurchasePrice,
      'stockSRP': stockSRP,
      'stockBarcode': stockBarcode,
      'stockQRcode': stockQRcode,
      'binderId': binderId,
    };
  }

  Product.fromFirestore(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        binderId = firestore['binderId'],
        supplierId = firestore['supplierId'],
        name = firestore['name'],
        desc = firestore['desc'],
        slug = firestore['slug'],
        dateAdded = firestore['dateAdded'],
        dateModified = firestore['dateModified'],
        categoryId = firestore['categoryId'],
        brandId = firestore['brandId'],
        serial = firestore['serial'],
        model = firestore['model'],
        sku = firestore['sku'],
        color = firestore['color'],
        measure = firestore['measure'],
        material = firestore['material'],
        item = firestore['item'],
        collection = firestore['collection'],
        tags = firestore['tags'],
        stockUnit = firestore['stockUnit'],
        stockDesc = firestore['stockDesc'],
        stocks = firestore['stocks'],
        stockPurchasePrice = firestore['stockPurchasePrice'],
        stockSRP = firestore['stockSRP'],
        stockBarcode = firestore['stockBarcode'],
        stockQRcode = firestore['stockQRcode'];
}
