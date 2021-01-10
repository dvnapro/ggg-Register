import 'dart:io';

// import 'package:Register/models/category.dart';
import 'package:Register/models/supplier.dart';
import 'package:Register/provider/supplier_provider.dart';
import 'package:Register/widgets/forms/form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EditSupplier extends StatefulWidget {
  final Supplier supplier;

  EditSupplier([this.supplier]);

  @override
  _EditSupplierState createState() => _EditSupplierState();
}

class _EditSupplierState extends State<EditSupplier> {
  final TextEditingController _suppliername = TextEditingController();
  final TextEditingController _supplierno = TextEditingController();
  final TextEditingController _supplieremail = TextEditingController();
  final TextEditingController _suppliercontact = TextEditingController();
  final TextEditingController _supplieraddress = TextEditingController();
  FocusNode myFocusNode;
  String _header;
  String _imgUrl;
  String _err = '';
  bool _status = false;
  //String _duplicate;
  var now = new DateTime.now();
  var binder = Uuid();

  void initState() {
    //imgUrl = null;
    if (widget.supplier == null) {
      _header = "Add Supplier";
      _imgUrl = null;
      _suppliername.text = null;
      _supplieraddress.text = null;
      _suppliercontact.text = null;
      _supplieremail.text = null;
      _supplierno.text = null;
      new Future.delayed(
        Duration.zero,
        () {
          final supplierProvider =
              Provider.of<SupplierProvider>(context, listen: false);
          supplierProvider.loadValues(Supplier());
        },
      );
    } else {
      _header = "Edit Supplier";
      _imgUrl = widget.supplier.logoUrl;
      _suppliername.text = widget.supplier.company;
      _supplieraddress.text = widget.supplier.supplierAddress;
      _suppliercontact.text = widget.supplier.supplierContactPerson;
      _supplieremail.text = widget.supplier.supplierEmail;
      _supplierno.text = widget.supplier.supplierContactNo;
      new Future.delayed(
        Duration.zero,
        () {
          final supplierProvider =
              Provider.of<SupplierProvider>(context, listen: false);
          supplierProvider.loadValues(widget.supplier);
        },
      );
    }
    //_err = '';
    myFocusNode = FocusNode();
    super.initState();
  }

