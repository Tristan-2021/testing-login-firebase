// ignore_for_file: overridden_fields, annotate_overrides

import '../../domain/entity/users.dart';

class UserModel extends Users {
  @override
  final String email;
  final String id;
  final String menssage;
  final String? photo;

  const UserModel(
      {required this.email,
      required this.id,
      required this.menssage,
      this.photo})
      : super(email: email, id: id, photo: '');

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        id: json["id"],
        menssage: json["menssage"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "menssage": menssage,
      };

  @override
  List<Object?> get props => [email, id, menssage, photo];
}
