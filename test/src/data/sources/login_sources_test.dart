import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_login/src/core/failure/failure.dart';
import 'package:test_login/src/data/data_sources/login_sources.dart';

import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_login/src/data/model/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

const _mockFirebaseUserUid = 'mock-uid';
const _mockFirebaseUserEmail = 'mock-email';

class MockLoginfirebaseRemoteAbstr extends Mock
    implements FirebaseDataLoginImpl {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

class FakeUserCredential extends Fake implements firebase_auth.AuthCredential {}

//class AuthProvider {}

class MockCredentialGoogleAuth extends Mock implements GoogleAuthCredential {}

void main() {
  late final LoginfirebaseRemoteAbstr firebaseDataLoginImpl;
  const testPassword = '1214dqwawa';
  const testemail = 'testin@gmail.com';

  late final MockFirebaseAuth mockFirebaseAuth;
  setUpAll(() {
    mockFirebaseAuth = MockFirebaseAuth();
    firebaseDataLoginImpl = FirebaseDataLoginImpl(
      firebaseAuth: mockFirebaseAuth,
    );
  });
  const usersNull = UserModel(email: '', id: '', menssage: 'null');
  const uesrs = UserModel(
      id: _mockFirebaseUserUid,
      email: _mockFirebaseUserEmail,
      menssage: 'autenticated');

  group('Test Data-Sources getUsercurrent', () {
    test('should return Users valid', () async {
      final mockFirebaseUser = MockFirebaseUser();
      when(() => mockFirebaseUser.email).thenReturn(_mockFirebaseUserEmail);
      when(() => mockFirebaseUser.uid).thenReturn(_mockFirebaseUserUid);

      when(() => mockFirebaseAuth.authStateChanges())
          .thenAnswer((invocation) => Stream.value(mockFirebaseUser));

      await expectLater(firebaseDataLoginImpl.getUsercurrent(),
          emitsInOrder(const <UserModel>[uesrs]));
    });

    test('should return Users invalid', () async {
      when(() => mockFirebaseAuth.authStateChanges())
          .thenAnswer((invocation) => Stream.value(null));

      await expectLater(firebaseDataLoginImpl.getUsercurrent(),
          emitsInOrder(const <UserModel>[usersNull]));
    });
  });
  group('CreateAcount', () {
    setUp(() {
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer((_) => Future.value(MockUserCredential()));
    });
    test('when call the FirebasAtuh is successful ', () async {
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer((_) => Future.value(MockUserCredential()));

      // await firebaseDataLoginImpl.getCreateAcount(
      //     email: testemail, pasword: testPassword);
      await firebaseDataLoginImpl.getCreateAcount(
          email: testemail, pasword: testPassword);
      verify(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: testemail, password: testPassword),
      ).called(1);
    });
    test(
        'when call the FirebasEAuth is not successful and return firebaseAuthException',
        () async {
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'))).thenThrow(Exception);

      expect(
          firebaseDataLoginImpl.getCreateAcount(
              email: testemail, pasword: testPassword),
          throwsA(isA<FailureCreateAcount>()));
    });
  });

  group('Login(SignIn)  ', () {
    setUp(() {
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer((_) => Future.value(MockUserCredential()));
    });
    test('Login(SignIn) successful ', () async {
      await firebaseDataLoginImpl.getIngresarAcount(
          email: 'email', pasword: 'pasword');

      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'))).called(1);
    });

    test('Login successful completes ', () async {
      expect(
          firebaseDataLoginImpl.getIngresarAcount(
              email: 'email', pasword: 'pasword'),
          completes);
    });

    test('Login is not successful', () {
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'))).thenThrow(Exception());
      expect(
          () => firebaseDataLoginImpl.getIngresarAcount(
              email: 'email', pasword: 'pasword'),
          throwsA(isA<FailureSigInt>()));
    });
  });

  group('logout', () {
    setUp(() {});

    test('logaouts ', () async {
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});

      await firebaseDataLoginImpl.signOut();
      verify(() => mockFirebaseAuth.signOut()).called(1);
    });
    test('throws ServerException  when sigOut ', () async {
      when(() => mockFirebaseAuth.signOut()).thenThrow(Exception());

      expect(() => firebaseDataLoginImpl.signOut(), throwsA(isA<Exception>()));
    });
  });
}
