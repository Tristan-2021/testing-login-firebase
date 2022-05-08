import 'package:dartz/dartz.dart';

import '../../core/conection/conection.dart';
import '../../core/failure/failure.dart';
import '../../domain/entity/users.dart';
import '../../domain/repositories/login_repo.dart';
import '../data_sources/login_sources.dart';

class LoginRepoDomainImpl implements RepositiLogin {
  late final LoginfirebaseRemoteAbstr _firebaseremotelogin;
  late final Network network;

  LoginRepoDomainImpl(
    this._firebaseremotelogin,
    this.network,
  );

  @override
  Stream<Either<Failure, Users>> getUsercurrent() {
    if (network.isConnect) {
      return _firebaseremotelogin.getUsercurrent().map((event) {
        print('evento $event');

        if (event.menssage == 'null') {
          return const Left(
              Failure(message: 'Hey bienvenido, debes autenticarte'));
        } else {
          print('evento $event');

          return Right(event);
        }
      });
    } else {
      return _firebaseremotelogin.getUsercurrent().map((event) {
        return const Left(Failure(message: 'No Tienes Internet'));
      });
    }
  }

  //Todo: SigInt
  @override
  Future<Either<Failure, String>> getIngresarAcount(
      {required String email, required String pasword}) async {
    if (network.isConnect) {
      try {
        await _firebaseremotelogin.getIngresarAcount(
            email: email, pasword: pasword);

        return const Right('Ingreso Exitoso!');
      } on FailureSigInt catch (e) {
        return Left(Failure(message: e.name));
      } catch (e) {
        return const Left(Failure(message: 'Error Inesperado'));
      }
    } else {
      return const Left(Failure(message: 'No Tienes Internet'));
    }
  }

  //generar cambios

  @override
  Future<Either<Failure, String>> getCreateAcount(
      {required String email, required String pasword}) async {
    if (network.isConnect) {
      try {
        await _firebaseremotelogin.getCreateAcount(
            email: email, pasword: pasword);

        return const Right('Se ha creado su cuenta exitosamente');
      } on FailureCreateAcount catch (e) {
        return Left(Failure(message: e.name));
      } catch (e) {
        return const Left(Failure(message: 'Error Inesperado'));
      }
    } else {
      return const Left(Failure(message: 'No Tienes Internet'));
    }
  }

  @override
  Future<Either<Failure, String>> signOut() async {
    try {
      _firebaseremotelogin.signOut();

      return const Right('Vuelve Pronto..!!');
    } catch (e) {
      return const Left(Failure(message: 'Error Inesperado'));
    }
  }
}
