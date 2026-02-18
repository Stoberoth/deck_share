import 'package:deck_share/user/application/user_services.dart';
import 'package:deck_share/user/data/providers/user_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userServicesProvider = Provider(
  (ref) => UserServices(repository: ref.read(userFirebaseRepositoryProvider)),
);
