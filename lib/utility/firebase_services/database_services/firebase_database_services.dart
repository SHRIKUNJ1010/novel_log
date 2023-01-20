import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:novel_log/utility/constants.dart';

class FirebaseDatabaseServices {
  static final db = FirebaseFirestore.instance;

  static final userCollectionReference = db.collection(userCollection);

  static final novelCollectionReference = db.collection(novelCollection);
}
