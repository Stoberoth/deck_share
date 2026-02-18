import 'package:deck_share/user/application/user_services.dart';
import 'package:deck_share/user/domain/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserController extends StateNotifier<AsyncValue<UserProfile>> {
  final UserServices userServices;

  UserController({required this.userServices})
    : super(const AsyncValue.data(UserProfile(name: "")));

  Future<void> getUserInformation() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await userServices.getUserInformation();
      return result;
    });
  }
}
