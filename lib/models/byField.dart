import 'package:cloud_firestore/cloud_firestore.dart';

class ProductByField {
  final String productId;
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

  ProductByField(
      {this.stockUnit,
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

  factory ProductByField.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> Function() data = doc.data;
    return ProductByField(
        productId: data()['productId'] ?? '',
        binderId: data()['binderId'] ?? '',
        name: data()['name'] ?? '',
        desc: data()['desc'] ?? '',
        slug: data()['slug'] ?? '',
        dateAdded: data()['dateAdded'] ?? '',
        dateModified: data()['dateModified'] ?? '',
        categoryId: data()['categoryId'] ?? '',
        brandId: data()['brandId'] ?? '',
        serial: data()['serial'] ?? '',
        model: data()['model'] ?? '',
        sku: data()['sku'] ?? '',
        color: data()['color'] ?? '',
        measure: data()['measure'] ?? '',
        material: data()['material'] ?? '',
        item: data()['item'] ?? '',
        collection: data()['collection'] ?? '',
        tags: data()['tags'] ?? '',
        stockUnit: data()['stockUnit'] ?? '',
        stockDesc: data()['stockDesc'] ?? '',
        stocks: data()['stocks'] ?? 0,
        stockPurchasePrice: data()['stockPurchasePrice'] ?? 0.00,
        stockSRP: data()['stockSRP'] ?? 0.00,
        stockBarcode: data()['stockBarcode'] ?? '',
        stockQRcode: data()['stockQRcode'] ?? '');
  }
}