  void dispose() {
    _suppliername.dispose();
    _supplieraddress.dispose();
    _suppliercontact.dispose();
    _supplieremail.dispose();
    _supplierno.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final supplierProvider = Provider.of<SupplierProvider>(context);

    //ListItem _selectedItem;

    return Scaffold(
      appBar: AppBar(title: Text(_header)),
      body: ListView(
        children: <Widget>[
//*******************CATEGORY SELECTION****************/
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10, left: 50, right: 50),
            height: 270,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: (widget.supplier == null)
                      ? AssetImage('assets/drawer_bg.png')
                      : (_imgUrl != null)
                          ? NetworkImage(_imgUrl)
                          : AssetImage('assets/drawer_bg.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter),
            ),
            child: new Text('Supplier Logo',
                style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),

          SizedBox(
            height: 7,
          ),

          Row(
            children: <Widget>[
              formLabel(text: 'Supplier Name '),
              inputTextField(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: _suppliername,
                  hint: 'Supplier Company Name',
                  onChange: (value) {
                    supplierProvider.changeCompany(value.toLowerCase());

                    //checkDupplicate(_suppliername.text);
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Contact Person '),
              inputTextField(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: _suppliercontact,
                  hint: 'Name of contact person',
                  onChange: (value) {
                    supplierProvider
                        .changeSupplierContactPerson(value.toLowerCase());
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Contact No '),
              inputTextField(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: _supplierno,
                  hint: 'Company contact number of supplier',
                  onChange: (value) {
                    supplierProvider
                        .changeSupplierContactNo(value.toLowerCase());
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: <Widget>[
              formLabel(text: 'Supplier Email '),
              inputTextArea(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: _supplieremail,
                  hint: 'Company email address of supplier',
                  onChange: (value) {
                    supplierProvider.changeSupplierEmail(value.toLowerCase());
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),

          Row(
            children: <Widget>[
              formLabel(text: 'Supplier Address '),
              inputTextArea(
                  width: MediaQuery.of(context).size.width - 170,
                  controller: _supplieraddress,
                  hint: 'Company address of supplier',
                  onChange: (value) {
                    supplierProvider.changeDateAdded(value.toLowerCase());
                  }),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Center(
            child: Text(
              _err,
              style: (_status)
                  ? TextStyle(color: Colors.green, fontWeight: FontWeight.bold)
                  : TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(
            height: 7,
          ),
          formButton(
              text: 'Add Supplier Photo',
              onPressed: () {
                if (_suppliername.text != "") {
                  uploadImage(_suppliername.text);
                } else {
                  setState(() {
                    _err = 'Please fill-in supplier name first';
                  });
                }
              },
              color: Colors.blue[600]),
          SizedBox(
            height: 7,
          ),
          (widget.supplier == null)
              ? formButton(
                  text: 'Add New Supplier',
                  onPressed: () async {
                    if (_suppliername.text != "") {
                      //setState(() {
                      var check = await dupCheck(_suppliername.text.toString());
                      //});
                      if (check) {
                        setState(() {
                          _err = 'Supplier name ' +
                              _suppliername.text +
                              ' already exist';
                        });
                      } else {
                        setState(() {
                          _err = 'Supplier name ' +
                              _suppliername.text +
                              ' is okay';
                        });
                        if (widget.supplier != null) {
                          supplierProvider.changeDateAdded(now.toString());
                          supplierProvider.saveSupplier();
                          setState(() {
                            _imgUrl = null;
                            _status = true;
                            _err = _suppliername.text.toUpperCase() +
                                ' added successfully';
                          });
                          _supplieraddress.clear();
                          _suppliercontact.clear();
                          _supplieremail.clear();
                          _suppliername.clear();
                          _supplierno.clear();
                        } else {
                          supplierProvider.changeDateUpdated(now.toString());
                          supplierProvider.saveSupplier();

                          setState(() {
                            _imgUrl = null;
                            _status = true;
                            _err = _suppliername.text.toUpperCase() +
                                ' added successfully';
                          });
                        }

                        _supplieraddress.clear();
                        _suppliercontact.clear();
                        _supplieremail.clear();
                        _suppliername.clear();
                        _supplierno.clear();
                      }
                    } else {
                      setState(() {
                        _err =
                            'Please fill-in supplier name first before adding new supplier';
                      });
                    }
                  },
                  color: Colors.teal)
              : SizedBox(
                  height: 0,
                ),
          SizedBox(
            height: 7,
          ),
          formButton(
              text: 'Save',
              onPressed: () async {
                if (_suppliername.text != "") {
                  var dup = await dupCheck(_suppliername.text.toLowerCase());
                  if (dup) {
                    setState(() {
                      _err =
                          'Supplier ' + _suppliername.text + ' already exists';
                    });
                  } else {
                    if (widget.supplier != null) {
                      supplierProvider.changeDateAdded(now.toString());
                      supplierProvider.saveSupplier();
                    } else {
                      supplierProvider.changeDateUpdated(now.toString());
                      supplierProvider.saveSupplier();
                    }
                    Navigator.of(context).pop();
                  }
                } else {
                  setState(() {
                    _err =
                        'Please fill-in supplier name first before you tap save button';
                  });
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
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  uploadImage(filename) async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    final supplierProvider =
        Provider.of<SupplierProvider>(context, listen: false);

    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image.path == null) {
        Navigator.of(context).pop();
      }
      if (image != null) {
        //Upload to Firebase
        var imgname = filename.toLowerCase();
        var snapshot = await _storage
            .ref()
            .child('supplier/' + imgname + "-cover")
            .putFile(file)
            .onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          _imgUrl = downloadUrl;
          supplierProvider.changeLogoUrl(downloadUrl);
          supplierProvider.changeCompany(imgname);
          supplierProvider.changeDateUpdated(now.toString());
          supplierProvider.saveSupplier();
          //suppliertxt.text = downloadUrl.toString();
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
    final result = await _db
        .collection('suppliers')
        .where('company', isEqualTo: doc)
        .get();
    //result.docs;
    //return result.isEmpty;
    if (result.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
