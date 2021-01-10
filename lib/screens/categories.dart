import 'package:Register/store/edit_category.dart';
import 'package:Register/widgets/gridlist/categories.dart';
import 'package:Register/widgets/text/header.dart';
import 'package:flutter/material.dart';
import 'package:Register/widgets/nav/drawer.dart';
import 'package:Register/widgets/nav/navbar.dart';
//import 'package:Register/methods/search.dart';
// import 'package:Register/models/category.dart';
//import 'package:Register/provider/category_provider.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/categories';

  //@override

  @override
  Widget build(BuildContext context) {
    void editCategory() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EditCategory()));
    }

    void searchbar() {}
    return Scaffold(
      appBar:
          NavBar(IconButton(icon: Icon(Icons.search), onPressed: searchbar)),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          pageHeader(text: 'Product Categories'),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CategoriesList(),
            ),
          )
        ],
      ),
      drawer: Drawer(child: NavDrawer()),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: editCategory,
      //   tooltip: 'Add new category',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
