import 'package:Register/store/edit_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Register/widgets/nav/drawer.dart';
import 'package:Register/widgets/nav/navbar.dart';
//import 'package:Register/methods/search.dart';
import 'package:Register/models/category.dart';
//import 'package:Register/provider/category_provider.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/categories';

  //@override

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context);
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
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Text(
              'Products Categories',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(),
            child: (categories != null)
                ? GridView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      //maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      return new GestureDetector(
                        child: new Card(
                          elevation: 5.0,
                          child: new Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                height: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: (categories[index].imageURL !=
                                              null)
                                          ? NetworkImage(
                                              categories[index].imageURL)
                                          : AssetImage('assets/drawer_bg.png'),
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.topCenter),
                                ),
                                child: new Text(
                                    categories[index].slug.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: new Column(
                                    children: <Widget>[
                                      new Text(
                                          categories[index].name.toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      new Divider(),
                                      new Text(categories[index].desc,
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic))
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditCategory(categories[index])));
                        },
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          )
        ],
      ),
      drawer: Drawer(child: NavDrawer()),
      floatingActionButton: FloatingActionButton(
        onPressed: editCategory,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
