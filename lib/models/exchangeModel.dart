import 'package:book_worm/models/postModel.dart';
import 'package:book_worm/models/postModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExchangeModel {
  final String exchangeId;
  final PostModel book1;
  final PostModel book2;

  const ExchangeModel({
    required this.book1,
    required this.exchangeId,
    required this.book2,
  });

  static ExchangeModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot["book1"]);
    return ExchangeModel(
      exchangeId: snapshot["exchangeId"],
        book1: PostModel.fromJson(snapshot["book1"]),
        book2: PostModel.fromJson(snapshot["book2"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "exchangeId": exchangeId,
    "book1": book1.toJson(),
    "book2": book2.toJson(),
  };
}
