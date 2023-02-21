import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumable_replacement_notification/models/item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreUsage {
  FireStoreUsage();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Stream read() {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('items')
        .snapshots();
  }

  bool write(Item item) {
    try {
      CollectionReference items = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('items');

      //items.doc(item.title).set(item.toJson());
      items.add(item.toJson());
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }

    return true;
  }

  bool delete() {
    return false;
  }

  bool update() {
    return false;
  }
}
