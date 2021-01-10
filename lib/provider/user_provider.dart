import 'package:flutter/material.dart';
import 'package:Register/models/user.dart';
import 'package:Register/services/firestore_service.dart';

class UserDataProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _userId;
  String _role;
  String _status;
  String _imgUrl;
  String _dateCreated;
  String _dateModified;

  String get userId => _userId;
  String get role => _role;
  String get status => _status;
  String get imgUrl => _imgUrl;
  String get dateCreated => _dateCreated;
  String get dateModified => _dateModified;

  changeRole(String value) {
    _role = value;
    notifyListeners();
  }

  changeStatus(String value) {
    _status = value;
    notifyListeners();
  }

  changeImgUrl(String value) {
    _imgUrl = value;
    notifyListeners();
  }

  changeDateModified(String value) {
    _dateModified = value;
    notifyListeners();
  }

  loadValues(UserData user) {
    _userId = user.userId;
    _role = user.role;
    _status = user.status;
    _imgUrl = user.imgUrl;
    _dateCreated = user.dateCreated;
    _dateModified = user.dateModified;
  }

  updateUser() {
    print(_userId);
    var editUser = UserData(
        role: role,
        status: status,
        imgUrl: imgUrl,
        dateModified: dateModified,
        userId: userId);
    firestoreService.updateUser(editUser);
  }

  removeUser(String userId) {
    firestoreService.removeUser(userId);
  }
}
