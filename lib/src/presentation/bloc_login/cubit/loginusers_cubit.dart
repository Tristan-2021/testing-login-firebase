import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/failure/failure.dart';
import '../../../domain/entity/users.dart';
import '../../../domain/usecase/use_case.dart';

part 'loginusers_state.dart';

class LoginusersCubit extends Cubit<LoginusersState> {
  late final UsecaseLogin reposiAuthService;
  LoginusersCubit(this.reposiAuthService) : super(const LoginusersState());
  //late final ReposiAuthService sreposiAuthService = ReposiAuthService();
  // ReposiAuthService _reposiAuthService = ReposiAuthService();
  StreamSubscription<Either<Failure, Users>>? _streamSubscription;
  //StreamSubscription<Users>? _streamSubscriptions;

  Future<void> getUseres() async {
    _streamSubscription = reposiAuthService.call().listen((event) async {
      return event.fold((l) {
        return emit(state.copywith(
            status: Auth2Status.NoAthenticate,
            usaurio: Users.empty,
            mensaje: l.message,
            ingreso: false));
      }, (r) {
        return emit(state.copywith(
            status: Auth2Status.Athenticate,
            usaurio: r,
            mensaje: r.message,
            ingreso: true));
      });
    });
  }

  Future<void> isIngresar(String email, String pasword) async {
    emit(state.copywith(
        status: Auth2Status.Ingresando,
        usaurio: Users.ingresando,
        mensaje: 'l.mensaje',
        ingreso: false));
    var s = await reposiAuthService.getIngresarAcount(email, pasword);
    gerFailureorData(s);
    // return s.fold(
    //   (l) => l.message,
    //   (r) => r.message,
    // );
  }

  Future gerFailureorData(Either<Failure, String> ds) async {
    return ds.fold((l) {
      emit(state.copywith(
          status: Auth2Status.NoAthenticate,
          usaurio: Users.empty,
          mensaje: l.message,
          ingreso: false));
    }, (r) {
      return emit(state.copywith(
          status: Auth2Status.Athenticate,
          usaurio: Users.ingresando,
          mensaje: r,
          ingreso: true));
    });
  }

  // Future<void> getCreateReposrti(String email, String pasword) async {
  //   emit(state.copywith(
  //       status: Auth2Status.Ingresando,
  //       usaurio: Users.ingresando,
  //       mensaje: ' l.message',
  //       ingreso: true));
  //   try {
  //     await _reposiAuthService.createACount(email: email, pasword: pasword);
  //     emit(state.copywith(
  //         status: Auth2Status.Athenticate,
  //         usaurio: Users.ingresando,
  //         mensaje: 'exito',
  //         ingreso: false));
  //     //_streamSubscriptions?.resume();
  //   } catch (e) {
  //     emit(state.copywith(
  //         status: Auth2Status.NoAthenticate,
  //         usaurio: Users.empty,
  //         mensaje: e.toString(),
  //         ingreso: true));
  //   }
  // }

  Future<void> signOut() async {
    // emit(state.copywith(
    //     status: Auth2Status.Ingresando,
    //     usaurio: Users.ingresando,
    //     mensaje: 'Vuelve Pronto!',
    //     ingreso: false));
    // await Future.delayed(const Duration(seconds: 2));
    var s = await reposiAuthService.signOut();
    gerFailureorDataLogout(s);
  }

  Future gerFailureorDataLogout(Either<Failure, String> ds) async {
    return ds.fold((l) {
      emit(state.copywith(
          status: Auth2Status.Athenticate,
          usaurio: Users.empty,
          mensaje: l.message,
          ingreso: false));
    }, (r) {
      return emit(state.copywith(
          status: Auth2Status.saliendo,
          usaurio: Users.ingresando,
          mensaje: r,
          ingreso: true));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
