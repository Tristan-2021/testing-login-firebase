import 'package:flutter_test/flutter_test.dart';
import 'package:test_login/src/data/data_sources/login_sources.dart';
import 'package:test_login/src/data/reposity/repo_data.dart';
import 'package:test_login/src/domain/repositories/login_repo.dart';
import 'package:test_login/src/myapp/injeci.dart';
import 'package:test_login/src/presentation/bloc_login/cubit/loginusers_cubit.dart';

import '../../helpers/mocks.dart';

void main() {
  late final MockFirebaseAuth mockFirebaseAuth;
  // ignore: unused_local_variable
  late final MockInternetConnectionChecker mockInternetConnectionChecker;
  late final MockUsecaseLogin mockUsecaseLogin;
  late final MockNetwork mockNetwork;

  late final MockLoginfirebaseRemoteAbstr mockLoginfirebaseRemoteAbstr;
  setUpAll(() async {
    mockUsecaseLogin = MockUsecaseLogin();
    mockNetwork = MockNetwork();
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    mockFirebaseAuth = MockFirebaseAuth();
    mockLoginfirebaseRemoteAbstr = MockLoginfirebaseRemoteAbstr();

    await getInyecionDependecies();
    await sl.reset();
  });
  group('Test Inyecion Dependencie', () {
    test('Registersinglenton Cubitlogin', () async {
      // final getInit = GetIt.instance;
      sl.registerFactory(() => LoginusersCubit(mockUsecaseLogin));

      var s = sl.isRegistered<LoginusersCubit>();
      expect(s, true);
      //  bool isRegistered<T>({Object istance, String nameinstanceName });
    });
    test('RegisterLazySingleton RepositiLogin', () async {
      sl.registerLazySingleton<RepositiLogin>(
          () => LoginRepoDomainImpl(mockLoginfirebaseRemoteAbstr, mockNetwork));

      RepositiLogin s = sl<RepositiLogin>();
      expect(s is LoginRepoDomainImpl, true);
    });

    test('RegisterLazySingleton LoginfirebaseRemoteAbstr', () async {
      sl.registerLazySingleton<LoginfirebaseRemoteAbstr>(
          () => FirebaseDataLoginImpl(
                firebaseAuth: mockFirebaseAuth,
              ));

      LoginfirebaseRemoteAbstr s = sl<LoginfirebaseRemoteAbstr>();
      expect(s is FirebaseDataLoginImpl, true);
    });

    //Todo:Inyección External
  });
}
