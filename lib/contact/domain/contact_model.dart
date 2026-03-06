import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_model.freezed.dart';
part 'contact_model.g.dart';

@freezed
abstract class Contact with _$Contact {
  const factory Contact({
    String? id,
    String? userId, // Id récupérer depuis le User Firebase
    required String name,
    String? email,
    String? phone,
    @Default(false) bool isRegistered, // know if the user is registered or not
  }) = _Contact;

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
}
