import 'package:deck_share/contact/application/contact_service.dart';
import 'package:deck_share/contact/data/providers/contact_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactServiceProvider = Provider(
  (ref) => ContactService(repository: ref.watch(ContactRepositoryProvider)),
);

final contactListProvider = FutureProvider((ref) => ref.read(contactServiceProvider).getAllContact());