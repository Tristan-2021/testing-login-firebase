part of 'createacount_cubit.dart';

enum Auth2StatusLogin {
  // ignore: constant_identifier_names
  // ignore: constant_identifier_names
  Succesful,
  // ignore: constant_identifier_names
  Insuccesful,
  iniciando,
  cargando
}

extension AtuhStausRegister on Auth2StatusLogin {
  bool get isSuccesful => this == Auth2StatusLogin.Succesful;
  bool get isInSuccesful => this == Auth2StatusLogin.Insuccesful;
  bool get isIniciando => this == Auth2StatusLogin.iniciando;
  bool get iscargando => this == Auth2StatusLogin.cargando;
}

class CreateacountState extends Equatable {
  const CreateacountState(
      {this.mensaje = '', this.status = Auth2StatusLogin.iniciando});
  final String mensaje;
  final Auth2StatusLogin status;

  @override
  List<Object?> get props => [mensaje, status];
  CreateacountState copyWith({String? mensaje, Auth2StatusLogin? status}) =>
      CreateacountState(
          mensaje: mensaje ?? this.mensaje, status: status ?? this.status);
}
