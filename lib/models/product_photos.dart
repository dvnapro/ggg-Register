class ProductPhoto {
  final String photoId;
  final String title;
  final String type;
  final String url;
  final String dateAdded;
  final String collection;
  final String binderId;

  ProductPhoto(
      {this.photoId,
      this.binderId,
      this.title,
      this.type,
      this.url,
      this.dateAdded,
      this.collection});

  Map<String, dynamic> toMap() {
    return {
      'photoId': photoId,
      'title': title,
      'binderId': binderId,
      'type': type,
      'url': url,
      'dateAdded': dateAdded,
      'collection': collection,
    };
  }

  ProductPhoto.fromFirestore(Map<String, dynamic> firestore)
      : photoId = firestore['photoId'],
        title = firestore['title'],
        type = firestore['type'],
        binderId = firestore['binderId'],
        url = firestore['url'],
        dateAdded = firestore['dateAdded'],
        collection = firestore['collection'];
}
