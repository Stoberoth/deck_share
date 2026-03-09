
import 'package:deck_share/user/domain/user_model.dart';
import 'package:deck_share/user/domain/user_repository.dart';


class UserServices {
  final UserRepository repository;

  UserServices({required this.repository});

  Future<List<UserProfile>> getAllUserProfile() async
  {
    return await repository.getAllUserProfile();
  }

  Future<List<UserProfile>> searchUser(String? name, String? phone) async
  {
    final all = await getAllUserProfile();
    return all.where((sc) => sc.name.contains(name!) || sc.phone == phone).toList();
  }

  Future<UserProfile> getUserInformation() async
  {
    return await repository.getUserInformation();
  }

  Future<void> saveUser(UserProfile user)async
  {
    await repository.saveUser(user);
  }
}