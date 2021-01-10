import 'package:Register/provider/product_photo_provider.dart';
import 'package:Register/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future asyncConfirmDialogPhoto(BuildContext context, String photoId) async {
  print(photoId.toString());
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete This Photo?'),
        content: const Text('This will delete the photo from your database.'),
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
              final photoProvider =
                  Provider.of<ProductPhotoProvider>(context, listen: false);
              photoProvider.removeProductPhoto(photoId);

              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
