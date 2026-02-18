import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class BaseFirebaseRepository<T> {
  final _firestore = FirebaseFirestore.instance;

  String getCollectionName();
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T item);
  String? getId(T item);
  T setId(T item, String id);

  Future<List<T>> getAll() async {
    QuerySnapshot allRemoteItems = await _getUserDocument()
        .collection(getCollectionName())
        .get();
    List<T> allReturnedObject = [];
    for (QueryDocumentSnapshot doc in allRemoteItems.docs) {
      String docId = doc.id;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = docId;
      allReturnedObject.add(fromJson(data));
    }
    return allReturnedObject;
  }

  Future<T> getById(String id) async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("User not authenticated");
    }
    DocumentSnapshot doc = await _getUserDocument()
        .collection(getCollectionName())
        .doc(id)
        .get();

    if (!doc.exists) {
      throw Exception("Document with id $id  not found");
    }

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return fromJson(data);
  }

  Future<void> save(T item) async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User not authenticated');
    }
    T tmpItem = item;
    if (getId(item) == null || getId(item)!.isEmpty)
    {
      tmpItem = setId(item, _generateId());
    }
    await _getUserDocument()
        .collection(getCollectionName())
        .doc(getId(tmpItem))
        .set(toJson(tmpItem));
  }

  Future<void> delete(String id) async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User not authenticated');
    }
    _getUserDocument().collection(getCollectionName()).doc(id).delete();
  }

  DocumentReference _getUserDocument() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return _firestore.collection("users").doc(currentUser!.uid);
  }

  String _generateId() {
    return UniqueKey().hashCode.toString();
  }
}
