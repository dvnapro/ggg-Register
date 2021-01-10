class CategoryArgs {
  //final Category category;
  final String catId;
  final String catname;
  final String catslug;

  CategoryArgs(this.catId, this.catname, this.catslug);
}

class BrandArgs {
  final String brand;
  final String brandId;

  BrandArgs(this.brand, this.brandId);
}

class Args {
  final String catId;
  final String catname;
  final String catslug;
  final String brand;
  final String brandId;

  Args(this.catId, this.catname, this.catslug, this.brand, this.brandId);
}
