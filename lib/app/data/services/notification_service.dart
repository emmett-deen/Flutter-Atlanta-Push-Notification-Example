import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/notification.dart';
import 'firestore_Service.dart';

class NotificationService extends FirestoreService<Notification> {
  NotificationService()
    : super(
      collectionRef: FirebaseFirestore.instance.collection(''));

  @override
  Notification fromDocument(DocumentSnapshot<Object?> doc) {
  return Notification.fromJson(doc.data() as Map<String, dynamic>);
  }

  @override
  Map<String, dynamic> toJson(Notification model) {
  return model.toJson();
  }
}
