
import 'package:deck_share/contact/data/contact_repository.dart';
import 'package:deck_share/contact/domain/contact_model.dart';
import 'package:deck_share/user/application/user_services.dart';
import 'package:deck_share/user/domain/user_model.dart';

class ContactService {
  final ContactRepository repository;
  final UserServices userServices;

  ContactService({required this.repository, required this.userServices});

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

  Future<Contact> getContactById(String id) async{
    return repository.getContactById(id);
  }

  Future<void> syncContactAndUser() async
  {
    final all = await getAllContact();
    final contact = all.where((element) => element.userId == null || element.userId!.isEmpty);
    final allUser = await userServices.getAllUserProfile();
    for (var c in contact) {
      var u = allUser.firstWhere((user) => user.phone == c.phone, orElse: () => UserProfile(name: ""),);
      if (u.name != "")
      {
        saveContact(c.copyWith(isRegistered: true, userId: u.id));
      }
    }
  }
}