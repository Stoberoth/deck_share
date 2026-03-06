import 'package:deck_share/user/application/user_services.dart';
import 'package:deck_share/user/domain/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListController extends StateNotifier<AsyncValue<List<UserProfile>>> {
  final UserServices userServices;

  UserListController({required this.userServices})
    : super(const AsyncValue.data([]));

  Future<void> getAllUserProfile() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await userServices.getAllUserProfile();
      return result;
    });
  }
}
