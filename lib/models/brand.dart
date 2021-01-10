class Brand {
  final String brandId;
  final String brand;
  final String logoUrl;
  final String dateAdded;
  final String dateUpdated;

  Brand(
      {this.brandId,
      this.brand,
      this.logoUrl,
      this.dateAdded,
      this.dateUpdated});

  Map<String, dynamic> toMap() {
    return {
      'brandId': brandId,
      'brand': brand,
      'logoUrl': logoUrl,
      'dateAdded': dateAdded,
      'dateUpdated': dateUpdated,
    };
  }

  Brand.fromFirestore(Map<String, dynamic> firestore)
      : brandId = firestore['brandId'],
        brand = firestore['brand'],
        logoUrl = firestore['logoUrl'],
        dateAdded = firestore['dateAdded'],
        dateUpdated = firestore['dateUpdated'];
}
