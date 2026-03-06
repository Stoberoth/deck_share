import 'package:deck_share/contact/data/contact_firebase_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ContactRepositoryProvider = Provider((ref) => ContactFirebaseRepository());