import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  final String cartId;
  final String transId;
  final String productId;
  final String binderId;
  final String product;
  final String unit;
  final String barcode;
  final int oldStocks;
  final int newStocks;
  final int units;
  final double srp;
  final double discount;
  final double discountPrice;
  final double discountedPrice;
  final double totalPrice;
  final String transDate;
  final String remark;
  final String remarkDate;
  final String remarkBy;

  Cart(
      {this.transId,
      this.cartId,
      this.productId,
      this.barcode,
      this.product,
      this.binderId,
      this.oldStocks,
      this.newStocks,
      this.units,
      this.unit,
      this.srp,
      this.discount,
      this.discountPrice,
      this.discountedPrice,
      this.totalPrice,
      this.transDate,
      this.remark,
      this.remarkBy,
      this.remarkDate});

  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'transId': transId,
      'productId': productId,
      'barcode': barcode,
      'product': product,
      'binderId': binderId,
      'oldStocks': oldStocks,
      'newStocks': newStocks,
      'unit': unit,
      'units': units,
      'srp': srp,
      'discount': discount,
      'discountPrice': discountPrice,
      'discountedPrice': discountedPrice,
      'totalPrice': totalPrice,
      'transDate': transDate,
      'remark': remark,
      'remarkBy': remarkBy,
      'remarkDate': remarkDate
    };
  }

  factory Cart.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> Function() data = doc.data;
    return Cart(
        cartId: data()['cartId'] ?? '',
        transId: data()['transId'] ?? '',
        binderId: data()['binderId'] ?? '',
        productId: data()['productId'] ?? '',
        product: data()['product'] ?? '',
        barcode: data()['barcode'] ?? '',
        oldStocks: data()['oldStocks'] ?? 0,
        newStocks: data()['newStock'] ?? 0,
        unit: data()['unit'] ?? '',
        units: data()['units'] ?? 0,
        srp: data()['srp'] ?? 0.00,
        discount: data()['discount'] ?? 0.00,
        discountPrice: data()['discountPrice'] ?? 0.00,
        discountedPrice: data()['discountedPrice'] ?? 0.00,
        totalPrice: data()['totalPrice'] ?? 0.00,
        transDate: data()['transDate'] ?? '',
        remark: data()['remark'] ?? '',
        remarkBy: data()['remarkBy'] ?? '',
        remarkDate: data()['remarkDate'] ?? '');
  }
}
