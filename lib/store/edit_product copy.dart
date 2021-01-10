// import 'package:Inventory/models/brand.dart';
// import 'package:Inventory/models/category.dart';
// import 'package:Inventory/provider/product_photo_provider.dart';
// import 'package:Inventory/provider/product_provider.dart';
// import 'package:Inventory/widgets/forms/form.dart';
// //import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// //import 'package:images_picker/images_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';
// import 'dart:io';

// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:images_picker/images_picker.dart';

// class EditProductCopy extends StatefulWidget {
//   // final Brand brand;

//   // EditBrand([this.brand]);

//   @override
//   _EditProductCopyState createState() => _EditProductCopyState();
// }

// class _EditProductCopyState extends State<EditProductCopy> {
//   //FirebaseFirestore _db = FirebaseFirestore.instance;
//   final TextEditingController productname = TextEditingController();
//   final TextEditingController productitem = TextEditingController();
//   final TextEditingController productserial = TextEditingController();
//   final TextEditingController productmodel = TextEditingController();
//   final TextEditingController productdesc = TextEditingController();
//   final TextEditingController productsku = TextEditingController();
//   final TextEditingController productcolor = TextEditingController();
//   final TextEditingController productmaterial = TextEditingController();
//   final TextEditingController productmeasure = TextEditingController();
//   final TextEditingController producttags = TextEditingController();

//   String _category;
//   String _brand;
//   String binderId;
//   String str;
//   List path = [];
//   var paths;
//   var binder = Uuid();

//   getId(String str) {
//     var arr = str.split('-');
//     int i = arr.length;
//     return arr[i - 1];
//   }

//   void initState() {
//     str = binder.v4().toString();
//     binderId = getId(str);
//     super.initState();
//   }

//   void dispose() {
//     productname.dispose();
//     super.dispose();
//   }

//   void newText(String value) {
//     setState(() {
//       //_text = value;
//     });
//   }

//   //get catnames => null;
//   @override
//   Widget build(BuildContext context) {
//     final categories = Provider.of<List<Category>>(context);
//     final brands = Provider.of<List<Brand>>(context);

//     final productProvider = Provider.of<ProductProvider>(context);
//     //final photoProvider = Provider.of<ProductPhotoProvider>(context);

//     List<DropdownMenuItem> catnames() {
//       List<DropdownMenuItem> catnames = [];
//       for (int i = 0; i < categories.length; i++) {
//         String catname = categories[i].name;
//         catnames.add(DropdownMenuItem(
//           child: Text(
//             catname,
//             style: TextStyle(),
//           ),
//           value: "$catname",
//         ));
//       }
//       return catnames;
//     }

//     List<DropdownMenuItem> bnames() {
//       List<DropdownMenuItem> bnames = [];
//       for (int i = 0; i < brands.length; i++) {
//         String bname = brands[i].brand;
//         bnames.add(DropdownMenuItem(
//           child: Text(
//             bname,
//             style: TextStyle(),
//           ),
//           value: "$bname",
//         ));
//       }
//       return bnames;
//     }
//     //ListItem _selectedItem;

//     return Scaffold(
//       appBar: AppBar(title: Text('Add Product')),
//       body: ListView(
//         children: <Widget>[
// //*******************CATEGORY SELECTION****************/
//           formHeader(text: 'Product Identification'),
//           Center(
//             child: Text(
//               binderId,
//               style: TextStyle(color: Colors.teal[700]),
//             ),
//           ),

