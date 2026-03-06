
import 'package:deck_share/contact/data/contact_repository.dart';
import 'package:deck_share/contact/domain/contact_model.dart';

class ContactService {
  final ContactRepository repository;

  ContactService({required this.repository});

  Future<void> saveContact(Contact contact) async
  {
    await repository.saveContact(contact);
  }

  Future<void> deleteContact(String id) async
  {
    await repository.deleteContact(id);
  }

  Future<bool> isAlreadyInContact(String phone) async{
    return await repository.isAlreadyInContact(phone);
  }

  Future<List<Contact>> getAllContact() async
  {
    return repository.getAllContacts();
  }

  Future<void> syncContactAndUser() async
  {
    throw UnimplementedError();
  }
}