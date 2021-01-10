class SubCategory {
  final String subcategoryId;
  final String name;
  final String desc;
  final String slug;
  final String imageURL;
  final String dateAdded;
  final String dateModified;
  final String refDoc;
  final String categoryId;

  SubCategory(
      {this.subcategoryId,
      this.desc,
      this.name,
      this.slug,
      this.imageURL,
      this.dateAdded,
      this.dateModified,
      this.refDoc,
      this.categoryId});

  Map<String, dynamic> toMap() {
    return {
      'subcategoryId': subcategoryId,
      'name': name,
      'desc': desc,
      'slug': slug,
      'imageURL': imageURL,
      'dateAdded': dateAdded,
      'dateModified': dateModified,
      'refDoc': refDoc,
      'categoryId': categoryId,
    };
  }

  SubCategory.fromFirestore(Map<String, dynamic> firestore)
      : subcategoryId = firestore['subcategoryId'],
        name = firestore['name'],
        desc = firestore['desc'],
        slug = firestore['slug'],
        imageURL = firestore['imageURL'],
        dateAdded = firestore['dateAdded'],
        dateModified = firestore['dateModified'],
        categoryId = firestore['categoryId'],
        refDoc = firestore['refdoc'];
}
