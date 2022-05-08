import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_login/src/core/conection/conection.dart';
import 'package:test_login/src/core/failure/failure.dart';
import 'package:test_login/src/data/data_sources/login_sources.dart';
import 'package:test_login/src/data/model/users_model.dart';
import 'package:test_login/src/data/reposity/repo_data.dart';
import 'package:test_login/src/domain/entity/users.dart';

class MockLoginfirebaseRemoteAbstr extends Mock
    implements LoginfirebaseRemoteAbstr {}

class MockNetwork extends Mock implements Network {}

void main() {
  StreamSubscription<Either<Failure, Users>>? _streamSubscription;

  const testPassword = '1214dqwawa';
  const testemail = 'testin@gmail.com';
  // ignore: unused_local_variable
  late final MockLoginfirebaseRemoteAbstr mockLoginfirebaseRemoteAbstr;
  late final MockNetwork mockNetwork;
  late final LoginRepoDomainImpl loginRepoDomainImpl;
  //late StreamSubscription<Either<Failure, Users>> _streamSubscription;
  const uesrs = UserModel(
      email: 'event!.email!', id: 'event.uid', menssage: 'autenticated');
  const usuario1 = UserModel(
      email: 'event!.email!', id: 'event.uid', menssage: 'autenticated');
  callWhenUser() {
    when(() => mockLoginfirebaseRemoteAbstr.getCreateAcount(
        email: testemail,
        pasword: testPassword)).thenAnswer((_) => Future.value());
  }

  setUpAll(() {
    mockLoginfirebaseRemoteAbstr = MockLoginfirebaseRemoteAbstr();
    mockNetwork = MockNetwork();
    loginRepoDomainImpl = LoginRepoDomainImpl(
      mockLoginfirebaseRemoteAbstr,
      mockNetwork,
    );
    callWhenUser();
  });

  group('should return remtoe data when the call remote darta soruces   ', () {
    test('should return message failure  when not contection internet',
        () async {
      when(() => mockNetwork.isConnect).thenAnswer((_) => false);
      when(() => mockLoginfirebaseRemoteAbstr.getUsercurrent()).thenAnswer(
          (_) => Stream.value(
              const UserModel(email: '', id: '', menssage: 'null')));

      _streamSubscription =
          loginRepoDomainImpl.getUsercurrent().listen((event) {
        verify(() => mockLoginfirebaseRemoteAbstr.getUsercurrent()).called(1);
        verify(() => mockNetwork.isConnect).called(1);
        expect(event, const Left(Failure(message: 'No Tienes Internet')));
      });
    });

    test(
        'should return a  Users null  when you have connection a internet become is not authenticated ',
        () async {
      when(() => mockNetwork.isConnect).thenAnswer((_) => true);
      when(() => mockLoginfirebaseRemoteAbstr.getUsercurrent()).thenAnswer(
          (_) => Stream.value(
              const UserModel(email: '', id: '', menssage: 'null')));

      _streamSubscription =
          loginRepoDomainImpl.getUsercurrent().listen((event) {
        //verificamos que se ha llamado una sola vez
        verify(() => mockLoginfirebaseRemoteAbstr.getUsercurrent()).called(1);
        verify(() => mockNetwork.isConnect).called(1);
        event.fold((l) {
          if (l.message == 'null') {
            expect(event,
                const Left(Failure(message: 'Error, No estás Autenticado')));
          }
        }, (r) => {});
      });
    });
    test(
        'should return a  Users  when you have contection a internet and you are authenticated  ',
        () async {
      when(() => mockNetwork.isConnect).thenAnswer((_) => true);
      when(() => mockLoginfirebaseRemoteAbstr.getUsercurrent())
          .thenAnswer((_) => Stream.value(uesrs));
      _streamSubscription =
          loginRepoDomainImpl.getUsercurrent().listen((event) {
        verify(() => mockNetwork.isConnect).called(1);
        verify(() => mockLoginfirebaseRemoteAbstr.getUsercurrent()).called(1);
        event.fold((l) {}, (r) {
          print('testung $event');

          expect(event, const Right(usuario1));
        });
      });
    });
    tearDown(() {
      _streamSubscription?.cancel();
    });
  });

  group('CreateAcoutn Users', () {
    test('User created successfully', () async {
      when(() => mockNetwork.isConnect).thenAnswer((_) => true);
      callWhenUser();
      var result = await loginRepoDomainImpl.getCreateAcount(
          email: testemail, pasword: testPassword);
      verify(() => mockLoginfirebaseRemoteAbstr.getCreateAcount(
          email: testemail, pasword: testPassword)).called(1);
      expect(
          result, equals(const Right('Se ha creado su cuenta exitosamente')));
    });
    // Todo: Hay varios escenarios en las que FirebasAtuhException maneja las excepciones
    // Todo: solo simulados  el "email-already-in-use" si gusta puede probar
    // Todo: los otros escenarios fallidos
    test('no user created yet become email-already-in-use', () async {
      when(() => mockNetwork.isConnect).thenAnswer((_) => true);
      when(() => mockLoginfirebaseRemoteAbstr.getCreateAcount(
              email: testemail, pasword: testPassword))
          // ignore: void_checks
          .thenThrow(const FailureCreateAcount('El correo está en uso'));
      var results = await loginRepoDomainImpl.getCreateAcount(
          email: testemail, pasword: testPassword);
      expect(results,
          equals(const Left(Failure(message: 'El correo está en uso'))));
    });
    test('when an exception is unexpected ', () async {
      when(() => mockNetwork.isConnect).thenAnswer((_) => true);

      when(() => mockLoginfirebaseRemoteAbstr.getCreateAcount(
          email: testemail, pasword: testPassword)).thenThrow(Exception());
      var results = await loginRepoDomainImpl.getCreateAcount(
          email: testemail, pasword: testPassword);
      expect(results, equals(const Left(Failure(message: 'Error Inesperado'))));
    });
    test('Device  have not conection a Internet and exist an Exception',
        () async {
      when(() => mockNetwork.isConnect).thenAnswer((_) => false);

      var results = await loginRepoDomainImpl.getCreateAcount(
          email: testemail, pasword: testPassword);

      expect(
          results, equals(const Left(Failure(message: 'No Tienes Internet'))));
    });
  });

  group('User Signin(Inicio de sesión)', () {
    test('when Sign in is successful and have conecction a internet ',
        () async {
      when(() => mockNetwork.isConnect).thenAnswer((_) => true);
      when(() => mockLoginfirebaseRemoteAbstr.getIngresarAcount(
          email: testemail,
          pasword: testPassword)).thenAnswer((_) => Future.value());

      var results = await loginRepoDomainImpl.getIngresarAcount(
          email: testemail, pasword: testPassword);
      expect(results, equals(const Right('Ingreso Exitoso!')));
    });

    // Todo: Hay varios escenarios de en las que FirebasAtuhException maneja
    // Todo: solo simulados  el "email-already-in-use" si gusta puede probar
    // Todo: los otros escenarios de error
    test('when Sign in is not successful and have conecction a internet',
        () async {
      when(() => mockNetwork.isConnect).thenAnswer((_) => true);
      when(() =>
          mockLoginfirebaseRemoteAbstr.getIngresarAcount(
              email: testemail,
              pasword: testPassword)).thenThrow(const FailureSigInt(
          'El usuario no está habilitado. Por favor contacte con supervisor.'));

      var results = await loginRepoDomainImpl.getIngresarAcount(
          email: testemail, pasword: testPassword);
      expect(
          results,
          equals(const Left(Failure(
              message:
                  'El usuario no está habilitado. Por favor contacte con supervisor.'))));
    });

    test(
        'when Sign in is not successful and  return Exception, have conecction a internet',
        () async {
      when(() => mockNetwork.isConnect).thenAnswer((_) => true);
      when(() => mockLoginfirebaseRemoteAbstr.getIngresarAcount(
          email: testemail, pasword: testPassword)).thenThrow(Exception());

      var results = await loginRepoDomainImpl.getIngresarAcount(
          email: testemail, pasword: testPassword);
      expect(results, equals(const Left(Failure(message: 'Error Inesperado'))));
    });

    test('when have not conection an internet', () async {
      when(() => mockNetwork.isConnect).thenAnswer((_) => false);

      var results = await loginRepoDomainImpl.getIngresarAcount(
          email: testemail, pasword: testPassword);
      expect(
          results, equals(const Left(Failure(message: 'No Tienes Internet'))));
    });
  });

  group('logout', () {
    test('Logout successful', () async {
      when(() => mockLoginfirebaseRemoteAbstr.signOut())
          .thenAnswer((_) => Future.value());
      var s = await loginRepoDomainImpl.signOut();

      expect(s, equals(const Right('Vuelve Pronto..!!')));
    });

    test('Logout is not successful', () async {
      when(() => mockLoginfirebaseRemoteAbstr.signOut()).thenThrow(Exception());

      var resulst = await loginRepoDomainImpl.signOut();

      expect(resulst, equals(const Left(Failure(message: 'Error Inesperado'))));
    });
  });
}
