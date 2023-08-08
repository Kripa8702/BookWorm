import 'package:book_worm/firebaseResources/storageMethods.dart';
import 'package:book_worm/models/exchangeModel.dart';
import 'package:book_worm/models/postModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
// import 'package:js/js_util.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadImage(
    String uid,
    Uint8List file,
    String username,
    String description,
    String title,
    String genre,
    bool exchange,
    bool sell,
    bool rent,
  ) async {
    String res = "Some error occurred";
    try {
      String postId = const Uuid().v1();

      String photoUrl =
          await StorageMethods().uploadImageToStorage(file, 'posts', postId);

      PostModel post = PostModel(
        description: description,
        title: title,
        uid: uid,
        username: username,
        genre: genre,
        postId: postId,
        postUrl: photoUrl,
        exchange: exchange,
        sell: sell,
        rent: rent,
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> updateUserDetails(
      String uid, String field, String data) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('users').doc(uid).update({field: data});
      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> postExchangeRequest(
    PostModel postModel1,
    String uid,
    Uint8List file,
    String username,
    String description,
    String title,
    String genre,
    bool exchange,
    bool sell,
    bool rent,
  ) async {
    String res = "Some error occurred";
    try {
      String postId = const Uuid().v1();

      String photoUrl =
          await StorageMethods().uploadImageToStorage(file, 'posts', postId);

      PostModel postModel2 = PostModel(
        description: description,
        title: title,
        uid: uid,
        username: username,
        genre: genre,
        postId: postId,
        postUrl: photoUrl,
        exchange: exchange,
        sell: sell,
        rent: rent,
      );

      // _firestore.collection('posts').doc(postId).set(postModel2.toJson());

      String exchangeId = const Uuid().v1();

      ExchangeModel exchangeModel = ExchangeModel(
        exchangeId: exchangeId,
        book1: postModel1,
        book2: postModel2,
      );

      await _firestore
          .collection('exchanges')
          .doc(exchangeId)
          .set(exchangeModel.toJson());

      res = exchangeId;
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
