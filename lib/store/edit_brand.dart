import 'dart:io';
import 'package:Register/models/brand.dart';
import 'package:Register/provider/brand_provider.dart';
import 'package:Register/widgets/forms/form.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class EditBrand extends StatefulWidget {
  final Brand brand;

  EditBrand([this.brand]);

  @override
  _EditBrandState createState() => _EditBrandState();
}

class _EditBrandState extends State<EditBrand> {
  final TextEditingController _brandname = TextEditingController();

  String _imgUrl;
  String _header;

  var now = new DateTime.now();

  getId(String str) {
    var arr = str.split('-');
    int i = arr.length;
    return arr[i - 1];
  }

  void initState() {
    //imgUrl = null;
    if (widget.brand == null) {
      _header = "Add Brand";
      _imgUrl = null;
      _brandname.text = null;
      new Future.delayed(
        Duration.zero,
        () {
          final brandProvider =
              Provider.of<BrandProvider>(context, listen: false);
          brandProvider.loadValues(Brand());
        },
      );
    } else {
      _header = "Edit Brand";
      _imgUrl = widget.brand.logoUrl;
      _brandname.text = widget.brand.brand;
      new Future.delayed(
        Duration.zero,
        () {
          final brandProvider =
              Provider.of<BrandProvider>(context, listen: false);
          brandProvider.loadValues(widget.brand);
        },
      );
    }
    super.initState();
  }

  void dispose() {
    _brandname.dispose();
    super.dispose();
  }

  void newText(String value) {
    setState(() {
      //_text = value;
    });
  }

  //get catnames => null;
  @override
  Widget build(BuildContext context) {
    final brandProvider = Provider.of<BrandProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(_header)),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: (widget.brand == null)
                        ? AssetImage('assets/drawer_bg.png')
                        : (_imgUrl != null)
                            ? NetworkImage(_imgUrl)
                            : AssetImage('assets/drawer_bg.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter),
              ),
              child: new Text('Brand Logo',
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                formLabel(text: 'Brand Name '),
                inputTextArea(
                    width: MediaQuery.of(context).size.width - 170,
                    controller: _brandname,
                    hint: 'Brand name',
                    onChange: (value) {
                      brandProvider.changeBrand(value);
                    }),
              ],
            ),
            Divider(),
            formButton(
                text: 'Add New Brand Image',
                onPressed: () => {uploadImage(_brandname.text)},
                color: Colors.blue[600]),
            SizedBox(
              height: 7,
            ),
            formButton(
                text: 'Save',
                onPressed: () {
                  if (_brandname.text != null) {
                    brandProvider.changeDateUpdated(now.toString());
                    brandProvider.saveBrand();
                    Navigator.of(context).pop();
                  }
                },
                color: Colors.green),
            SizedBox(
              height: 7,
            ),
            formButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.grey,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  uploadImage(filename) async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    final brandProvider = Provider.of<BrandProvider>(context, listen: false);

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
            .child('brand/' + imgname + "-cover")
            .putFile(file)
            .onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          _imgUrl = downloadUrl;
          brandProvider.changeLogoUrl(downloadUrl);
          brandProvider.changeDateUpdated(now.toString());
          brandProvider.saveBrand();
          //brandtxt.text = downloadUrl.toString();
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
