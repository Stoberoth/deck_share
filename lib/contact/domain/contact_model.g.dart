// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Contact _$ContactFromJson(Map<String, dynamic> json) => _Contact(
  id: json['id'] as String?,
  userId: json['userId'] as String?,
  name: json['name'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  isRegistered: json['isRegistered'] as bool? ?? false,
);

Map<String, dynamic> _$ContactToJson(_Contact instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'isRegistered': instance.isRegistered,
};
