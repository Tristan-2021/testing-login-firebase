import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

// Failures generales de la app
class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message: message);

//  factory ServerFailure.fromCode(String mensaje){

//    return 'scas';
//   }
}

class LOginFailurefirebase implements Exception {
  final String mensaje;
  const LOginFailurefirebase([this.mensaje = 'error nuevo']);

  factory LOginFailurefirebase.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LOginFailurefirebase(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LOginFailurefirebase(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LOginFailurefirebase(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LOginFailurefirebase(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LOginFailurefirebase(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LOginFailurefirebase(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LOginFailurefirebase(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LOginFailurefirebase(
          'The credential verification ID received is invalid.',
        );

      default:
        return const LOginFailurefirebase(
            'account exist with differente credentials');
    }
  }
}

class FailureCreateAcount implements Exception {
  final String name;
  const FailureCreateAcount(
      [this.name = 'Error Inesperado o \nno tienes Internet']);

  factory FailureCreateAcount.fromCode(String error) {
    switch (error) {
      case 'email-already-in-use':
        return const FailureCreateAcount('El correo est?? en uso');

      case 'invalid-email':
        return const FailureCreateAcount('El correo ingresado no es V??lido');
      case 'operation-not-allowed':
        return const FailureCreateAcount('No est?? habilitado');
      case 'weak-password':
        return const FailureCreateAcount('Contrase??a muy d??bil');
      default:
        return const FailureCreateAcount();
    }
  }
}

class FailureSigInt implements Exception {
  final String name;
  const FailureSigInt([this.name = 'Error Inesperado']);

  factory FailureSigInt.fromCode(String mensaje) {
    switch (mensaje) {
      case 'account-exists-with-different-credential':
        return const FailureSigInt(
          'La cuenta existe con diferente credencial',
        );
      case 'invalid-credential':
        return const FailureSigInt(
          'La credencial est?? mal formado o ha Caducado.',
        );
      case 'operation-not-allowed':
        return const FailureSigInt(
          'La Operaci??n no es permitida, Por favor contacte con supervisor.',
        );
      case 'user-disabled':
        return const FailureSigInt(
          'El usuario no est?? habilitado. Por favor contacte con supervisor.',
        );
      case 'user-not-found':
        return const FailureSigInt(
          'Correo no encontrado, por favor crea una cuenta.',
        );
      case 'wrong-password':
        return const FailureSigInt(
          'Contrase??a Incorrecta, intente de nuevo.',
        );
      case 'invalid-verification-code':
        return const FailureSigInt(
          'La credencial recibida es inv??lida',
        );
      case 'invalid-verification-id':
        return const FailureSigInt(
          'La credencial recibida de ID inv??lida ',
        );

      default:
        return const FailureSigInt(
            'No tienes Internet o Hubo un error inesperado');
    }
  }
}

class FailureGoogleSignin implements Exception {
  final String name;
  const FailureGoogleSignin([this.name = "Error Inesperado"]);

  factory FailureGoogleSignin.fromCode(String mensaje) {
    switch (mensaje) {
      case 'account-exists-with-different-credential':
        return const FailureGoogleSignin(
            'Cuenta existente con varias credenciales');
      case 'invalid-credential':
        return const FailureGoogleSignin('Credenciales inv??lidas');

      case 'operation-not-allowed':
        return const FailureGoogleSignin(
            'El tipo de cuenta no est?? habilitada');
      case 'user-disabled':
        return const FailureGoogleSignin(
            'El Usuario tiene una credencual desahabilitada');
      case 'user-not-found':
        return const FailureGoogleSignin(
            'No hay un usaurio correspondiente al correo');
      case 'wrong-password':
        return const FailureGoogleSignin('La contrase??a no es v??lida');
      case 'invalid-verification-code':
        return const FailureGoogleSignin(
            'El c??digo de verificaci??n no es v??lido');
      case 'invalid-verification-id':
        return const FailureGoogleSignin(
            'El c??digo de verificaci??n no es v??lido');
      default:
        return const FailureGoogleSignin();
    }
  }
}
