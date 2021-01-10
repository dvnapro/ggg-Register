import 'package:Register/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future asyncConfirmDeleteCartDialog(
    BuildContext context, String transId, String cartId) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete This Product?'),
        content: const Text('This will delete the product from your cart.'),
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
                  Provider.of<CartProvider>(context, listen: false);
              productProvider.removeCart(cartId, transId);
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
