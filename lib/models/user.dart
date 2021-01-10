class UserData {
  final String userId;
  final String role;
  final String status;
  final String imgUrl;
  final String dateCreated;
  final String dateModified;

  UserData(
      {this.userId,
      this.role,
      this.status,
      this.imgUrl,
      this.dateCreated,
      this.dateModified});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'role': role,
      'status': status,
      'imgUrl': imgUrl,
      'dateCreated': dateCreated,
      'dateModified': dateModified,
    };
  }

  UserData.fromFirestore(Map<String, dynamic> firestore)
      : userId = firestore['userId'],
        role = firestore['role'],
        status = firestore['status'],
        imgUrl = firestore['imgUrl'],
        dateCreated = firestore['dateCreated'],
        dateModified = firestore['dateModified'];
}
