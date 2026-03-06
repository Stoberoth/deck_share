import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deck_share/user/domain/user_model.dart';
import 'package:deck_share/user/domain/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class UserFirebaseRepository 
    implements UserRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<List<UserProfile>> getAllUserProfile() async{
    List<UserProfile> list = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null)
    {
      throw Exception("User not authenticated");
    }
    QuerySnapshot allUsers = await _firestore.collection("users").get();
    for( QueryDocumentSnapshot doc in allUsers.docs)
    {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      list.add(UserProfile.fromJson(data));
    }
    return list;

  }

  @override
  Future<UserProfile> getUserInformation() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    try{
    DocumentSnapshot doc = await _firestore
        .collection("users")
        .doc(currentUser!.uid)
        .get();
    if(!doc.exists)
    {
      return UserProfile(name: "");
    }
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserProfile.fromJson(data);
    }
    catch(e)
    {
      throw Exception("Trouble");
    }
  }

  @override
  Future<void> saveUser(UserProfile user) async {
    UserProfile tmpUser = user.copyWith();
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("User not authenticated");
    }
    if (user.id == null || user.id!.isEmpty) {
      tmpUser = user.copyWith(id: _generateId());
    }
    User? currentUser = FirebaseAuth.instance.currentUser;
    await _firestore
        .collection("users")
        .doc(currentUser!.uid)
        .set(tmpUser.toJson());
  }

  String _generateId() {
    return UniqueKey().hashCode.toString();
  }
  
  @override
  Future<List<UserProfile>> getUserByInformation(String? name, String? phone) async {
    final all = await getAllUserProfile();
    if (name == null || name.isEmpty)
    {
      if(phone == null || phone.isEmpty)
      {
        return all;
      }
      else
      {
        return all.where((sc) => sc.phone == phone).toList();
      }
    }
    else
    {
      if(phone == null || phone.isEmpty){
        return all.where((sc) => sc.name == name).toList();
      }
      else
      {
        return all.where((sc) => sc.name == name && sc.phone == phone).toList();
      }
    }
  
  }
}
