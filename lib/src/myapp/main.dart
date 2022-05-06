import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_login/src/myapp/myapp.dart';
import 'package:test_login/src/myapp/observer.dart';

import 'injeci.dart';

void main() {
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await getInyecionDependecies();

    runApp(const MyApps());
  }, blocObserver: AppBlocObserver());
}
