import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierBySupplier {
  final String company;
  final String supplierId;
  final String supplierContactPerson;
  final String supplierContactNo;
  final String supplierEmail;
  final String supplierAddress;
  final String logoUrl;
  final String dateAdded;
  final String dateUpdated;

  SupplierBySupplier(
      {this.company,
      this.supplierId,
      this.supplierContactPerson,
      this.supplierContactNo,
      this.supplierEmail,
      this.supplierAddress,
      this.logoUrl,
      this.dateAdded,
      this.dateUpdated});

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'supplierId': supplierId,
      'supplierContactPerson': supplierContactPerson,
      'supplierContactNo': supplierContactNo,
      'supplierEmail': supplierEmail,
      'supplierAddress': supplierAddress,
      'logoUrl': logoUrl,
      'dateAdded': dateAdded,
      'dateUpdated': dateUpdated,
    };
  }

  // SupplierBySupplier.fromFirestore(Map<String, dynamic> firestore)
  //     : company = firestore['company'],
  //       supplierId = firestore['supplierId'],
  //       supplierAddress = firestore['supplierAddress'],
  //       supplierContactNo = firestore['supplierContactNo'],
  //       supplierContactPerson = firestore['supplierContactPerson'],
  //       supplierEmail = firestore['supplierEmail'],
  //       logoUrl = firestore['logoUrl'],
  //       dateAdded = firestore['dateAdded'],
  //       dateUpdated = firestore['dateUpdated'];
  factory SupplierBySupplier.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> Function() data = doc.data;
    return SupplierBySupplier(
      company: data()['company'] ?? '',
      supplierId: data()['supplierId'] ?? '',
      supplierAddress: data()['supplierAddress'] ?? '',
      supplierContactNo: data()['supplierContacNo'] ?? '',
      supplierEmail: data()['supplierEmail'] ?? '',
      supplierContactPerson: data()['supplierContactPerson'] ?? '',
      logoUrl: data()['logoUrl'] ?? '',
      dateAdded: data()['dateAdded'] ?? '',
      dateUpdated: data()['dateUpdated'] ?? '',
    );
  }
}
