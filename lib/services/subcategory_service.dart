import 'package:Register/models/subcategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveSubCategory(SubCategory subcategory) {
    return _db
        .collection(subcategory.refDoc)
        .doc(subcategory.subcategoryId)
        .set(subcategory.toMap());
  }

  Stream<List<SubCategory>> getSubCategorys(collection) {
    return _db.collection(collection).snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => SubCategory.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeSubCategory(String collection, String subcategoryId) {
    return _db.collection(collection).doc(subcategoryId).delete();
  }
}
