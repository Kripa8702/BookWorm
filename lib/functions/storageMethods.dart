import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
// import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(
      Uint8List file, String childName, bool isPost, String uid) async {
    Reference ref = _storage.ref().child(childName).child(uid);

    // if (isPost) {
    //   String postId = const Uuid().v1();
    //
    //   ref = ref.child(postId);
    // }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
