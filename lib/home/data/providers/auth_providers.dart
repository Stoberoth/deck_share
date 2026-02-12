
import 'package:deck_share/home/data/firebase_auth_repository.dart';
import 'package:deck_share/home/domain/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) => FirebaseAuthRepository());