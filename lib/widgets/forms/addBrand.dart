import 'package:Register/provider/brand_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBrand extends StatefulWidget {
  @override
  _AddBrandState createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  final _brandname = TextEditingController();
  var now = new DateTime.now();
  String _msg = '';
  bool _success = false;
  @override
  void initState() {
    //_brandname = null;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _brandname.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brandProvider = Provider.of<BrandProvider>(context, listen: false);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Divider(),
          TextField(
            controller: _brandname,
            style: TextStyle(
              color: Colors.teal[900],
              fontSize: 14,
            ),
            decoration: InputDecoration(
              // icon: Icon(
              //   Icons.email_rounded,
              //   size: 40.0,
              //   color: Colors.teal[600],
              // ),
              suffixIcon: IconButton(
                icon: Icon(Icons.save_alt),
                onPressed: () async {
                  if (_brandname.text != null) {
                    var dup = await dupCheck(_brandname.text.toString());
                    if (dup) {
                      setState(() {
                        _success = false;
                        _msg = _brandname.text + ' already exist';
                      });
                    } else {
                      brandProvider.changeDateAdded(now.toString());
                      brandProvider.saveBrand();
                      setState(() {
                        _success = true;
                        _msg = _brandname.text + ' added successsfully';
                        _brandname.text = "";
                      });
                    }
                  }
                },
              ),
              border: const OutlineInputBorder(),
              hintText: 'Brandname',
              labelText: 'Brandname',
              labelStyle: TextStyle(color: Colors.teal[700]),
            ),
            textInputAction: TextInputAction.go,
            onSubmitted: (value) {
              if (_brandname.text != null) {
                brandProvider.changeDateAdded(now.toString());
                brandProvider.saveBrand();
                setState(() {
                  _brandname.text = "";
                });
              }
            },
            onChanged: (value) {
              brandProvider.changeBrand(value.toLowerCase());
            },
          ),
          Center(
            child: Text(
              _msg,
              style: (_success)
                  ? TextStyle(color: Colors.green)
                  : TextStyle(color: Colors.red),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Future<bool> dupCheck(String doc) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final result =
        await _db.collection('brands').where('brand', isEqualTo: doc).get();
    //result.docs;
    //return result.isEmpty;
    if (result.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