//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             // mainAxisAlignment:
//             //     MainAxisAlignment.center, //Center Row contents horizontally,
//             // crossAxisAlignment:
//             //     CrossAxisAlignment.center, //Center Row contents vertically,
//             children: <Widget>[
//               formLabel(text: 'Category '),
//               Container(
//                 padding: EdgeInsets.only(left: 5),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                       color: Colors.grey[500],
//                       width: 1,
//                       style: BorderStyle.solid),
//                 ),
//                 width: MediaQuery.of(context).size.width - 170,
//                 child: DropdownButton(
//                   items: catnames(),
//                   onChanged: (catvalue) {
//                     productProvider
//                         .changeCategoryId(catvalue.toString().toLowerCase());
//                     final snackbar = SnackBar(
//                         content: Text(
//                       catvalue,
//                       style: TextStyle(color: Colors.teal[700]),
//                     ));
//                     Scaffold.of(context).showSnackBar(snackbar);
//                     setState(() {
//                       _category = catvalue;
//                     });
//                   },
//                   value: _category,
//                   underline: Container(),
//                   isExpanded: true,
//                   hint: new Text(
//                     'Choose Category',
//                     style: TextStyle(color: Colors.teal[700]),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             children: <Widget>[
//               formLabel(text: 'Brand '),
//               Container(
//                 padding: EdgeInsets.only(left: 5),
//                 width: MediaQuery.of(context).size.width - 170,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                         color: Colors.grey[500],
//                         width: 1,
//                         style: BorderStyle.solid)),
//                 child: DropdownButton(
//                   items: bnames(),
//                   onChanged: (bvalue) {
//                     productProvider
//                         .changeBrandId(bvalue.toString().toLowerCase());
//                     final snackbar = SnackBar(
//                         content: Text(
//                       bvalue,
//                       style: TextStyle(color: Colors.teal[700]),
//                     ));
//                     Scaffold.of(context).showSnackBar(snackbar);
//                     setState(() {
//                       _brand = bvalue;
//                     });
//                   },
//                   value: _brand,
//                   underline: Container(),
//                   isExpanded: true,
//                   hint: new Text(
//                     'Choose Brand ',
//                     style: TextStyle(color: Colors.teal[700]),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             children: <Widget>[
//               formLabel(text: 'Item Type: '),
//               inputTextField(
//                   width: MediaQuery.of(context).size.width - 170,
//                   controller: productitem,
//                   hint: 'Item type',
//                   onChange: (value) {
//                     productProvider.changeItem(value.toString().toLowerCase());
//                   }),
//             ],
//           ),
//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             children: <Widget>[
//               formLabel(text: 'Product Name '),
//               inputTextField(
//                   width: MediaQuery.of(context).size.width - 170,
//                   controller: productname,
//                   hint: 'Product Name',
//                   onChange: (value) {
//                     productProvider.changeName(value.toString().toLowerCase());
//                   }),
//             ],
//           ),
//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             children: <Widget>[
//               formLabel(text: 'Product Model '),
//               inputTextField(
//                   width: MediaQuery.of(context).size.width - 170,
//                   controller: productmodel,
//                   hint: 'Product Model',
//                   onChange: (value) {
//                     productProvider.changeModel(value.toString().toLowerCase());
//                   }),
//             ],
//           ),
//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             children: <Widget>[
//               formLabel(text: 'Product Serial '),
//               inputTextField(
//                   width: MediaQuery.of(context).size.width - 170,
//                   controller: productserial,
//                   hint: 'Product Serial',
//                   onChange: (value) {
//                     productProvider
//                         .changeSerial(value.toString().toLowerCase());
//                   }),
//             ],
//           ),
//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             children: <Widget>[
//               formLabel(text: 'Description '),
//               inputTextArea(
//                   width: MediaQuery.of(context).size.width - 170,
//                   controller: productdesc,
//                   hint: 'Product Description',
//                   onChange: (value) {
//                     productProvider.changeDesc(value.toString().toLowerCase());
//                   }),
//             ],
//           ),
//           Divider(),
//           formHeader(text: 'Product Variety Specifics'),
//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             children: <Widget>[
//               formLabel(text: 'SKU '),
//               inputTextArea(
//                   width: MediaQuery.of(context).size.width - 170,
//                   controller: productsku,
//                   hint: 'Stock Keeping Unit',
//                   onChange: (value) {
//                     productProvider.changeSku(value.toString().toLowerCase());
//                   }),
//             ],
//           ),
//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             children: <Widget>[
//               formLabel(text: 'Color '),
//               inputTextArea(
//                   width: MediaQuery.of(context).size.width - 170,
//                   controller: productcolor,
//                   hint: 'Product Color',
//                   onChange: (value) {
//                     productProvider.changeColor(value.toString().toLowerCase());
//                   }),
//             ],
//           ),
//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             children: <Widget>[
//               formLabel(text: 'Measure '),
//               inputTextArea(
//                   width: MediaQuery.of(context).size.width - 170,
//                   controller: productmeasure,
//                   hint: 'Product Measurement like size, volume or weight',
//                   onChange: (value) {
//                     productProvider
//                         .changeMeasure(value.toString().toLowerCase());
//                   }),
//             ],
//           ),
//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             children: <Widget>[
//               formLabel(text: 'Material '),
//               inputTextArea(
//                   width: MediaQuery.of(context).size.width - 170,
//                   controller: productmaterial,
//                   hint: 'Product Materials like metal, alloy, fabric, etc',
//                   onChange: (value) {
//                     productProvider
//                         .changeMaterial(value.toString().toLowerCase());
//                   }),
//             ],
//           ),
//           SizedBox(
//             height: 7,
//           ),
//           Row(
//             children: <Widget>[
//               formLabel(text: 'Tags '),
//               inputTextArea(
//                   width: MediaQuery.of(context).size.width - 170,
//                   controller: producttags,
//                   hint: 'Product Tags like bike, rough road, white pedal',
//                   onChange: (value) {
//                     productProvider.changeTags(value);
//                   }),
//             ],
//           ),
//           // path != null
//           //     // ? Container(
//           //     //     height: double.infinity,
//           //     //     child: Expanded(
//           //     //height: 400,
//           //     // child: Image.file(
//           //     //   File(path),
//           //     //   fit: BoxFit.contain,

