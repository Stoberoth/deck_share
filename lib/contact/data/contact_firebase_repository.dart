import 'package:deck_share/contact/data/contact_repository.dart';
import 'package:deck_share/contact/domain/contact_model.dart';
import 'package:deck_share/core/data/base_firebase_repository.dart';

class ContactFirebaseRepository extends BaseFirebaseRepository<Contact>
    implements ContactRepository {
  @override
  Future<void> deleteContact(String id) async {
    await delete(id);
  }

  @override
  Contact fromJson(Map<String, dynamic> json) {
    return Contact.fromJson(json);
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    return await getAll();
  }

  @override
  String getCollectionName() {
    return "contact";
  }

  @override
  Future<Contact> getContactById(String id) async {
    return await getById(id);
  }

  @override
  String? getId(Contact item) {
    return item.id;
  }

  @override
  Future<void> saveContact(Contact contact) async {
    await save(contact);
  }

  @override
  Future<bool> isAlreadyInContact(String phone) async
  {
    final all = await getAll();
    if(all.where((sc) => sc.phone == phone).toList().isNotEmpty)
    {
      return true;
    }
    return false;
  }

  @override
  Future<Contact> searchContact(String query) {
    // TODO: implement searchContact
    throw UnimplementedError();
  }

  @override
  Contact setId(Contact item, String id) {
    return item.copyWith(id:id);
  }

  @override
  Map<String, dynamic> toJson(Contact item) {
    return item.toJson();
  }
}
