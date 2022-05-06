import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/failure/failure.dart';
import '../../../domain/usecase/use_case.dart';

part 'createacount_state.dart';

class CreateacountCubit extends Cubit<CreateacountState> {
  late final UsecaseLogin reposiAuthService;

  CreateacountCubit(this.reposiAuthService) : super(const CreateacountState());
  Future<void> getCreateACountInial() async {
    emit(const CreateacountState());
  }

  Future<void> getCreateACount(String email, String pasword) async {
    emit(const CreateacountState(status: Auth2StatusLogin.cargando));

    var s = await reposiAuthService.getCreateAcount(email, pasword);
    // var s = await reposiAuthService.
    // emit(const CubitloginState(status: Auth2StatusLogin.cargando));

    getDataOrFailure(s);
  }

  getDataOrFailure(Either<Failure, String> s) {
    return s.fold(
        (l) => emit(state.copyWith(
            mensaje: l.message, status: Auth2StatusLogin.Insuccesful)),
        (r) => emit(
            state.copyWith(mensaje: r, status: Auth2StatusLogin.Succesful)));
  }
}