//           //     //),
//           //     //child: Text(path.toString()),
//           //     //     child: GridView.builder(
//           //     //       itemCount: path.length,
//           //     //       gridDelegate:
//           //     //           new SliverGridDelegateWithFixedCrossAxisCount(
//           //     //         crossAxisCount: 5,
//           //     //       ),
//           //     //       itemBuilder: (BuildContext context, int index) {
//           //     //         return Image.file(File(path[index]),
//           //     //             fit: BoxFit.contain);
//           //     //       },
//           //     //     ),
//           //     //   ),
//           //     // )
//           //     ? GridView.builder(
//           //         itemCount: path.length,
//           //         shrinkWrap: true,
//           //         physics: ScrollPhysics(),
//           //         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//           //           crossAxisCount: 2,
//           //         ),
//           //         itemBuilder: (BuildContext context, int index) {
//           //           // return Image.file(File(path[index]), fit: BoxFit.contain);
//           //           return Text(path[index]);
//           //         },
//           //       )
//           //     : SizedBox.shrink(),
//           (path != null) ? Text(path.toString()) : SizedBox(height: 5),
//           Divider(),
//           formButton(
//               text: 'Add Product Photos',
//               onPressed: () async {
//                 //uploadImagesFromGallery(binderId);
//                 uploadImages(binderId);
//               },
//               color: Colors.blue[600]),
//           SizedBox(
//             height: 7,
//           ),
//           formButton(
//               text: 'Add New Variation', onPressed: () {}, color: Colors.teal),
//           SizedBox(
//             height: 7,
//           ),
//           formButton(text: 'Save', onPressed: () {}, color: Colors.green),
//           SizedBox(
//             height: 7,
//           ),
//           formButton(
//             text: 'Cancel',
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             color: Colors.grey,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//       //       ),
//       //     ),
//       //   ),
//       // ),
//     );
//   }

//   Future<bool> dupCheck(String field, String value) async {
//     final FirebaseFirestore _db = FirebaseFirestore.instance;
//     final result =
//         await _db.collection('products').where(field, isEqualTo: value).get();
//     //result.docs;
//     //return result.isEmpty;
//     if (result.docs.isNotEmpty) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   uploadImages(binderId) async {
//     final photoProvider =
//         Provider.of<ProductPhotoProvider>(context, listen: false);
//     final _storage = FirebaseStorage.instance;
//     var now = new DateTime.now();
//     var uuid = Uuid();

