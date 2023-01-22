import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:novel_log/utility/constants.dart';

class FirebaseDatabaseServices {
  static final db = FirebaseFirestore.instance;

  //accessing user collection
  static final userCollectionReference = db.collection(userCollection);

  //accessing novel collection
  static final novelCollectionReference = db.collection(novelCollection);
}
