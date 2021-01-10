import 'package:Register/models/category.dart';
import 'package:Register/routes/args/args.dart';
import 'package:Register/routes/routes.dart';
import 'package:Register/store/edit_category.dart';
import 'package:Register/widgets/forms/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

//import 'package:Register/routes/args/args.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context);

    return Container(
      //alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      //height: MediaQuery.of(context).size.height,
      child: (categories != null)
          ? new StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, index) => new Container(
                color: Colors.white,
                child: new Card(
                  elevation: 5.0,
                  child: Container(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: (categories[index].imageURL != null)
                                    ? NetworkImage(categories[index].imageURL)
                                    : AssetImage('assets/drawer_bg.png'),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter),
                          ),
                          child: new Text(
                            categories[index].name.toString().toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              shadows: <Shadow>[
                                Shadow(
                                  blurRadius: 2.0,
                                  color: Colors.black,
                                  offset: Offset(
                                    1.0,
                                    1.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        new Container(
                          //padding: EdgeInsets.all(10.0),
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                  padding: EdgeInsets.all(20),
                                  child: new Text(
                                      categories[index].desc.toString(),
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic))),
                              //new Divider(),
                              new FittedBox(
                                  alignment: Alignment.center,
                                  //padding: EdgeInsets.all(10.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center, //Center Row contents horizontally,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      buttonWithIcon(
                                        text: 'PRODUCTS',
                                        height: 40,
                                        width: 120,
                                        radius: 0,
                                        icon: Icons.remove_red_eye,
                                        color: Colors.red[600],
                                        textColor: Colors.white,
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context, Routes.product,
                                              arguments: CategoryArgs(
                                                  categories[index]
                                                      .categoryId
                                                      .toString()
                                                      .toLowerCase(),
                                                  categories[index]
                                                      .name
                                                      .toString()
                                                      .toLowerCase(),
                                                  categories[index]
                                                      .slug
                                                      .toString()
                                                      .toLowerCase()));
                                        },
                                      ),
                                      // buttonWithIcon(
                                      //   text: 'EDIT',
                                      //   height: 40,
                                      //   width: 120,
                                      //   radius: 0,
                                      //   icon: Icons.edit,
                                      //   color: Colors.green[600],
                                      //   textColor: Colors.white,
                                      //   onTap: () {
                                      //     Navigator.of(context).push(
                                      //       MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             EditCategory(
                                      //                 categories[index]),
                                      //       ),
                                      //     );
                                      //   },
                                      // ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              staggeredTileBuilder: (int index) =>
                  //new StaggeredTile.count(2, index.isEven ? 2 : 1),
                  new StaggeredTile.fit(2),
              //new StaggeredTile.extent(categories.length, 3),
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
