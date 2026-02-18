import 'package:deck_share/contact/data/contact_repository.dart';
import 'package:deck_share/contact/domain/contact_model.dart';
import 'package:deck_share/core/data/base_firebase_repository.dart';

class ContactFirebaseRepository extends BaseFirebaseRepository<Contact>
    implements ContactRepository {
  @override
  Future<void> deleteContact(String id) {
    // TODO: implement deleteContact
    throw UnimplementedError();
  }

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Future<List<Contact>> getAllContacts() {
    // TODO: implement getAllContacts
    throw UnimplementedError();
  }

  @override
  String getCollectionName() {
    return "contact";
  }

  @override
  Future<Contact> getContactById(String id) {
    // TODO: implement getContactById
    throw UnimplementedError();
  }

  @override
  String? getId(item) {
    // TODO: implement getId
    throw UnimplementedError();
  }

  @override
  Future<void> saveContact(Contact contact) async {
    await save(contact);
  }

  @override
  Future<Contact> searchContact(String query) {
    // TODO: implement searchContact
    throw UnimplementedError();
  }

  @override
  setId(item, String id) {
    // TODO: implement setId
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson(item) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
