import 'dart:io';

import 'package:Register/models/category.dart';
import 'package:Register/provider/category_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditCategory extends StatefulWidget {
  final Category category;

  EditCategory([this.category]);

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  final nameController = TextEditingController();
  final slugController = TextEditingController();
  final descController = TextEditingController();
  final dateAddedController = TextEditingController();
  final dateModifiedController = TextEditingController();

  String imageUrl;
  String header;
  String _msg = '';
  bool _success = false;
  var now = new DateTime.now();

  @override
  void dispose() {
    nameController.dispose();
    slugController.dispose();
    descController.dispose();
    dateAddedController.dispose();
    dateModifiedController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    if (widget.category == null) {
      //New Record
      nameController.text = "";
      slugController.text = "";
      descController.text = "";
      dateAddedController.text = "";
      dateModifiedController.text = "";
      imageUrl = null;
      header = "Add Category";

      new Future.delayed(Duration.zero, () {
        final categoryProvider =
            Provider.of<CategoryProvider>(context, listen: false);
        categoryProvider.loadValues(Category());
      });
    } else {
      //Controller Update
      imageUrl = widget.category.imageURL;
      nameController.text = widget.category.name.toString().toLowerCase();
      slugController.text = widget.category.slug.toString().toLowerCase();
      descController.text = widget.category.desc.toString().toLowerCase();
      dateAddedController.text = widget.category.dateAdded.toString();
      dateModifiedController.text = widget.category.dateModified.toString();
      header = "Edit Category";
      //State Update
      new Future.delayed(Duration.zero, () {
        final categoryProvider =
            Provider.of<CategoryProvider>(context, listen: false);
        categoryProvider.loadValues(widget.category);
      });
    }
    //imageController.addListener(textListener());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(header)),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: <Widget>[
            GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: (widget.category == null)
                            ? AssetImage('assets/drawer_bg.png')
                            : (imageUrl != null)
                                ? NetworkImage(imageUrl)
                                : AssetImage('assets/drawer_bg.png'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter),
                  ),
                  child: new Text('COVER PHOTO',
                      style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ),
                onTap: () => uploadImage(nameController.text)),
            TextField(
              controller: nameController,
              style: TextStyle(
                fontSize: 20,
                height: 3.0,
              ),
              decoration: InputDecoration(
                  hintText: 'Category Name', labelText: 'Category Name:'),
              onChanged: (value) {
                categoryProvider.changeName(value);
              },
            ),
            TextField(
              controller: descController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontSize: 20,
                height: 2.0,
              ),
              decoration: InputDecoration(
                hintText: 'Category Description',
                labelText: 'Category Description:',
                //contentPadding: const EdgeInsets.all(20.0),
              ),
              onChanged: (value) => categoryProvider.changeDesc(value),
            ),
            // Tooltip(
            //   message:
            //       'Slug is the shortened version of your category name. Example: name: Bike, slug: byk',
            //   child: TextField(
            //     controller: slugController,
            //     style: TextStyle(
            //       fontSize: 20,
            //       height: 3.0,
            //     ),
            //     decoration: InputDecoration(
            //       hintText: 'Category Slug',
            //       labelText: 'Category Slug',
            //     ),
            //     onChanged: (value) => categoryProvider.changeSlug(value),
            //   ),
            // ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Text(_msg,
                  style: (_success)
                      ? TextStyle(color: Colors.green)
                      : TextStyle(color: Colors.red)),
            ),
            SizedBox(
              height: 30.0,
            ),
            RaisedButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('Save',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              padding: EdgeInsets.all(20),
              onPressed: () async {
                if (nameController.text != "") {
                  var dup = await dupCheck(
                      nameController.text.toString().toLowerCase());

                  if (widget.category == null) {
                    if (dup) {
                      setState(() {
                        _msg = nameController.text + ' already exist';
                      });
                    } else {
                      categoryProvider.changeCollection('categories');
                      categoryProvider.changeDateAdded(now.toString());
                      categoryProvider.saveCategory();
                      Navigator.of(context).pop();
                    }
                  } else {
                    categoryProvider.changeDateModified(now.toString());
                    categoryProvider.saveCategory();
                    Navigator.of(context).pop();
                  }
                } else {
                  setState(() {
                    _msg =
                        'Please fill in the Category name first before proceeding to save';
                  });
                }
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            (widget.category != null)
                ? RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Delete',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    padding: EdgeInsets.all(20),
                    onPressed: () {
                      categoryProvider
                          .removeCategory(widget.category.categoryId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              child: Text('Cancel',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              padding: EdgeInsets.all(20),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  uploadImage(filename) async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var imgname = filename;
        var snapshot = await _storage
            .ref()
            .child('folderName/' + imgname + "-cover")
            .putFile(file)
            .onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
          categoryProvider.changeImageURL(imageUrl);
          categoryProvider.saveCategory();
          _msg = 'Category photo updated successfully';
          _success = true;
        });
        return true;
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  Future<bool> dupCheck(String doc) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final result =
        await _db.collection('categories').where('name', isEqualTo: doc).get();
    //result.docs;
    //return result.isEmpty;
    if (result.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
