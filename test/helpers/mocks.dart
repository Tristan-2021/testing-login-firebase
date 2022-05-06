import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_login/src/core/conection/conection.dart';
import 'package:test_login/src/data/data_sources/login_sources.dart';
import 'package:test_login/src/domain/entity/users.dart';
import 'package:test_login/src/domain/usecase/use_case.dart';

const mockemail = 'testemail@gmail.com';
const mockpassword = '1234523as6';

class MockUsers extends Mock implements Users {}

class MockGetUseCase extends Mock implements UsecaseLogin {}

class MockUsecaseLogin extends Mock implements UsecaseLogin {}

class MockNetwork extends Mock implements Network {}

class MockLoginfirebaseRemoteAbstr extends Mock
    implements LoginfirebaseRemoteAbstr {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}
