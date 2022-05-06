import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_login/src/domain/entity/users.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_login/src/myapp/injeci.dart';
import 'package:test_login/src/myapp/myapp.dart';

import 'package:test_login/src/presentation/bloc_login/cubit/loginusers_cubit.dart';
import 'package:test_login/src/presentation/bloc_login/view/splas_cream.dart';

import '../../helpers/mocks.dart';

class MockLogincubit extends MockCubit<LoginusersState>
    implements LoginusersCubit {}

typedef Callback = Function(MethodCall call);
setupCloudFirestoreMocks([Callback? customHandlers]) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': {},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return {
        'name': call.arguments['appName'],
        'options': call.arguments['options'],
        'pluginConstants': {},
      };
    }

    if (customHandlers != null) {
      customHandlers(call);
    }

    return null;
  });
}

void main() {
  late Users _users;

  late final MockLogincubit mockLogincubit;

  setupCloudFirestoreMocks();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    await getInyecionDependecies();

    _users = MockUsers();
    mockLogincubit = MockLogincubit();
  });
  group('test MyApp', () {
    testWidgets('render Appview', (tester) async {
      await tester.pumpWidget(const MyApps(), const Duration(seconds: 5));
      await tester.pump(const Duration(seconds: 5));

      expect(find.byType(MyApps), findsOneWidget);
    });
  });

  group('test ViewApp', () {
    testWidgets('renders Appview', (tester) async {
      //Todo:opcional si queires pobrar también el Bloclistener

      when(() => mockLogincubit.state)
          .thenReturn(LoginusersState(usaurio: _users));
      await tester.pumpWidget(BlocProvider<LoginusersCubit>(
        create: (_) => mockLogincubit,
        lazy: false,
        child: const MaterialApp(
          home: Appview(),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(LoginInicio), findsOneWidget);
    });
  });
}
