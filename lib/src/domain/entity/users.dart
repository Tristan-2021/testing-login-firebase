import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final String email, id, message;
  final String? photo;

  const Users(
      {required this.email,
      required this.id,
      this.photo = '',
      this.message = ''});

  @override
  List<Object?> get props => [email, id, photo, message];
  static const empty = Users(id: '', email: '', message: '');
  static const ingresando = Users(id: '', email: '', message: 'ingresado');
}
