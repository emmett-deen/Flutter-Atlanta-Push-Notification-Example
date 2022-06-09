import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import 'firestore_Service.dart';

class UserService extends FirestoreService<User> {
  UserService()
    : super(
      collectionRef: FirebaseFirestore.instance.collection(''));

  @override
  User fromDocument(DocumentSnapshot<Object?> doc) {
  return User.fromJson(doc.data() as Map<String, dynamic>);
  }

  @override
  Map<String, dynamic> toJson(User model) {
  return model.toJson();
  }
}
