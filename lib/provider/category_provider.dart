import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:Register/models/category.dart';
import 'package:Register/services/firestore_service.dart';

class CategoryProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  //var now = new DateTime.now();
  String _name;
  String _desc;
  String _categoryId;
  String _slug;
  String _imageURL;
  String _dateAdded;
  String _dateModified;
  String _collection;
  var uuid = Uuid();

  String get name => _name;
  String get desc => _desc;
  String get categoryId => _categoryId;
  String get slug => _slug;
  String get imageURL => _imageURL;
  String get dateAdded => _dateAdded;
  String get dateModified => _dateModified;
  String get collection => _collection;

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

  changeCollection(String value) {
    _collection = value;
    notifyListeners();
  }

  loadValues(Category category) {
    _categoryId = category.categoryId;
    _name = category.name;
    _desc = category.desc;
    _slug = category.slug;
    _imageURL = category.imageURL;
    _dateAdded = category.dateAdded;
    _dateModified = category.dateModified;
    _collection = category.collection;
  }

  saveCategory() {
    print(_categoryId);
    if (_categoryId == null) {
      var newCategory = Category(
          name: name,
          desc: desc,
          slug: slug,
          imageURL: imageURL,
          dateAdded: dateAdded,
          dateModified: dateModified,
          collection: collection,
          categoryId: uuid.v4());
      firestoreService.saveCategory(newCategory);
    } else {
      var updateCategory = Category(
          name: name,
          slug: slug,
          desc: desc,
          imageURL: imageURL,
          dateAdded: dateAdded,
          dateModified: dateModified,
          categoryId: categoryId,
          collection: collection);
      firestoreService.saveCategory(updateCategory);
    }
  }

  removeCategory(String categoryId) {
    firestoreService.removeCategory(categoryId);
  }
}
