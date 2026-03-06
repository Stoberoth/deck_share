
import 'package:deck_share/contact/domain/contact_model.dart';

abstract class ContactRepository {
  Future<List<Contact>> getAllContacts();
  Future<Contact> getContactById(String id);
  Future<void> saveContact(Contact contact);
  Future<void> deleteContact(String id);
  Future<Contact> searchContact(String query);
  Future<bool> isAlreadyInContact(String phone);
  //Future<Contact> searchUserInDb(String? name, String? phone);
}