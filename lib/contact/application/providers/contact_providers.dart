import 'package:deck_share/contact/application/contact_service.dart';
import 'package:deck_share/contact/data/providers/contact_providers.dart';
import 'package:deck_share/user/application/providers/user_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactServiceProvider = Provider(
  (ref) => ContactService(repository: ref.watch(ContactRepositoryProvider), userServices: ref.watch(userServicesProvider)),
);

final contactListProvider = FutureProvider((ref) => ref.read(contactServiceProvider).getAllContact());