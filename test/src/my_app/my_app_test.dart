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
  // ignore: unused_local_variable
//  late final MockBlocExmaple mockexample;
  late final MockLogincubit mockLogincubit;

  setupCloudFirestoreMocks();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // Timer(const Duration(milliseconds: 100), () async {
    // });
    await Firebase.initializeApp();
    await getInyecionDependecies();

    _users = MockUsers();
    mockLogincubit = MockLogincubit();
    // when(() => _reposiAuthService.user).thenAnswer((_) {
    //   return const Stream.empty();
    // });
    //  when(() => _users. )
  });
  group('test MyApp', () {
    testWidgets('render Appview', (tester) async {
      await tester.pumpWidget(
          const MyApps(
              //  reposiAuthService: _reposiAuthService,
              ),
          const Duration(seconds: 5));
      await tester.pump(const Duration(seconds: 5));

      //  await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byType(MyApps), findsOneWidget);
    });
  });

  group('test ViewApp', () {
    // setUp(() {
    //   _users = MockUsers();
    //   mockLogincubit = MockLogincubit();

    //   _reposiAuthService = MockReposiAuthService();
    // });

    testWidgets('renders Appview', (tester) async {
      //Todo:opcional si queires pobrar también el Bloclistener
      // whenListen(
      //     mockexample,
      //     Stream.fromIterable([
      //       const BlocexampleState(),
      //       const BlocexampleState(
      //           statusAuth: Page2Status.NoAthenticate, users: isers)
      //     ]));
      //  when(() => mockexample.state).thenReturn(BlocexampleState(users: _users));
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
