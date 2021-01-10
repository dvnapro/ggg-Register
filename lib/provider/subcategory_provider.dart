import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:Register/models/subcategory.dart';
import 'package:Register/services/subcategory_service.dart';

class SubCategoryProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  //final Category _category = Category();
  String _name;
  String _desc;
  String _subcategoryId;
  String _slug;
  String _imageURL;
  String _dateAdded;
  String _dateModified;
  String _categoryId;
  String _refDoc;
  var uuid = Uuid();

  String get name => _name;
  String get desc => _desc;
  String get subcategoryId => _subcategoryId;
  String get slug => _slug;
  String get imageURL => _imageURL;
  String get dateAdded => _dateAdded;
  String get dateModified => _dateModified;
  String get categoryId => _categoryId;
  String get refDoc => _refDoc;

  //String get categoryId => _category.categoryId;

  changeName(String value) {
    _name = value;
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

  changeImageURL(String value) {
    _imageURL = value;
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

  changeRefDoc(String value) {
    _refDoc = value;
    notifyListeners();
  }

  changeCategoryId(String value) {
    _categoryId = value;
    notifyListeners();
  }

  loadValues(SubCategory subcategory) {
    _subcategoryId = subcategory.subcategoryId;
    _name = subcategory.name;
    _desc = subcategory.desc;
    _slug = subcategory.slug;
    _imageURL = subcategory.imageURL;
    _dateAdded = subcategory.dateAdded;
    _dateModified = subcategory.dateModified;
    _refDoc = subcategory.refDoc;
  }

  saveSubCategory() {
    print(_subcategoryId);
    if (_subcategoryId == null) {
      var newSubCategory = SubCategory(
          name: name,
          desc: desc,
          slug: slug,
          imageURL: imageURL,
          dateAdded: dateAdded,
          dateModified: dateModified,
          refDoc: refDoc,
          subcategoryId: uuid.v4());
      firestoreService.saveSubCategory(newSubCategory);
    } else {
      var updateSubCategory = SubCategory(
          name: name,
          slug: slug,
          desc: desc,
          imageURL: imageURL,
          dateAdded: dateAdded,
          dateModified: dateModified,
          refDoc: refDoc,
          subcategoryId: subcategoryId);
      firestoreService.saveSubCategory(updateSubCategory);
    }
  }

  removeSubCategory(String collection, String subcategoryId) {
    firestoreService.removeSubCategory(collection, subcategoryId);
  }
}
