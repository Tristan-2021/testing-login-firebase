import 'package:dartz/dartz.dart';

import '../../core/failure/failure.dart';
import '../entity/users.dart';
import '../repositories/login_repo.dart';

class UsecaseLogin {
  final RepositiLogin repositiDomainLogin;

  const UsecaseLogin(this.repositiDomainLogin);

  Stream<Either<Failure, Users>> call() => repositiDomainLogin.getUsercurrent();

  Future<Either<Failure, String>> getIngresarAcount(
          String email, String pasword) =>
      repositiDomainLogin.getIngresarAcount(email: email, pasword: pasword);

  Future<Either<Failure, String>> getCreateAcount(
          String email, String pasword) =>
      repositiDomainLogin.getCreateAcount(email: email, pasword: pasword);

  Future<Either<Failure, String>> signOut() => repositiDomainLogin.signOut();
}
