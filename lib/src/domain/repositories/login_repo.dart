import 'package:dartz/dartz.dart';

import '../../core/failure/failure.dart';
import '../entity/users.dart';

abstract class RepositiLogin {
  Stream<Either<Failure, Users>> getUsercurrent();
  Future<Either<Failure, String>> signOut();

  //Todo:añadi el close para cerrar el stream;
  Future<Either<Failure, String>> getCreateAcount(
      {required String email, required String pasword});

  Future<Either<Failure, String>> getIngresarAcount(
      {required String email, required String pasword});
}
