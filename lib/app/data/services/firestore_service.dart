import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreService<T> {
  final CollectionReference collectionRef;

  FirestoreService({required this.collectionRef});

  T fromDocument(DocumentSnapshot doc);
  Map<String, dynamic> toJson(T model);

  Future<T> create(T model) async {
    var ref = await collectionRef.add(toJson(model));
    await ref.update({'id': ref.id});
    return fromDocument(await ref.get());
  }

  Future<T> read(String id) async {
    var doc = await collectionRef.doc(id).get();
    return fromDocument(doc);
  }

  Future<List<T>> list({int? limit}) async {
    Query ref = collectionRef;
    if (limit != null) {
      ref = ref.limit(limit);
    }
    var snapshot = await ref.get();
    return snapshot.docs.map((doc) => fromDocument(doc)).toList();
  }

  Future<void> delete(String id) {
    return collectionRef.doc(id).delete();
  }

  Future<T> update(String id, T model) async {
    await collectionRef.doc(id).update(toJson(model));
    return model;
  }

  Future<T> set(String id, T model) async {
    await collectionRef.doc(id).set(toJson(model));
    return model;
  }

  Stream<T> stream(String id) {
    return collectionRef
        .doc(id)
        .snapshots()
        .map((snapshot) => fromDocument(snapshot));
  }

  Stream<List<T>> streamList({required int limit}) {
    return collectionRef.limit(limit).snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => fromDocument(doc)).toList());
  }

  Future<List<T>> query({required Query query}) {
    return query.get().then(
        (snapshot) => snapshot.docs.map((doc) => fromDocument(doc)).toList());
  }

  Stream<List<T>> streamQuery({required Query query}) {
    return query.snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => fromDocument(doc)).toList());
  }
}
