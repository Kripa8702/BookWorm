import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String username;
  final String uid;
  final String password;
  final String location;

  UserModel({
    required this.email,
    required this.username,
    required this.uid,
    required this.password,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'uid': uid,
    'email': email,
    'password': password,
    'location': location,
  };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        email: snapshot['email'],
        username: snapshot['username'],
        uid: snapshot['uid'],
        password: snapshot['password'],
        location: snapshot['location'],
    );
  }

//   static String encode(var users) => json.encode(
//     users
//         .map<Map<String, dynamic>>((user) => UserModel.toMap(user))
//         .toList(),
//   );
//
//   static List<UserModel> decode(String users) =>
//       (json.decode(users) as List<dynamic>)
//           .map<UserModel>((user) => UserModel.fromJson(user))
//           .toList();
// }
}