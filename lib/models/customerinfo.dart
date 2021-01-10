import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerInfo {
  final String customerId;
  final String transId;
  final String fname;
  final String mname;
  final String lname;
  final String bdate;
  final String address;
  final String email;
  final String phone;
  final String imgUrl;

  CustomerInfo({
    this.customerId,
    this.transId,
    this.fname,
    this.mname,
    this.lname,
    this.bdate,
    this.address,
    this.email,
    this.phone,
    this.imgUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'transId': transId,
      'fname': fname,
      'lname': lname,
      'mname': mname,
      'bdate': bdate,
      'address': address,
      'phone': phone,
      'email': email,
      'imgUrl': imgUrl
    };
  }

  factory CustomerInfo.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> Function() data = doc.data;
    return CustomerInfo(
      customerId: data()['customerId'] ?? '',
      transId: data()['transId'] ?? '',
      fname: data()['fname'] ?? '',
      mname: data()['mname'] ?? '',
      lname: data()['lname'] ?? '',
      bdate: data()['bdate'] ?? '',
      address: data()['address'] ?? '',
      email: data()['email'] ?? '',
      phone: data()['phone'] ?? '',
      imgUrl: data()['imgUrl'] ?? '',
    );
  }
}
