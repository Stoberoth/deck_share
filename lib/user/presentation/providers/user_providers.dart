import 'package:deck_share/user/application/providers/user_providers.dart';
import 'package:deck_share/user/presentation/controller/user_controller.dart';
import 'package:deck_share/user/presentation/controller/user_list_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userControllerProvider = StateNotifierProvider(
  (ref) => UserController(userServices: ref.read(userServicesProvider)),
);

final userListControllerProvider = StateNotifierProvider(
  (ref) => UserListController(userServices: ref.read(userServicesProvider)),
);
