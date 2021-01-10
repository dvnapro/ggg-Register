import 'package:Register/models/brand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreBrandService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //****************** CATEGORY COLLECTION SERVICES ******************/

  Future<void> saveBrand(Brand brand) {
    return _db.collection('brands').doc(brand.brandId).set(brand.toMap());
  }

  Stream<List<Brand>> getBrands() {
    return _db.collection('brands').orderBy('brand').snapshots().map(
        (snapshot) => snapshot.docs
            .map((document) => Brand.fromFirestore(document.data()))
            .toList());
  }

  Future<void> removeBrand(String brandId) {
    return _db.collection('brands').doc(brandId).delete();
  }
}
