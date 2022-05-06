part of 'loginusers_cubit.dart';

enum Auth2Status {
  // ignore: constant_identifier_names
  NoAthenticate,
  // ignore: constant_identifier_names
  Ingresando,
  // ignore: constant_identifier_names
  Athenticate,
  saliendo,
}

extension Page2SattusExtension on Auth2Status {
  bool get isNoatenticated => this == Auth2Status.NoAthenticate;
  bool get isAutenticate => this == Auth2Status.Athenticate;
  bool get isIngresando => this == Auth2Status.Ingresando;
  bool get issaliendo => this == Auth2Status.saliendo;
}

class LoginusersState extends Equatable {
  final Auth2Status status;
  final Users usaurio;
  final String mensaje;
  const LoginusersState({
    this.status = Auth2Status.NoAthenticate,
    this.usaurio = Users.empty,
    this.mensaje = '',
  });

  @override
  List<Object> get props => [
        usaurio,
        status,
        mensaje,
      ];

  LoginusersState copywith(
          {Auth2Status? status,
          Users? usaurio,
          String? mensaje,
          bool? ingreso}) =>
      LoginusersState(
        status: status ?? this.status,
        usaurio: usaurio ?? this.usaurio,
        mensaje: mensaje ?? this.mensaje,
      );
}
