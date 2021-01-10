import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:uuid/uuid.dart';

Future<dynamic> postImages(Asset file, String binderId) async {
  final _storage = FirebaseStorage.instance;
  var uuid = Uuid();
  var snaps = await _storage
      .ref()
      .child('products/$binderId/' + uuid.v4())
      .putData((await file.getByteData()).buffer.asUint8List())
      .onComplete;

  return await snaps.ref.getDownloadURL();
}
