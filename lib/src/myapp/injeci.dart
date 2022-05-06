import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get_it/get_it.dart';

import '../core/conection/conection.dart';
import '../data/data_sources/login_sources.dart';
import '../data/reposity/repo_data.dart';
import '../domain/repositories/login_repo.dart';
import '../domain/usecase/use_case.dart';
import '../presentation/bloc_create_acount/cubit/createacount_cubit.dart';
import '../presentation/bloc_login/cubit/loginusers_cubit.dart';

final firebase = FirebaseAuth.instance;
final check = InternetConnectionChecker();
GetIt sl = GetIt.instance;

Future<void> getInyecionDependecies() async {
  var s = await check.hasConnection;
  await getInit(s);
}

Future<void> getInit(bool s) async {
  //Todo:Inyección Cubit
  sl.registerFactory(() => LoginusersCubit(sl()));
  sl.registerFactory(() => CreateacountCubit(sl()));

  //Todo:Inyección UseCAse
  sl.registerLazySingleton(() => UsecaseLogin(sl()));

  //Todo:Inyección Domain reposityIpml
  sl.registerLazySingleton<RepositiLogin>(() => LoginRepoDomainImpl(
        sl(),
        sl(),
      ));

  //Todo:Inyección Data_Soruces
  sl.registerLazySingleton<LoginfirebaseRemoteAbstr>(
      () => FirebaseDataLoginImpl(
            firebaseAuth: sl(),
          ));

  //Todo:Inyección Network
  sl.registerLazySingleton<Network>(() => NetorkImpl(sl()));

  //Todo:Inyección External
  sl.registerLazySingleton(() => s);
  sl.registerLazySingleton(() => firebase);
}
