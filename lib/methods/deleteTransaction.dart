import 'package:Register/provider/trans_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future asyncConfirmDeleteTransDialog(
    BuildContext context, String id, int units) async {
  String err;
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete This Product?'),
        content: Text(
            'This will delete the product from your database. \n ${err.toString()}'),
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
                  Provider.of<ProductTransProvider>(context, listen: false);
              if (units == 0) {
                productProvider.removeTrans(id);
                Navigator.of(context).pop();
              } else {
                return Text("cannot delete transaction");
              }
            },
          )
        ],
      );
    },
  );
}
