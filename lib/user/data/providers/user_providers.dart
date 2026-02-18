
import 'package:deck_share/user/data/user_firebase_repository.dart';
import 'package:deck_share/user/domain/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userFirebaseRepositoryProvider = Provider<UserRepository>((ref) => UserFirebaseRepository());