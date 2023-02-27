import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumable_replacement_notification/models/item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreUsage {
  FireStoreUsage();

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference _getCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('items');
  }

  Stream<QuerySnapshot> read() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('items')
        .snapshots();
  }

  void write(Item item) {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('items')
          .add(item.toJson());
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  void delete(QueryDocumentSnapshot value) {
    try {
      value.reference.delete();
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future update(Item item, DocumentSnapshot document) async {
    try {
      document.reference.update(item.toJson());
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
