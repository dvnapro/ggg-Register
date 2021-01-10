import 'package:Register/models/brand.dart';
import 'package:Register/routes/args/args.dart';
import 'package:Register/routes/routes.dart';
import 'package:Register/store/edit_brand.dart';
import 'package:Register/widgets/forms/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
// import 'package:Register/provider/brand_provider.dart';
// import 'package:Register/services/brand_service.dart';

class BrandsList extends StatefulWidget {
  @override
  _BrandsListState createState() => _BrandsListState();
}

class _BrandsListState extends State<BrandsList> {
  @override
  Widget build(BuildContext context) {
    final brands = Provider.of<List<Brand>>(context);

    return Container(
      padding: EdgeInsets.all(10),
      child: (brands != null)
          ? new StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: brands.length,
              itemBuilder: (BuildContext context, index) => new Container(
                color: Colors.white,
                child: new Card(
                  elevation: 5.0,
                  child: Container(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: (brands[index].logoUrl != null)
                                    ? NetworkImage(brands[index].logoUrl)
                                    : AssetImage('assets/drawer_bg.png'),
                                fit: (brands[index].logoUrl != null)
                                    ? BoxFit.scaleDown
                                    : BoxFit.cover,
                                alignment: Alignment.topCenter),
                          ),
                          child: new Text(
                            (brands[index].logoUrl == null)
                                ? brands[index].brand.toUpperCase()
                                : '',
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
                              new FittedBox(
                                alignment: Alignment.center,
                                //padding: EdgeInsets.all(10.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, //Center Row contents horizontally,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          context,
                                          Routes.productbrand,
                                          arguments: BrandArgs(
                                            brands[index]
                                                .brandId
                                                .toString()
                                                .toLowerCase(),
                                            brands[index]
                                                .brand
                                                .toString()
                                                .toLowerCase(),
                                          ),
                                        );
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
                                    //             EditBrand(brands[index]),
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
                                  ],
                                ),
                              ),
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
              //new StaggeredTile.extent(brands.length, 3),
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
