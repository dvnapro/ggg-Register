import 'package:Register/methods/auth.dart';
import 'package:Register/provider/brand_provider.dart';
import 'package:Register/provider/byfield_provider.dart';
import 'package:Register/provider/cart_provider.dart';
import 'package:Register/provider/category_provider.dart';
import 'package:Register/provider/product_log_provider.dart';
import 'package:Register/provider/product_photo_provider.dart';
import 'package:Register/provider/product_pp_log.dart';
import 'package:Register/provider/product_provider.dart';
import 'package:Register/provider/product_srp_log.dart';
import 'package:Register/provider/product_stocks_log_provider.dart';
import 'package:Register/provider/supplier_provider.dart';
import 'package:Register/provider/trans_provider.dart';
import 'package:Register/screens/brand.dart';
import 'package:Register/screens/categories.dart';
import 'package:Register/screens/product.dart';
import 'package:Register/screens/productbrand.dart';
import 'package:Register/screens/supplier.dart';
import 'package:Register/screens/viewproduct.dart';
import 'package:Register/screens/viewtrans.dart';
import 'package:Register/services/auth_service.dart';
import 'package:Register/services/brand_service.dart';
import 'package:Register/services/firestore_service.dart';
import 'package:Register/services/supplier_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import 'screens/login.dart';

class Register extends StatelessWidget {
  get collection => null;

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    final fbs = FirestoreBrandService();
    final fss = FirestoreSupplierService();
    //final fps = FirestoreProductService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ProductByFieldProvider()),
        ChangeNotifierProvider(create: (context) => ProductPhotoProvider()),
        ChangeNotifierProvider(create: (context) => BrandProvider()),
        ChangeNotifierProvider(create: (context) => SupplierProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ProductLogProvider()),
        ChangeNotifierProvider(create: (context) => SRPLogProvider()),
        ChangeNotifierProvider(create: (context) => PurchasePriceLogProvider()),
        ChangeNotifierProvider(create: (context) => StocksLogProvider()),
        ChangeNotifierProvider(create: (context) => ProductTransProvider()),
        StreamProvider(create: (context) => firestoreService.getCategorys()),
        StreamProvider(create: (context) => firestoreService.getProducts()),
        StreamProvider(create: (context) => firestoreService.getTransactions()),
        StreamProvider(
            create: (context) => firestoreService.getProductPhotos()),
        StreamProvider(create: (context) => fss.getSuppliers()),
        StreamProvider(create: (context) => fbs.getBrands()),
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'GGG Cycles Cashier Register',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //primarySwatch: Colors.deepOrange,
          primaryColor: Colors.teal,
          accentColor: Colors.teal,
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: HomePage(),
        home: AuthenticationWrapper(),
        //initialRoute: '/login',
        routes: {
          '/categories': (context) => CategoryPage(),
          '/login': (context) => LoginPage(),
          '/dashboard': (context) => HomePage(),
          '/supplier': (context) => SupplierPage(),
          '/product': (context) => ProductPage(),
          '/productbrand': (context) => ProductBrandPage(),
          '/brand': (context) => BrandPage(),
          '/viewproduct': (context) => ViewProduct(),
          '/viewtrans': (context) => ViewTransPage(),
        },
        //onGenerateRoute: _getRoute,
      ),
    );
  }
}

class StockLogProvider {}
