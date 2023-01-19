import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabaseServices {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>?> getData(String collectionPath) async {
    final doc = await firestore.doc(collectionPath).get();
    return doc.data();
  }

  static Future<Map<String, dynamic>?> getFirstDataWhere(
    String collectionPath,
    String key,
    dynamic value,
  ) async {
    final QuerySnapshot<Map<String, dynamic>?> snapshot = await firestore
        .collection(collectionPath)
        .where(key, isEqualTo: value)
        .get();
    return snapshot.docs.first.data();
  }

  static Future<List<Map<String, dynamic>?>> getDataListWhere(
    String collectionPath,
    String key,
    dynamic value,
  ) async {
    final QuerySnapshot<Map<String, dynamic>?> snapshot = await firestore
        .collection(collectionPath)
        .where(key, isEqualTo: value)
        .get();
    List<Map<String, dynamic>?> data = [];
    for (var element in snapshot.docs) {
      data.add(element.data());
    }
    return data;
  }

  static Future<void> insertData(
    String collectionPath,
    Map<String, dynamic> data,
  ) async {
    await firestore.collection(collectionPath).add(data);
  }

  static Future<void> updateData(String collectionPath, String key,
      dynamic oldValue, dynamic newValue) async {
    await firestore
        .collection(collectionPath)
        .where(key, isEqualTo: oldValue)
        .withConverter(
          fromFirestore: (snapshot, options) => snapshot,
          toFirestore: (value, options) => newValue,
        );
  }
}
