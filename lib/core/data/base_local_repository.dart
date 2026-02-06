import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

abstract class BaseLocalRepository<T> {
  // Méthodes abstraites
  String getFileName();
  String getCollectionName();
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T item);
  String? getId(T item);
  void setId(T item, String id);

  // Méthode communes
  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/${getFileName()}");
  }

  Future<Map<String, dynamic>> _readJsonFile() async {
    final file = await _getFile();
    if (!file.existsSync()) {
      file.create();
    }
    final jsonString = await file.readAsString();
    if (jsonString.isEmpty) {
      return <String, dynamic>{};
    }
    return jsonDecode(jsonString);
  }

  Future<void> _writeJsonFile(Map<String, dynamic> json) async {
    final file = await _getFile();
    await file.writeAsString(jsonEncode(json));
  }

  Future<List<T>> getAll() async {
    final content = await _readJsonFile();
    final collection = content[getCollectionName()] as List?;
    if (collection == null) return [];
    return collection
        .map((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<T> getById(String id) async {
    final content = await _readJsonFile();
    final collection = content[getCollectionName()] as List;
    final itemJson = collection.firstWhere((e) => e["id"] == id);
    return fromJson(itemJson as Map<String, dynamic>);
  }

  Future<void> save(T item) async
  {
    if (getId(item)?.isEmpty ?? true)
    {
      setId(item, UniqueKey().toString());
    }
    final content = await _readJsonFile();
    
    // Initialiser la collection si elle n'existe pas
    if (!content.containsKey(getCollectionName())) {
      content[getCollectionName()] = [];
    }
    
    final collection = content[getCollectionName()] as List;

    final index = collection.indexWhere((e) => e["id"] == getId(item));

    if(index != -1)
    {
      collection[index] = toJson(item);
    }
    else
    {
      collection.add(toJson(item));
    }

    await _writeJsonFile(content);
  }

  Future<void> delete(String id) async
  {
    final content = await _readJsonFile();
    final collection = content[getCollectionName()] as List;

    collection.removeWhere((e) => e["id"] == id);

    await _writeJsonFile(content);
  }
}
