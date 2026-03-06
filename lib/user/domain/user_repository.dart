import 'package:deck_share/user/domain/user_model.dart';

abstract class UserRepository {
  // get our information
  Future<UserProfile> getUserInformation();
  Future<void> saveUser(UserProfile user);
  Future<List<UserProfile>> getUserByInformation(String? name, String? phone);
  // get all User public information
  Future<List<UserProfile>> getAllUserProfile();
}
