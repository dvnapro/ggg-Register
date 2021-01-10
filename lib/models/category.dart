class Category {
  final String categoryId;
  final String name;
  final String desc;
  final String slug;
  final String imageURL;
  final String dateAdded;
  final String dateModified;
  final String collection;

  Category(
      {this.categoryId,
      this.desc,
      this.name,
      this.slug,
      this.imageURL,
      this.dateAdded,
      this.dateModified,
      this.collection});

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'name': name,
      'desc': desc,
      'slug': slug,
      'imageURL': imageURL,
      'dateAdded': dateAdded,
      'dateModified': dateModified,
      'collection': collection,
    };
  }

  Category.fromFirestore(Map<String, dynamic> firestore)
      : categoryId = firestore['categoryId'],
        name = firestore['name'],
        desc = firestore['desc'],
        slug = firestore['slug'],
        imageURL = firestore['imageURL'],
        dateAdded = firestore['dateAdded'],
        collection = firestore['collection'],
        dateModified = firestore['dateModified'];
}
