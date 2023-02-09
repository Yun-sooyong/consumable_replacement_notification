import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumable_replacement_notification/models/item_model.dart';

class FireStoreDB {
  final String uid;

  FireStoreDB(this.uid);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream read() {
    return firestore.collection('user').snapshots();
  }

  bool write(Item item) {
    try {
      CollectionReference items =
          FirebaseFirestore.instance.collection('users/$uid/items');

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
