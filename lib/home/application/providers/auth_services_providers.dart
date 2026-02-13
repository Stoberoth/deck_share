import 'package:deck_share/home/application/firebase_auth_service.dart';
import 'package:deck_share/home/data/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(ref.watch(authRepositoryProvider)),
);
