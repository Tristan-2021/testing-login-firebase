import 'package:firebase_auth/firebase_auth.dart';

import '../../core/failure/failure.dart';
import '../model/users_model.dart';

abstract class LoginfirebaseRemoteAbstr {
  Stream<UserModel> getUsercurrent();
  Future<void> getIngresarAcount(
      {required String email, required String pasword});
  String get name;
  Future<void> getCreateAcount(
      {required String email, required String pasword});
  Future<void> signOut();
}

class FirebaseDataLoginImpl extends LoginfirebaseRemoteAbstr {
  late final FirebaseAuth firebaseAuth;

  late String _user;
  FirebaseDataLoginImpl({
    required this.firebaseAuth,
  });

  @override
  Future<void> getIngresarAcount(
      {required String email, required String pasword}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pasword,
      );
    } on FirebaseAuthException catch (e) {
      throw FailureSigInt.fromCode(e.code);
    } catch (e) {
      throw const FailureSigInt();
    }
  }

  @override
  Stream<UserModel> getUsercurrent() {
    return firebaseAuth.authStateChanges().map((event) {
      try {
        _user = event?.uid ?? '';
        return UserModel(
            email: event!.email!, id: event.uid, menssage: 'autenticated');
      } catch (e) {
        return const UserModel(email: '', id: '', menssage: 'null');
      }
    });
  }

  @override
  String get name {
    return _user;
  }

  @override
  Future<void> getCreateAcount(
      {required String email, required String pasword}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pasword);
    } on FirebaseAuthException catch (e) {
      throw FailureCreateAcount.fromCode(e.code);
    } catch (e) {
      throw const FailureCreateAcount();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        firebaseAuth.signOut(),
      ]);
    } catch (e) {
      throw Exception();
    }
  }
}
