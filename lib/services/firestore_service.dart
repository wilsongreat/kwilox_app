import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/drink_model.dart';

class FirestoreService {
  FirestoreService({required this.uid});
  final String uid;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addDrink(
    Drink drink,
  ) async {
    final docId = firestore.collection("drinks").doc().id;
    await firestore.collection("drinks").doc(docId).set(drink.toMap(docId));
  }

  Future<void> editDrink(
    Drink drink,
  ) async {
    final docId = firestore.collection("drinks").doc().id;
    await firestore
        .collection("drinks")
        .doc(docId)
        .update(drink.toMap(docId))
        .then((value) => print('Successfully updated'))
        .catchError((error) => print(error));
  }

  Stream<List<Drink>> getProducts() {
    return firestore
        .collection("drinks")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Drink.fromMap(d);
            }).toList());
  }

  Future<void> deleteProduct(String id) async {
    return await firestore.collection("drinks").doc(id).delete();
  }
}
