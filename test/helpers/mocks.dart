import 'package:mocktail/mocktail.dart';
import 'package:test_login/src/domain/entity/users.dart';
import 'package:test_login/src/domain/usecase/use_case.dart';

const mockemail = 'testemail@gmail.com';
const mockpassword = '1234523as6';

class MockUsers extends Mock implements Users {}

class MockGetUseCase extends Mock implements UsecaseLogin {}
