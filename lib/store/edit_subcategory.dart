import 'dart:io';

import 'package:Register/models/subcategory.dart';
import 'package:Register/provider/subcategory_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditSubCategory extends StatefulWidget {
  final SubCategory subcategory;

  EditSubCategory([this.subcategory]);

  @override
  _EditSubCategoryState createState() => _EditSubCategoryState();
}

class _EditSubCategoryState extends State<EditSubCategory> {
  final nameController = TextEditingController();
  final slugController = TextEditingController();
  final descController = TextEditingController();
  final dateAddedController = TextEditingController();
  final dateModifiedController = TextEditingController();

  String imageUrl;

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
    if (widget.subcategory == null) {
      //New Record
      nameController.text = "";
      slugController.text = "";
      descController.text = "";
      dateAddedController.text = "";
      dateModifiedController.text = "";
      imageUrl = "";

      new Future.delayed(Duration.zero, () {
        final subcategoryProvider =
            Provider.of<SubCategoryProvider>(context, listen: false);
        subcategoryProvider.loadValues(SubCategory());
      });
    } else {
      //Controller Update
      nameController.text = widget.subcategory.name.toLowerCase();
      slugController.text = widget.subcategory.slug.toLowerCase();
      descController.text = widget.subcategory.desc.toLowerCase();
      dateAddedController.text = widget.subcategory.dateAdded.toString();
      dateModifiedController.text = widget.subcategory.dateModified.toString();

      //State Update
      new Future.delayed(Duration.zero, () {
        final subcategoryProvider =
            Provider.of<SubCategoryProvider>(context, listen: false);
        subcategoryProvider.loadValues(widget.subcategory);
      });
    }
    //imageController.addListener(textListener());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subcategoryProvider = Provider.of<SubCategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit SubCategory')),
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
                        image: (imageUrl != null)
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
                onTap: () => uploadImage(slugController.text)),
            TextField(
              controller: nameController,
              style: TextStyle(
                fontSize: 20,
                height: 3.0,
              ),
              decoration: InputDecoration(
                  hintText: 'SubCategory Name', labelText: 'SubCategory Name:'),
              onChanged: (value) {
                subcategoryProvider.changeName(value);
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
                hintText: 'SubCategory Description',
                labelText: 'SubCategory Description:',
                //contentPadding: const EdgeInsets.all(20.0),
              ),
              onChanged: (value) => subcategoryProvider.changeDesc(value),
            ),
            Tooltip(
              message:
                  'Slug is the shortened version of your subcategory name. Example: name: Bike, slug: byk',
              child: TextField(
                controller: slugController,
                style: TextStyle(
                  fontSize: 20,
                  height: 3.0,
                ),
                decoration: InputDecoration(
                  hintText: 'SubCategory Slug',
                  labelText: 'SubCategory Slug',
                ),
                onChanged: (value) => subcategoryProvider.changeSlug(value),
              ),
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
              onPressed: () {
                subcategoryProvider.changeImageURL(imageUrl);
                subcategoryProvider.saveSubCategory();
                Navigator.of(context).pop();
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            (widget.subcategory != null)
                ? RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Delete',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    padding: EdgeInsets.all(20),
                    onPressed: () {
                      subcategoryProvider.removeSubCategory(
                          widget.subcategory.refDoc,
                          widget.subcategory.subcategoryId);
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
        });
        return true;
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}
