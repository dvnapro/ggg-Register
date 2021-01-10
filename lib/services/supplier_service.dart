import 'package:Register/models/bySupplier.dart';
import 'package:Register/models/supplier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSupplierService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //****************** CATEGORY COLLECTION SERVICES ******************/

  Future<void> saveSupplier(Supplier supplier) {
    return _db
        .collection('suppliers')
        .doc(supplier.supplierId)
        .set(supplier.toMap());
  }

  Stream<List<Supplier>> getSuppliers() {
    return _db.collection('suppliers').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Supplier.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeSupplier(String supplierId) {
    return _db.collection('suppliers').doc(supplierId).delete();
  }

  Future<void> saveSupplierBySupplier(SupplierBySupplier supplier) {
    return _db
        .collection('suppliers')
        .doc(supplier.supplierId)
        .set(supplier.toMap());
  }

  Future<void> removeSupplierBySupplier(String supplierId) {
    return _db.collection('suppliers').doc(supplierId).delete();
  }
}
