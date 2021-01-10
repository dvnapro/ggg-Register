import 'package:Register/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future asyncConfirmDialog(BuildContext context, String productId) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete This Product?'),
        content: const Text('This will delete the product from your database.'),
        actions: <Widget>[
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: const Text('Delete'),
            onPressed: () {
              final productProvider =
                  Provider.of<ProductProvider>(context, listen: false);
              productProvider.removeProduct(productId);
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
