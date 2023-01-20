import 'package:novel_log/models/data_models/user_profile_model.dart';
import 'package:novel_log/utility/firebase_services/database_services/firebase_database_services.dart';

class UserServices {
  static Future<void> createUser(String userId, Map<String, dynamic> data) async {
    await FirebaseDatabaseServices.userCollectionReference.doc(userId).set(data);
  }

  static Future<UserProfileModel> getUserData(String userId) async {
    final temp = await FirebaseDatabaseServices.userCollectionReference.doc(userId).get();
    return UserProfileModel.fromJson(userId, temp.data() ?? {});
  }
}
