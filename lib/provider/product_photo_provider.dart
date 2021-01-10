import 'package:Register/models/product_photos.dart';
import 'package:Register/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ProductPhotoProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _photoId;
  String _title;
  String _type;
  String _url;
  String _dateAdded;
  String _collection;
  String _binderId;
  var uuid = Uuid();

  String get photoId => _photoId;
  String get title => _title;
  String get binderId => _binderId;
  String get type => _type;
  String get url => _url;
  String get dateAdded => _dateAdded;
  String get collection => _collection;

  changePhotoId(String value) {
    _photoId = value;
    notifyListeners();
  }

  changeTitle(String value) {
    _title = value;
    notifyListeners();
  }

  changeType(String value) {
    _type = value;
    notifyListeners();
  }

  changeUrl(String value) {
    _url = value;
    notifyListeners();
  }

  changeBindId(String value) {
    _binderId = value;
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

  loadValues(ProductPhoto producti) {
    _photoId = producti.photoId;
    _title = producti.title;
    _type = producti.type;
    _url = producti.url;
    _dateAdded = producti.dateAdded;
    _collection = producti.collection;
  }

  saveProductPhoto() {
    print(_photoId);
    if (_photoId == null) {
      var newPhoto = ProductPhoto(
          photoId: uuid.v4(),
          title: title,
          type: type,
          url: url,
          dateAdded: dateAdded,
          collection: collection,
          binderId: binderId);
      firestoreService.saveProductPhoto(newPhoto);
      //return photoId;
    } else {
      var updatePhoto = ProductPhoto(
          photoId: _photoId,
          title: title,
          type: type,
          url: url,
          dateAdded: dateAdded,
          collection: collection,
          binderId: binderId);
      firestoreService.saveProductPhoto(updatePhoto);
    }
  }

  removeProductPhoto(String photoId) {
    firestoreService.removeProductPhoto(photoId);
  }
}
