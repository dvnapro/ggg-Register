import 'package:Register/models/category.dart';
import 'package:Register/models/subcategory.dart';
import 'package:Register/store/edit_subcategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class SubCategoriesList extends StatefulWidget {
  SubCategoriesList(Category category);

  @override
  _SubCategoriesListState createState() => _SubCategoriesListState();
}

class _SubCategoriesListState extends State<SubCategoriesList> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final subcategories = Provider.of<List<SubCategory>>(context);

    return Container(
      //alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      //height: MediaQuery.of(context).size.height,
      child: (subcategories != null)
          ? new StaggeredGridView.countBuilder(
              crossAxisCount: 6,
              itemCount: subcategories.length,
              itemBuilder: (BuildContext context, index) => new Container(
                color: Colors.white,
                child: new Card(
                  elevation: 5.0,
                  child: Container(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.center,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: (subcategories[index].imageURL != null)
                                    ? NetworkImage(
                                        subcategories[index].imageURL)
                                    : AssetImage('assets/drawer_bg.png'),
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter),
                          ),
                          child: new Text(
                              subcategories[index].name.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                        ),
                        new Container(
                            //padding: EdgeInsets.all(10.0),
                            child: new Column(
                          children: <Widget>[
                            new Container(
                                padding: EdgeInsets.all(20),
                                child: new Text(subcategories[index].desc,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic))),
                            new Divider(),
                            new FittedBox(
                                alignment: Alignment.center,
                                //padding: EdgeInsets.all(10.0),
                                child: new Row(
                                  children: <Widget>[
                                    new FlatButton(
                                        textColor: Colors.white,
                                        color: Colors.red[400],
                                        onPressed: null,
                                        child: Text(subcategories[index]
                                                .name
                                                .toUpperCase() +
                                            " ITEMS")),
                                    new FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditSubCategory(
                                                        subcategories[index])));
                                      },
                                      child: Icon(Icons.edit),
                                    ),
                                  ],
                                )),
                            new Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                              ),
                              child: new Text(
                                  subcategories[index].slug.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              staggeredTileBuilder: (int index) =>
                  //new StaggeredTile.count(2, index.isEven ? 2 : 1),
                  new StaggeredTile.fit(2),
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
