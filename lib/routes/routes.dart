import 'package:Register/screens/brand.dart';
import 'package:Register/screens/categories.dart';
import 'package:Register/screens/home.dart';
import 'package:Register/screens/login.dart';
import 'package:Register/screens/product.dart';
import 'package:Register/screens/productbrand.dart';
import 'package:Register/screens/supplier.dart';
import 'package:Register/screens/viewproduct.dart';
import 'package:Register/screens/viewtrans.dart';

class Routes {
  static String dashboard = HomePage.routeName;
  static String products = HomePage.routeName;
  static String categories = CategoryPage.routeName;
  static String brand = BrandPage.routeName;
  static String supplier = SupplierPage.routeName;
  static String reports = HomePage.routeName;
  static String register = HomePage.routeName;
  static String login = LoginPage.routeName;
  static String product = ProductPage.routeName;
  static String viewproduct = ViewProduct.routeName;
  static String viewtrans = ViewTransPage.routeName;
  static String productbrand = ProductBrandPage.routeName;
}