//     await Permission.photos.request();

//     var permissionStatus = await Permission.photos.status;

//     if (permissionStatus.isGranted) {
//       //Select Image

//       List<Media> res = await ImagesPicker.pick(
//         count: 10,
//         pickType: PickType.image,
//         cropOpt: CropOption(),
//       );

//       if (res != null) {
//         for (int i = 0; i < res.length; i++) {
//           print(res[i]?.path);

//           var pathi = res[i].path;

//           // var file = [];
//           // file.add(await File(res[i].thumbPath).create());
//           File file = await File(pathi).create();
//           // final StorageReference reff =
//           //     _storage.ref().child('products/$binderId/' + uuid.v4());
//           // final StorageUploadTask snaps = reff.putFile(file);
//           // final StreamSubscription<StorageTaskEvent> sub =
//           //     snaps.events.listen((event) async {
//           //   await snaps.events.toList();
//           //   print('EVENT ${event.type}');
//           // });
//           // await snaps.onComplete;

//           // var downloadUrl = await reff.getDownloadURL();

//           //StorageTaskSnapshot snaps;
//           var snaps = await _storage
//               .ref()
//               .child('products/$binderId/' + uuid.v4())
//               .putFile(file.absolute)
//               //.putFile(File(element?.path), new StorageMetadata())
//               .onComplete;

//           // //.then((value) => );

//           var downloadUrl = await snaps.ref.getDownloadURL();
//           print(file);
//           setState(
//             () {
//               //snaps.ref.updateMetadata(downloadUrl);
//               //path.add(downloadUrl);
//               //snaps.add(snaps);
//               photoProvider.changeBindId(binderId);
//               //photoProvider.changeUrl(downloadUrl);
//               photoProvider.changeDateAdded(now.toString());
//               //photoProvider.saveProductPhoto();
//               //print(downloadUrl);
//               //print(file);
//             },
//           );
//           path.add(downloadUrl);
//           // file = null;
//           // pathi = null;
//           print(pathi);
//           //sub.cancel();
//           //i++;
//           //return true;
//         }
//       } else {
//         print('No Path Received');
//       }
//     } else {
//       print('Grant Permissions and try again');
//     }
//   }

// //   uploadImagesFromGallery(binder) async {
// //     final photoProvider =
// //         Provider.of<ProductPhotoProvider>(context, listen: false);
// //     final _storage = FirebaseStorage.instance;
// //     var now = new DateTime.now();

// //     await Permission.photos.request();
// //     var permissionStatus = await Permission.photos.status;
// //     if (permissionStatus.isGranted) {
// //       List<Media> res = await ImagesPicker.pick(
// //         count: 10,
// //         pickType: PickType.image,
// //         cropOpt: CropOption(),
// //       );
// //       if (res != null) {
// //         // print(res[0]?.path);
// //         // setState(() {
// //         //   path = res[0]?.thumbPath;
// //         // });

// //         // for (int i = 0; i < res.length; i++) {
// //         //   var file = File(res[i]?.thumbPath);
// //         //   var snapshot = await _storage
// //         //       .ref()
// //         //       .child('products/$binder/' + i.toString())
// //         //       .putFile(file)
// //         //       .onComplete;

// //         //   var downloadUrl = await snapshot.ref.getDownloadURL();

// //         //   setState(() {
// //         //     path.add(downloadUrl);
// //         //     photoProvider.changeBindId(binder);
// //         //     photoProvider.changeUrl(downloadUrl);
// //         //     photoProvider.changeDateAdded(now.toString());
// //         //   });
// //         // }
// //         // setState(() {
// //         //   for (int i = 0; i < res.length; i++) {
// //         //     path.add(res[i]?.thumbPath);
// //         //   }
// //         // });
// //         StorageReference reference = _storage.ref().child('products/$binder/')
// //       } else {
// //         print('No Path Received');
// //       }
// //     } else {
// //       print('Grant Permissions and try again');
// //     }
// //   }
// }
